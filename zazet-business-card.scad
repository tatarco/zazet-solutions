// ═══════════════════════════════════════════════════════════════════
// ZaZet Solutions — 3D Printed Business Card
// ═══════════════════════════════════════════════════════════════════
//
//  Dimensions : 85.6 × 54 mm  (ISO 7810 ID-1 / standard)
//  Thickness  : 1.6 mm total
//
//  TWO-COLOR PRINT — single extruder with filament swap:
//    Color 1 (Navy blue) : z = 0.0 → 0.8 mm  (layers 1-4)
//    Color 2 (Gold/yellow): z = 0.8 → 1.6 mm  (layers 5-8)
//
//  Slicer settings:
//    Layer height : 0.2 mm
//    Nozzle       : 0.4 mm
//    Infill       : 100%
//    Add PAUSE at z = 0.8 mm → swap filament to gold/yellow
//    Print face-up, no supports required
//
//  Suggested filaments:
//    Color 1: eSUN PLA+ Navy Blue / Prusament Prusa Galaxy Black
//    Color 2: eSUN PLA+ Gold / Bambu PLA Basic Bambu Yellow
//
//  After printing: optional clear coat spray for rigidity
// ═══════════════════════════════════════════════════════════════════

// ── Dimensions ──────────────────────────────────────────────────
CARD_W  = 85.6;   // width  (mm)
CARD_H  = 54.0;   // height (mm)
T_BASE  = 0.8;    // base layer  — Color 1 (navy)
T_RAISE = 0.8;    // raised layer — Color 2 (gold)
CORNER  = 3.2;    // corner radius

// ── Fonts ────────────────────────────────────────────────────────
// Change if not installed:  openscad --info  lists available fonts
FONT_BOLD = "Liberation Sans:style=Bold";
FONT_REG  = "Liberation Sans:style=Regular";
FONT_LIGHT = "Liberation Sans:style=Regular";

// ── Contact strings (edit here) ─────────────────────────────────
NAME     = "Gal Tidhar";
COMPANY  = "ZaZet Solutions";
TITLE_1  = "Software Engineer & Builder";
EMAIL    = "gal@zazet-solutions.hr";
WEB      = "zazet-solutions.hr";
LINKEDIN = "linkedin.com/in/galtidhar";

// ────────────────────────────────────────────────────────────────
// INTERNALS — no need to edit below
// ────────────────────────────────────────────────────────────────
e = 0.01;  // epsilon for boolean overlap

// Rounded card outline at given thickness
module card_outline(h) {
    hull()
        for (x = [CORNER, CARD_W - CORNER],
             y = [CORNER, CARD_H - CORNER])
            translate([x, y, 0])
                cylinder(r=CORNER, h=h, $fn=64);
}

// ── LAYER 1: Card base (Color 1 — navy) ─────────────────────────
module base_layer() {
    card_outline(T_BASE);
}

// ── Logo mark (top-left) ─────────────────────────────────────────
//
//  The ZaZet logo is a vertical rectangle split:
//    top 30% = blue  →  rendered as a CUT into the gold block,
//                       exposing the navy base beneath
//    bottom 70% = gold → solid raised gold block
//
//  This faithfully recreates the brand color ratio in 3D.
//
module logo_mark() {
    lx = 6.5;    // left margin
    ly = 32.5;   // bottom y of logo block
    lw = 15.0;   // logo width
    lh = 16.0;   // logo total height
    r  = 1.5;    // logo corner radius

    split = 0.30;             // top 30% = blue (cut)
    cut_h = lh * split;       // ~4.8 mm cut from top
    gold_h = lh * (1 - split); // ~11.2 mm solid gold

    translate([lx, ly, T_BASE]) {
        // Gold block (bottom 70%)
        hull()
            for (x = [r, lw-r], y = [r, gold_h-r])
                translate([x, y, 0])
                    cylinder(r=r, h=T_RAISE, $fn=32);

        // Thin gold top cap — just the frame of the blue zone
        // (left, right, and top borders, ~0.9 mm wide)
        bw = 0.9;
        union() {
            // left border of blue zone
            translate([0, gold_h, 0])
                cube([bw, cut_h, T_RAISE]);
            // right border
            translate([lw - bw, gold_h, 0])
                cube([bw, cut_h, T_RAISE]);
            // top cap (with rounded corner)
            hull()
                for (x = [r, lw-r])
                    translate([x, ly + lh - CORNER*0.5 - ly, 0])
                        cylinder(r=r*0.6, h=T_RAISE, $fn=32);
        }

        // Horizontal split line (visible divider between blue/gold)
        translate([0, gold_h - 0.4, 0])
            cube([lw, 0.8, T_RAISE * 0.6]);
    }
}

// "ZZ" label inside the gold zone of the logo mark
module logo_zz() {
    lx = 7.8;
    ly_gold_center = 32.5 + (16.0 * 0.70) / 2 - 2;
    translate([lx, ly_gold_center, T_BASE])
        linear_extrude(T_RAISE + e)
            text("ZZ", size=8.0, font=FONT_BOLD,
                 halign="left", valign="center");
}

// ── LAYER 2: All raised text (Color 2 — gold) ────────────────────
module raised_elements() {
    // Company name — top right
    translate([27.5, 46.5, T_BASE])
        linear_extrude(T_RAISE)
            text(COMPANY, size=4.0, font=FONT_BOLD,
                 halign="left", valign="center");

    // Person name — large, prominent
    translate([27.5, 40.0, T_BASE])
        linear_extrude(T_RAISE)
            text(NAME, size=5.6, font=FONT_BOLD,
                 halign="left", valign="center");

    // Title
    translate([27.5, 34.5, T_BASE])
        linear_extrude(T_RAISE)
            text(TITLE_1, size=2.6, font=FONT_REG,
                 halign="left", valign="center");

    // Horizontal rule
    translate([6.5, 29.8, T_BASE])
        cube([CARD_W - 13, 0.55, T_RAISE * 0.55]);

    // Contact block — bottom of card
    translate([6.5, 14.5, T_BASE])
        linear_extrude(T_RAISE)
            text(EMAIL, size=2.3, font=FONT_REG,
                 halign="left", valign="center");

    translate([6.5, 10.5, T_BASE])
        linear_extrude(T_RAISE)
            text(WEB, size=2.3, font=FONT_REG,
                 halign="left", valign="center");

    translate([6.5, 6.5, T_BASE])
        linear_extrude(T_RAISE)
            text(LINKEDIN, size=2.2, font=FONT_REG,
                 halign="left", valign="center");
}

// ── Assembly ─────────────────────────────────────────────────────
base_layer();

// Clip all raised geometry to card boundary
intersection() {
    union() {
        logo_mark();
        logo_zz();
        raised_elements();
    }
    // Bounding volume = card footprint at raised height
    translate([0, 0, T_BASE - e])
        card_outline(T_RAISE + 2*e);
}
