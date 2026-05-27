// ═══════════════════════════════════════════════════════════════════
// ZaZet Solutions — 3D Printed Business Card  v3
// ═══════════════════════════════════════════════════════════════════
//
//  Standard ISO 7810 ID-1: 85.6 × 54 mm  |  Total: 1.6 mm thick
//
//  THREE COLORS — AMS / multi-material:
//    COLOR 1  Navy blue  — card base  (z 0 → 0.8 mm)
//    COLOR 2  Gold       — all raised text + logo bottom 70% + QR code
//    COLOR 3  Blue       — logo "ZaZet" top 30%
//
//  QR code links to: https://zazet-solutions.hr
//  Bottom-right corner, 18×18 mm (25×25 modules @ 0.72 mm each)
// ═══════════════════════════════════════════════════════════════════

COLOR = 1; // ← 1=navy  2=gold  3=blue

CARD_W = 85.6;
CARD_H = 54.0;
T      = 0.8;
CR     = 3.2;
e      = 0.01;

FB  = "Liberation Sans:style=Bold";
FR  = "Liberation Sans:style=Regular";
FI  = "Liberation Sans:style=Italic";

NAME    = "Gal Tidhar";
TITLE1  = "Software Engineer";
TITLE2  = "& Builder";
TAGLINE = "Less chaos. More business.";
EMAIL   = "gal@zazet-solutions.hr";
WEB     = "zazet-solutions.hr";
LI      = "linkedin.com/in/galtidhar";

LX      = 6.5;
LY      = 33.5;
LSIZE   = 11;
LCAP    = LSIZE * 0.72;
LSPLIT  = LY + LCAP * 0.70;   // ≈ 39.1 — y where gold ends / blue starts

// QR code position (bottom-right)
QR_X    = 59.0;   // left edge of QR
QR_Y    = 4.5;    // bottom edge of QR
QR_H    = T;      // same height as all raised elements

// ─────────────────────────────────────────────────────────────────
module card_outline(h) {
    hull()
        for (x = [CR, CARD_W-CR], y = [CR, CARD_H-CR])
            translate([x, y, 0])
                cylinder(r=CR, h=h, $fn=64);
}

module zazet_gold() {
    intersection() {
        translate([LX, LY, 0])
            linear_extrude(T + e)
                text("ZaZet", size=LSIZE, font=FB,
                     halign="left", valign="bottom");
        cube([CARD_W, LSPLIT, T + 2*e]);
    }
}

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

module gold_text() {
    // "SOLUTIONS" subtitle
    translate([LX, 28.2, 0])
        linear_extrude(T * 0.7)
            text("SOLUTIONS", size=3.0, font=FB, spacing=1.35,
                 halign="left", valign="bottom");

    // Vertical rule — logo | name
    translate([43.5, 26.5, 0]) cube([0.55, 23.5, T * 0.65]);

    // Name
    translate([46.5, 44.0, 0])
        linear_extrude(T)
            text(NAME, size=5.0, font=FB, halign="left", valign="center");

    // Title
    translate([46.5, 38.0, 0])
        linear_extrude(T)
            text(TITLE1, size=2.5, font=FR, halign="left", valign="center");
    translate([46.5, 34.5, 0])
        linear_extrude(T)
            text(TITLE2, size=2.5, font=FR, halign="left", valign="center");

    // Main horizontal rule
    translate([6.5, 25.5, 0]) cube([CARD_W - 13, 0.5, T * 0.55]);

    // Tagline — left-aligned below rule, italic
    translate([6.5, 21.5, 0])
        linear_extrude(T * 0.75)
            text(TAGLINE, size=2.8, font=FI, halign="left", valign="center");

    // Thin rule between tagline and contact
    translate([6.5, 18.2, 0]) cube([47.5, 0.32, T * 0.45]);

    // Contact info (left column, 3 lines)
    translate([6.5, 14.5, 0]) linear_extrude(T * 0.7)
        text(EMAIL, size=2.2, font=FR, halign="left", valign="center");
    translate([6.5, 10.5, 0]) linear_extrude(T * 0.7)
        text(WEB,   size=2.2, font=FR, halign="left", valign="center");
    translate([6.5,  6.5, 0]) linear_extrude(T * 0.7)
        text(LI,    size=2.2, font=FR, halign="left", valign="center");

    // Vertical rule — contact | QR
    translate([56.0, 4.0, 0]) cube([0.45, 21.0, T * 0.55]);

    // QR code — bottom right corner
    qr_code(QR_X, QR_Y, QR_H);
}

// ─────────────────────────────────────────────────────────────────
// Auto-generated QR code — https://zazet-solutions.hr
// Version 2, 25×25 modules, 0.72mm per module
module qr_code(x0, y0, h, e=0.01) {
  translate([x0, y0, 0]) {
  translate([0.0000,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([0.7200,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([1.4400,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([2.1600,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([2.8800,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([3.6000,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([6.4800,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([7.2000,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([7.9200,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([9.3600,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([13.6800,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([15.1200,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([15.8400,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([16.5600,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,17.2800,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,16.5600,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,16.5600,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,16.5600,0]) cube([0.72,0.72,h+e]);
  translate([6.4800,16.5600,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,16.5600,0]) cube([0.72,0.72,h+e]);
  translate([9.3600,16.5600,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,16.5600,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,16.5600,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([1.4400,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([2.1600,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([2.8800,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([7.2000,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([7.9200,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([9.3600,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([10.0800,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([10.8000,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([15.1200,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([15.8400,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,15.8400,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,15.1200,0]) cube([0.72,0.72,h+e]);
  translate([1.4400,15.1200,0]) cube([0.72,0.72,h+e]);
  translate([2.1600,15.1200,0]) cube([0.72,0.72,h+e]);
  translate([2.8800,15.1200,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,15.1200,0]) cube([0.72,0.72,h+e]);
  translate([6.4800,15.1200,0]) cube([0.72,0.72,h+e]);
  translate([9.3600,15.1200,0]) cube([0.72,0.72,h+e]);
  translate([10.8000,15.1200,0]) cube([0.72,0.72,h+e]);
  translate([11.5200,15.1200,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,15.1200,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,15.1200,0]) cube([0.72,0.72,h+e]);
  translate([15.1200,15.1200,0]) cube([0.72,0.72,h+e]);
  translate([15.8400,15.1200,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,15.1200,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,14.4000,0]) cube([0.72,0.72,h+e]);
  translate([1.4400,14.4000,0]) cube([0.72,0.72,h+e]);
  translate([2.1600,14.4000,0]) cube([0.72,0.72,h+e]);
  translate([2.8800,14.4000,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,14.4000,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,14.4000,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,14.4000,0]) cube([0.72,0.72,h+e]);
  translate([11.5200,14.4000,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,14.4000,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,14.4000,0]) cube([0.72,0.72,h+e]);
  translate([15.1200,14.4000,0]) cube([0.72,0.72,h+e]);
  translate([15.8400,14.4000,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,14.4000,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,13.6800,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,13.6800,0]) cube([0.72,0.72,h+e]);
  translate([7.9200,13.6800,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,13.6800,0]) cube([0.72,0.72,h+e]);
  translate([10.0800,13.6800,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,13.6800,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,13.6800,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([0.7200,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([1.4400,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([2.1600,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([2.8800,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([3.6000,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([7.2000,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([10.0800,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([11.5200,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([13.6800,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([15.1200,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([15.8400,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([16.5600,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,12.9600,0]) cube([0.72,0.72,h+e]);
  translate([7.2000,12.2400,0]) cube([0.72,0.72,h+e]);
  translate([7.9200,12.2400,0]) cube([0.72,0.72,h+e]);
  translate([9.3600,12.2400,0]) cube([0.72,0.72,h+e]);
  translate([10.0800,12.2400,0]) cube([0.72,0.72,h+e]);
  translate([10.8000,12.2400,0]) cube([0.72,0.72,h+e]);
  translate([11.5200,12.2400,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([2.1600,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([2.8800,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([3.6000,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([5.0400,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([6.4800,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([7.2000,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([10.0800,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([11.5200,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([12.2400,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([15.8400,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([16.5600,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,11.5200,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,10.8000,0]) cube([0.72,0.72,h+e]);
  translate([1.4400,10.8000,0]) cube([0.72,0.72,h+e]);
  translate([5.0400,10.8000,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,10.8000,0]) cube([0.72,0.72,h+e]);
  translate([7.2000,10.8000,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,10.8000,0]) cube([0.72,0.72,h+e]);
  translate([9.3600,10.8000,0]) cube([0.72,0.72,h+e]);
  translate([10.0800,10.8000,0]) cube([0.72,0.72,h+e]);
  translate([10.8000,10.8000,0]) cube([0.72,0.72,h+e]);
  translate([13.6800,10.8000,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,10.8000,0]) cube([0.72,0.72,h+e]);
  translate([15.1200,10.8000,0]) cube([0.72,0.72,h+e]);
  translate([15.8400,10.8000,0]) cube([0.72,0.72,h+e]);
  translate([16.5600,10.8000,0]) cube([0.72,0.72,h+e]);
  translate([0.7200,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([1.4400,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([2.8800,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([3.6000,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([5.0400,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([6.4800,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([7.2000,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([7.9200,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([10.0800,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([10.8000,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([11.5200,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([12.2400,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([15.1200,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,10.0800,0]) cube([0.72,0.72,h+e]);
  translate([3.6000,9.3600,0]) cube([0.72,0.72,h+e]);
  translate([5.0400,9.3600,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,9.3600,0]) cube([0.72,0.72,h+e]);
  translate([6.4800,9.3600,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,9.3600,0]) cube([0.72,0.72,h+e]);
  translate([10.0800,9.3600,0]) cube([0.72,0.72,h+e]);
  translate([10.8000,9.3600,0]) cube([0.72,0.72,h+e]);
  translate([11.5200,9.3600,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,9.3600,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,9.3600,0]) cube([0.72,0.72,h+e]);
  translate([15.1200,9.3600,0]) cube([0.72,0.72,h+e]);
  translate([15.8400,9.3600,0]) cube([0.72,0.72,h+e]);
  translate([16.5600,9.3600,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,9.3600,0]) cube([0.72,0.72,h+e]);
  translate([2.8800,8.6400,0]) cube([0.72,0.72,h+e]);
  translate([3.6000,8.6400,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,8.6400,0]) cube([0.72,0.72,h+e]);
  translate([5.0400,8.6400,0]) cube([0.72,0.72,h+e]);
  translate([7.2000,8.6400,0]) cube([0.72,0.72,h+e]);
  translate([7.9200,8.6400,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,8.6400,0]) cube([0.72,0.72,h+e]);
  translate([10.8000,8.6400,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,8.6400,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,8.6400,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,7.9200,0]) cube([0.72,0.72,h+e]);
  translate([1.4400,7.9200,0]) cube([0.72,0.72,h+e]);
  translate([2.8800,7.9200,0]) cube([0.72,0.72,h+e]);
  translate([3.6000,7.9200,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,7.9200,0]) cube([0.72,0.72,h+e]);
  translate([10.0800,7.9200,0]) cube([0.72,0.72,h+e]);
  translate([10.8000,7.9200,0]) cube([0.72,0.72,h+e]);
  translate([11.5200,7.9200,0]) cube([0.72,0.72,h+e]);
  translate([12.2400,7.9200,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,7.9200,0]) cube([0.72,0.72,h+e]);
  translate([16.5600,7.9200,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,7.2000,0]) cube([0.72,0.72,h+e]);
  translate([0.7200,7.2000,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,7.2000,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,7.2000,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,7.2000,0]) cube([0.72,0.72,h+e]);
  translate([10.0800,7.2000,0]) cube([0.72,0.72,h+e]);
  translate([10.8000,7.2000,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,7.2000,0]) cube([0.72,0.72,h+e]);
  translate([15.1200,7.2000,0]) cube([0.72,0.72,h+e]);
  translate([15.8400,7.2000,0]) cube([0.72,0.72,h+e]);
  translate([16.5600,7.2000,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,7.2000,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,6.4800,0]) cube([0.72,0.72,h+e]);
  translate([1.4400,6.4800,0]) cube([0.72,0.72,h+e]);
  translate([2.1600,6.4800,0]) cube([0.72,0.72,h+e]);
  translate([3.6000,6.4800,0]) cube([0.72,0.72,h+e]);
  translate([5.0400,6.4800,0]) cube([0.72,0.72,h+e]);
  translate([6.4800,6.4800,0]) cube([0.72,0.72,h+e]);
  translate([7.2000,6.4800,0]) cube([0.72,0.72,h+e]);
  translate([7.9200,6.4800,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,6.4800,0]) cube([0.72,0.72,h+e]);
  translate([13.6800,6.4800,0]) cube([0.72,0.72,h+e]);
  translate([15.1200,6.4800,0]) cube([0.72,0.72,h+e]);
  translate([15.8400,6.4800,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,6.4800,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([1.4400,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([2.1600,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([2.8800,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([7.2000,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([7.9200,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([9.3600,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([11.5200,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([12.2400,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([13.6800,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([15.8400,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([16.5600,5.7600,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,5.0400,0]) cube([0.72,0.72,h+e]);
  translate([7.2000,5.0400,0]) cube([0.72,0.72,h+e]);
  translate([9.3600,5.0400,0]) cube([0.72,0.72,h+e]);
  translate([11.5200,5.0400,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,5.0400,0]) cube([0.72,0.72,h+e]);
  translate([15.8400,5.0400,0]) cube([0.72,0.72,h+e]);
  translate([16.5600,5.0400,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,4.3200,0]) cube([0.72,0.72,h+e]);
  translate([0.7200,4.3200,0]) cube([0.72,0.72,h+e]);
  translate([1.4400,4.3200,0]) cube([0.72,0.72,h+e]);
  translate([2.1600,4.3200,0]) cube([0.72,0.72,h+e]);
  translate([2.8800,4.3200,0]) cube([0.72,0.72,h+e]);
  translate([3.6000,4.3200,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,4.3200,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,4.3200,0]) cube([0.72,0.72,h+e]);
  translate([7.9200,4.3200,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,4.3200,0]) cube([0.72,0.72,h+e]);
  translate([11.5200,4.3200,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,4.3200,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,4.3200,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,4.3200,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,3.6000,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,3.6000,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,3.6000,0]) cube([0.72,0.72,h+e]);
  translate([6.4800,3.6000,0]) cube([0.72,0.72,h+e]);
  translate([7.2000,3.6000,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,3.6000,0]) cube([0.72,0.72,h+e]);
  translate([9.3600,3.6000,0]) cube([0.72,0.72,h+e]);
  translate([10.0800,3.6000,0]) cube([0.72,0.72,h+e]);
  translate([11.5200,3.6000,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,3.6000,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([1.4400,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([2.1600,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([2.8800,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([7.2000,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([7.9200,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([10.0800,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([10.8000,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([11.5200,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([12.2400,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([13.6800,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,2.8800,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,2.1600,0]) cube([0.72,0.72,h+e]);
  translate([1.4400,2.1600,0]) cube([0.72,0.72,h+e]);
  translate([2.1600,2.1600,0]) cube([0.72,0.72,h+e]);
  translate([2.8800,2.1600,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,2.1600,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,2.1600,0]) cube([0.72,0.72,h+e]);
  translate([6.4800,2.1600,0]) cube([0.72,0.72,h+e]);
  translate([7.2000,2.1600,0]) cube([0.72,0.72,h+e]);
  translate([7.9200,2.1600,0]) cube([0.72,0.72,h+e]);
  translate([11.5200,2.1600,0]) cube([0.72,0.72,h+e]);
  translate([12.2400,2.1600,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,2.1600,0]) cube([0.72,0.72,h+e]);
  translate([16.5600,2.1600,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,2.1600,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([1.4400,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([2.1600,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([2.8800,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([7.2000,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([7.9200,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([9.3600,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([10.0800,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([12.2400,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([15.1200,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([15.8400,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([16.5600,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,1.4400,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,0.7200,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,0.7200,0]) cube([0.72,0.72,h+e]);
  translate([6.4800,0.7200,0]) cube([0.72,0.72,h+e]);
  translate([10.0800,0.7200,0]) cube([0.72,0.72,h+e]);
  translate([10.8000,0.7200,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,0.7200,0]) cube([0.72,0.72,h+e]);
  translate([13.6800,0.7200,0]) cube([0.72,0.72,h+e]);
  translate([14.4000,0.7200,0]) cube([0.72,0.72,h+e]);
  translate([15.8400,0.7200,0]) cube([0.72,0.72,h+e]);
  translate([16.5600,0.7200,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,0.7200,0]) cube([0.72,0.72,h+e]);
  translate([0.0000,0.0000,0]) cube([0.72,0.72,h+e]);
  translate([0.7200,0.0000,0]) cube([0.72,0.72,h+e]);
  translate([1.4400,0.0000,0]) cube([0.72,0.72,h+e]);
  translate([2.1600,0.0000,0]) cube([0.72,0.72,h+e]);
  translate([2.8800,0.0000,0]) cube([0.72,0.72,h+e]);
  translate([3.6000,0.0000,0]) cube([0.72,0.72,h+e]);
  translate([4.3200,0.0000,0]) cube([0.72,0.72,h+e]);
  translate([5.7600,0.0000,0]) cube([0.72,0.72,h+e]);
  translate([8.6400,0.0000,0]) cube([0.72,0.72,h+e]);
  translate([10.0800,0.0000,0]) cube([0.72,0.72,h+e]);
  translate([11.5200,0.0000,0]) cube([0.72,0.72,h+e]);
  translate([12.9600,0.0000,0]) cube([0.72,0.72,h+e]);
  translate([15.1200,0.0000,0]) cube([0.72,0.72,h+e]);
  translate([17.2800,0.0000,0]) cube([0.72,0.72,h+e]);
  }
}

// ─────────────────────────────────────────────────────────────────
// ASSEMBLY
// ─────────────────────────────────────────────────────────────────

if (COLOR == 1) {
    card_outline(T);
}
if (COLOR == 2) {
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
    translate([0, 0, T])
        intersection() {
            zazet_blue();
            translate([0, 0, -e]) card_outline(T + 2*e);
        }
}
