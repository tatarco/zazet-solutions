"""
ZaZet Solutions — Fidget Spinner Business Card — AMS 3MF builder
Every text line + QR code is a SEPARATE object → easy to reposition in Bambu Studio.

Filament 1 (Black)  → card base + buttons
Filament 2 (Yellow) → every raised element (each is its own mesh)

Usage: python3 _make_card_3mf.py
"""

import subprocess, struct, zipfile, tempfile, sys, re
from pathlib import Path
import qrcode

# ─── personalisation ─────────────────────────────────────────────────────────
PHONE    = "+385 99 190 4995"
EMAIL    = "gal@zazet-solutions.hr"
WEBSITE  = "zazet-solutions.hr"
TAGLINE  = "8 parts impact. 2 parts code."
QR_URL   = "https://zazet-solutions.hr"
# ─────────────────────────────────────────────────────────────────────────────

OUT = Path(__file__).parent / "zazet_business_card-v3.3mf"

# card geometry
CW, CH, CT = 88.9, 50.8, 0.6
CR, HOLE_D  = 5, 7.5
TT          = 0.8    # text relief height
B           = 0.20   # stroke bold inflation (mm)
FN          = 80

# button geometry
FD=13.8; FT=0.5; BOD=7.25; BID=5.0; TOD=5.05; CONN=1.0
BTN_Y = -CH/2 - FD - 5

# QR matrix
_qr = qrcode.QRCode(error_correction=qrcode.constants.ERROR_CORRECT_M,
                    box_size=1, border=1)
_qr.add_data(QR_URL)
_qr.make(fit=True)
QR_MATRIX = _qr.get_matrix()
QR_N      = len(QR_MATRIX)     # 27
QR_MOD    = 0.68
QR_SIZE   = QR_N * QR_MOD      # ~18.4 mm
QR_X      = CW/2 - 4 - QR_SIZE # right-aligned
QR_Y      = -QR_SIZE / 2        # vertically centred

def qr_scad() -> str:
    lines = [f"$fn={FN}; CT={CT}; TT={TT};", "union() {"]
    for r, row in enumerate(QR_MATRIX):
        for c, dark in enumerate(row):
            if dark:
                x = QR_X + c * QR_MOD
                y = QR_Y + (QR_N - 1 - r) * QR_MOD
                lines.append(
                    f"  translate([{x:.3f},{y:.3f},CT])"
                    f" cube([{QR_MOD:.3f},{QR_MOD:.3f},TT]);")
    lines.append("}")
    return "\n".join(lines)

# text x anchor
LX = -CW/2 + 3
# right boundary before QR zone
LX_MAX = QR_X - 3
SEP_W  = LX_MAX - LX

def txt(content, size, y, bold_mult=1.0, extra=""):
    """One linear_extrude text block, left-aligned at LX."""
    return (f"$fn={FN}; CT={CT}; TT={TT}; B={B};\n"
            f"translate([{LX:.3f},{y:.3f},CT]) linear_extrude(TT)\n"
            f"  offset(r=B*{bold_mult}) text(\"{content}\", size={size},\n"
            f"    font=\"Liberation Sans:style=Bold\","
            f" halign=\"left\", valign=\"bottom\");{extra}")

# Y positions (bottom of each text block, measured from card centre)
# Card runs from -25.4 to +25.4 in Y
Y_NAME     = CH/2 - 5   - 7     # top-left name baseline
Y_COMPANY  = Y_NAME    - 8.5
Y_TAGLINE  = Y_COMPANY - 5.5
Y_SEP      = Y_TAGLINE - 3.2    # separator bar top
Y_PHONE    = Y_SEP     - 4.5
Y_EMAIL    = Y_PHONE   - 4.0
Y_WEBSITE  = Y_EMAIL   - 4.0

# ── SCAD per object ──────────────────────────────────────────────────────────
PARTS = [
    # (name, extruder, scad)
    ("Card Base", 1,
     f"$fn={FN}; CW={CW}; CH={CH}; CT={CT}; CR={CR}; HD={HOLE_D}; FD={FD}; FT={FT};\n"
     f"difference() {{\n"
     f"  translate([0,0,CT/2]) linear_extrude(CT,center=true)\n"
     f"  offset(r=CR) square([CW-2*CR,CH-2*CR],center=true);\n"
     f"  translate([0,0,-1]) cylinder(h=CT+2,d=HD);\n"
     f"  translate([0,0,CT-FT]) cylinder(h=FT+0.01,d=FD);\n"
     f"}}"),

    ("Buttons", 1,
     f"$fn={FN}; FD={FD}; FT={FT}; BOD={BOD}; BID={BID}; TOD={TOD}; CH={CONN}; BY={BTN_Y:.3f};\n"
     f"translate([-10,BY,0]) difference() {{\n"
     f"  union() {{ cylinder(h=FT,d=FD); translate([0,0,FT]) cylinder(h=CH,d=BOD); }}\n"
     f"  translate([0,0,FT-0.1]) cylinder(h=CH+0.2,d=BID);\n"
     f"}}\n"
     f"translate([10,BY,0]) union() {{\n"
     f"  cylinder(h=FT,d=FD);\n"
     f"  translate([0,0,FT]) cylinder(h=CH,d=TOD);\n"
     f"}}"),

    ("Name", 2,       txt("Gal Tidhar",  7.0, Y_NAME,    bold_mult=1.0)),
    ("Company", 2,    txt("ZaZet Solutions", 4.2, Y_COMPANY, bold_mult=1.0)),
    ("Tagline", 2,    txt(TAGLINE,        2.6, Y_TAGLINE,  bold_mult=0.8)),

    ("Separator", 2,
     f"$fn={FN}; CT={CT}; TT={TT};\n"
     f"translate([{LX:.3f},{Y_SEP:.3f},CT]) cube([{SEP_W:.2f},0.6,TT]);"),

    ("Phone", 2,      txt(PHONE,   2.8, Y_PHONE,   bold_mult=0.7)),
    ("Email", 2,      txt(EMAIL,   2.6, Y_EMAIL,   bold_mult=0.7)),
    ("Website", 2,    txt(WEBSITE, 2.8, Y_WEBSITE, bold_mult=0.7)),
    ("QR Code", 2,    qr_scad()),
]

# ── STL helpers ───────────────────────────────────────────────────────────────
def render_stl(scad: str, label: str) -> Path:
    ts = Path(tempfile.mktemp(suffix=".scad"))
    to = Path(tempfile.mktemp(suffix=".stl"))
    ts.write_text(scad)
    print(f"  {label}...", end=" ", flush=True)
    r = subprocess.run(["openscad", "-o", str(to), str(ts)],
                       capture_output=True, text=True)
    ts.unlink(missing_ok=True)
    if r.returncode != 0:
        print(f"FAILED\n{r.stderr[-1000:]}"); sys.exit(1)
    print("ok")
    return to

def parse_stl(path: Path):
    data = path.read_bytes()
    if data[:5] == b"solid" and b"facet" in data[:200]:
        verts = re.findall(
            r"vertex\s+([\-\d.eE+]+)\s+([\-\d.eE+]+)\s+([\-\d.eE+]+)",
            data.decode("utf-8", errors="ignore"))
        return [tuple(tuple(float(x) for x in verts[i+j]) for j in range(3))
                for i in range(0, len(verts)-2, 3)]
    n = struct.unpack_from("<I", data, 80)[0]
    tris, off = [], 84
    for _ in range(n):
        off += 12
        v0 = struct.unpack_from("<fff", data, off); off += 12
        v1 = struct.unpack_from("<fff", data, off); off += 12
        v2 = struct.unpack_from("<fff", data, off); off += 12
        off += 2
        tris.append((v0, v1, v2))
    return tris

def mesh_xml(obj_id, name, tris):
    idx, verts, tidx = {}, [], []
    for tri in tris:
        row = []
        for v in tri:
            k = (round(v[0],5), round(v[1],5), round(v[2],5))
            if k not in idx:
                idx[k] = len(verts); verts.append(k)
            row.append(idx[k])
        tidx.append(row)
    vx = "\n".join(f'        <vertex x="{v[0]}" y="{v[1]}" z="{v[2]}"/>' for v in verts)
    tx = "\n".join(f'        <triangle v1="{t[0]}" v2="{t[1]}" v3="{t[2]}"/>' for t in tidx)
    return (f'  <object id="{obj_id}" type="model" name="{name}">\n'
            f'    <mesh>\n      <vertices>\n{vx}\n      </vertices>\n'
            f'      <triangles>\n{tx}\n      </triangles>\n    </mesh>\n  </object>')

# ── 3MF assembly ──────────────────────────────────────────────────────────────
CT_XML = ('<?xml version="1.0" encoding="UTF-8"?>\n'
'<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">\n'
'  <Default Extension="rels"   ContentType="application/vnd.openxmlformats-package.relationships+xml"/>\n'
'  <Default Extension="model"  ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml"/>\n'
'  <Default Extension="config" ContentType="application/xml"/>\n</Types>')

RELS_XML = ('<?xml version="1.0" encoding="UTF-8"?>\n'
'<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">\n'
'  <Relationship Target="/3D/3dmodel.model" Id="rel0"\n'
'    Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/>\n'
'</Relationships>')

def build():
    print(f"Building — {len(PARTS)} objects, QR={QR_N}×{QR_N} ({QR_SIZE:.1f}mm)\n")

    objs, items, cfg = [], [], []
    for i, (name, extruder, scad) in enumerate(PARTS):
        stl  = render_stl(scad, name)
        tris = parse_stl(stl)
        stl.unlink(missing_ok=True)
        oid  = i + 1
        print(f"    → {len(tris):,} triangles")
        objs.append(mesh_xml(oid, name, tris))
        items.append(f'  <item objectid="{oid}"/>')
        cfg.append(f'  <object id="{oid}">\n'
                   f'    <metadata key="extruder" value="{extruder}"/>\n'
                   f'    <metadata key="name" value="{name}"/>\n  </object>')

    model = ('<?xml version="1.0" encoding="UTF-8"?>\n'
             '<model unit="millimeter" xml:lang="en-US"\n'
             '  xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02">\n'
             '  <resources>\n' + "\n".join(objs) + '\n  </resources>\n'
             '  <build>\n' + "\n".join(items) + '\n  </build>\n</model>')

    settings = ('<?xml version="1.0" encoding="UTF-8"?>\n<config>\n'
                + "\n".join(cfg) + '\n</config>')

    with zipfile.ZipFile(OUT, "w", zipfile.ZIP_DEFLATED) as zf:
        zf.writestr("[Content_Types].xml",            CT_XML)
        zf.writestr("_rels/.rels",                    RELS_XML)
        zf.writestr("3D/3dmodel.model",               model)
        zf.writestr("Metadata/model_settings.config", settings)

    print(f"\n✓  {OUT.name}  ({OUT.stat().st_size//1024} KB)")
    print(f"   Tagline: {TAGLINE}")
    print(f"   Objects: {', '.join(n for n,_,_ in PARTS)}")
    print("\n   AMS:  Slot 1 → Black  |  Slot 2 → Yellow/Gold")

if __name__ == "__main__":
    build()
