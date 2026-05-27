// ═══════════════════════════════════════════════════════════════════
// ZaZet Solutions — 3D Printed Business Card  v2
// ═══════════════════════════════════════════════════════════════════
//
//  Standard ISO 7810 ID-1: 85.6 × 54 mm  |  Total: 1.6 mm thick
//
//  THREE COLORS — AMS / multi-material:
//    COLOR 1  Navy blue  — card base  (z 0 → 0.8 mm)
//    COLOR 2  Gold       — all raised text + logo bottom 70%
//    COLOR 3  Blue       — logo "ZaZet" top 30%  ← faithful brand split
//
//  How the logo split works:
//    The real ZaZet brand gradient is 30% blue (top) / 70% gold (bottom).
//    We cut the raised "ZaZet" wordmark at that y-axis ratio:
//      gold object  = bottom 70% of cap height
//      blue object  = top  30% of cap height
//    Both sit at z = 0.8 → 1.6 mm; the AMS switches color within the
//    same layer — exactly what AMS multi-color printing does.
//
//  Slicer settings (Bambu Studio / OrcaSlicer):
//    Layer height : 0.2 mm
//    Nozzle       : 0.4 mm
//    Infill       : 100%
//    Supports     : none
//    Filament assignment:
//      Object "Navy Base"   → AMS slot 1
//      Object "Gold Raised" → AMS slot 2
//      Object "Blue Logo"   → AMS slot 3
// ═══════════════════════════════════════════════════════════════════

// ── Export control ───────────────────────────────────────────────
// Set COLOR = 1 / 2 / 3 before rendering / exporting each STL.
// Or call with:  openscad -D COLOR=2 -o gold.stl zazet-business-card.scad
COLOR = 1;

// ── Dimensions ──────────────────────────────────────────────────
CARD_W = 85.6;
CARD_H = 54.0;
T      = 0.8;   // layer thickness per color (total = 1.6 mm)
CR     = 3.2;   // corner radius
e      = 0.01;  // epsilon

// ── Fonts ────────────────────────────────────────────────────────
FB  = "Liberation Sans:style=Bold";
FR  = "Liberation Sans:style=Regular";
FI  = "Liberation Sans:style=Italic";

// ── Content ──────────────────────────────────────────────────────
NAME    = "Gal Tidhar";
TITLE1  = "Software Engineer";
TITLE2  = "& Builder";
TAGLINE = "Less chaos. More business.";
EMAIL   = "gal@zazet-solutions.hr";
WEB     = "zazet-solutions.hr";
LI      = "linkedin.com/in/galtidhar";

// ── Logo geometry ────────────────────────────────────────────────
// "ZaZet" wordmark position and colour-split parameters
LX      = 6.5;    // left margin for logo
LY      = 33.5;   // baseline y of "ZaZet"
LSIZE   = 11;     // font size (≈ em height in mm)
// Liberation Sans Bold cap height ≈ 72% of em size
LCAP    = LSIZE * 0.72;            // ≈ 7.92 mm
LSPLIT  = LY + LCAP * 0.70;       // y where gold ends / blue begins ≈ 39.1


// ─────────────────────────────────────────────────────────────────
// MODULES
// ─────────────────────────────────────────────────────────────────

module card_outline(h) {
    hull()
        for (x = [CR, CARD_W-CR], y = [CR, CARD_H-CR])
            translate([x, y, 0])
                cylinder(r=CR, h=h, $fn=64);
}

// "ZaZet" clipped to y < LSPLIT  →  gold (bottom 70%)
module zazet_gold() {
    intersection() {
        translate([LX, LY, 0])
            linear_extrude(T + e)
                text("ZaZet", size=LSIZE, font=FB,
                     halign="left", valign="bottom");
        cube([CARD_W, LSPLIT, T + 2*e]);
    }
}

// "ZaZet" clipped to y ≥ LSPLIT  →  blue (top 30%)
module zazet_blue() {
    intersection() {
        translate([LX, LY, 0])
            linear_extrude(T + e)
                text("ZaZet", size=LSIZE, font=FB,
                     halign="left", valign="bottom");
        translate([0, LSPLIT, -e])
            cube([CARD_W, CARD_H, T + 2*e]);
    }
}

// All gold text and decorative elements (excluding logo wordmark)
module gold_text() {
    // "SOLUTIONS" subtitle under ZaZet
    translate([LX, 28.2, 0])
        linear_extrude(T * 0.7)
            text("SOLUTIONS", size=3.0, font=FB, spacing=1.35,
                 halign="left", valign="bottom");

    // Vertical rule separating logo from name
    translate([43.5, 26.5, 0])
        cube([0.55, 23.5, T * 0.65]);

    // Name
    translate([46.5, 44.0, 0])
        linear_extrude(T)
            text(NAME, size=5.0, font=FB,
                 halign="left", valign="center");

    // Title (two lines)
    translate([46.5, 38.0, 0])
        linear_extrude(T)
            text(TITLE1, size=2.5, font=FR,
                 halign="left", valign="center");
    translate([46.5, 34.5, 0])
        linear_extrude(T)
            text(TITLE2, size=2.5, font=FR,
                 halign="left", valign="center");

    // Main horizontal rule
    translate([6.5, 25.5, 0])
        cube([CARD_W - 13, 0.5, T * 0.55]);

    // Tagline — centered, italic
    translate([CARD_W/2, 20.5, 0])
        linear_extrude(T * 0.75)
            text(TAGLINE, size=2.9, font=FI,
                 halign="center", valign="center");

    // Secondary rule
    translate([6.5, 15.5, 0])
        cube([CARD_W - 13, 0.32, T * 0.45]);

    // Contact info
    translate([6.5, 12.0, 0]) linear_extrude(T * 0.7)
        text(EMAIL, size=2.2, font=FR, halign="left", valign="center");
    translate([6.5,  8.0, 0]) linear_extrude(T * 0.7)
        text(WEB,   size=2.2, font=FR, halign="left", valign="center");
    translate([6.5,  4.0, 0]) linear_extrude(T * 0.7)
        text(LI,    size=2.2, font=FR, halign="left", valign="center");
}


// ─────────────────────────────────────────────────────────────────
// ASSEMBLY  (select via COLOR variable)
// ─────────────────────────────────────────────────────────────────

if (COLOR == 1) {
    // ── Navy base ───────────────────────────────────────────────
    card_outline(T);
}

if (COLOR == 2) {
    // ── Gold raised layer ────────────────────────────────────────
    translate([0, 0, T])
        intersection() {
            union() {
                zazet_gold();
                gold_text();
            }
            translate([0, 0, -e]) card_outline(T + 2*e);
        }
}

if (COLOR == 3) {
    // ── Blue logo accent (ZaZet top 30%) ────────────────────────
    translate([0, 0, T])
        intersection() {
            zazet_blue();
            translate([0, 0, -e]) card_outline(T + 2*e);
        }
}
