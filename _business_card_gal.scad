/* ============================================================
   ZaZet Solutions — Fidget Spinner Business Card
   Based on FSBC.scad (Parametric Fidget Spinner Business Card)
   Original source: Makerworld / FSBC

   Print instructions:
     1. Slice with 0.2mm layers
     2. Pause at Z = 0.6mm → swap filament to Yellow/Gold
     3. Resume — raised text prints in the second color
     4. Print the two buttons (Print_Plate = 2) separately if needed
     5. Press a 608 bearing into the center hole, snap buttons on
   ============================================================ */

/* [ Customization: Text ] */
Name    = "GAL TIDHAR";
Title   = "ZaZet Solutions";
Tagline = "8 parts impact. 2 parts code.";
Phone   = "ZAZET-SOLUTIONS.HR";
Email   = "GAL@ZAZET-SOLUTIONS.HR";

/* [ Customization: Colors ] */
Base_Color = "Black";   // [White, Black, Red, Blue, Green, Yellow, Orange, Purple, Gray]
Top_Color  = "Yellow";  // [White, Black, Red, Blue, Green, Yellow, Orange, Purple, Gray]
// The Z-height where the filament swap happens (pause print here)
Color_Swap_Z = 0.6;

/* [ Customization: Sizing ] */
Name_Size  = 6;   // [4:0.5:15]
Title_Size = 3.5; // [2:0.5:10]
Phone_Size = 3.5; // [2:0.5:10]
Email_Size = 3.2; // [2:0.5:10]  — slightly smaller so the full address fits
// How much the text sticks up for color swapping (0.6mm = 3 layers at 0.2mm)
Text_Thickness = 0.6; // [0.2:0.1:1.2]

/* [ Print Layout ] */
// 0 = Everything, 1 = Card Only, 2 = Buttons Only
Print_Plate = 0; // [0,1,2]

/* [ Hidden Data (SolidWorks Specs) ] */
Card_W = 88.9;
Card_H = 50.8;
Card_T = 0.6;
Corner_R = 5;
Center_Hole_D = 7.5;  // fits a standard 608 bearing inner race

Flange_D    = 13.8;
Flange_T    = 0.5;
Bot_Post_OD = 7.25;
Bot_Post_ID = 5.0;
Top_Post_OD = 5.05;   // 0.05mm interference fit
Connector_H = 1.0;

$fn = 100;

// --- COLOR SPLIT LOGIC ---
color(Base_Color)
intersection() {
    Build_Plate();
    translate([0, 0, Color_Swap_Z / 2])
    cube([200, 200, Color_Swap_Z], center=true);
}

color(Top_Color)
intersection() {
    Build_Plate();
    translate([0, 0, Color_Swap_Z + 50])
    cube([200, 200, 100], center=true);
}

// --- BUILD PLATE ASSEMBLY ---
module Build_Plate() {
    if (Print_Plate == 0 || Print_Plate == 1) {
        Card_Body();
    }
    if (Print_Plate == 0 || Print_Plate == 2) {
        translate([-10, -Card_H/2 - Flange_D - 5, 0]) Bottom_Button();
        translate([ 10, -Card_H/2 - Flange_D - 5, 0]) Top_Button();
    }
}

// --- MODULES ---
module Card_Body() {
    union() {
        // 1. The Base Card
        difference() {
            translate([0, 0, Card_T/2])
            linear_extrude(Card_T, center=true)
            offset(r = Corner_R)
            square([Card_W - 2*Corner_R, Card_H - 2*Corner_R], center=true);

            // Center Spinner Hole (608 bearing: 22mm OD, 8mm ID — hole fits inner race)
            translate([0, 0, -1])
            cylinder(h = Card_T + 2, d = Center_Hole_D);
        }

        // 2. Top Left — Name & Company
        //    3mm from left edge, 5mm from top edge
        translate([-Card_W/2 + 3, Card_H/2 - 5, Card_T])
        linear_extrude(Text_Thickness) {
            text(Name,  size=Name_Size,  font="Liberation Sans:style=Bold", halign="left", valign="top");
            translate([0, -Name_Size - 1.5, 0])
            text(Title, size=Title_Size, font="Liberation Sans:style=Bold", halign="left", valign="top");
            translate([0, -Name_Size - 1.5 - Title_Size - 2, 0])
            text(Tagline, size=2.6, font="Liberation Sans:style=Italic", halign="left", valign="top");
        }

        // 3. Bottom Right — Website & Email
        //    3mm from right edge, 5mm from bottom edge
        translate([Card_W/2 - 3, -Card_H/2 + 3, Card_T])
        linear_extrude(Text_Thickness) {
            text(Email, size=Email_Size, font="Liberation Sans:style=Bold", halign="right", valign="bottom");
            translate([0, Email_Size + 2, 0])
            text(Phone, size=Phone_Size, font="Liberation Sans:style=Bold", halign="right", valign="bottom");
        }
    }
}

module Bottom_Button() {
    difference() {
        union() {
            cylinder(h = Flange_T, d = Flange_D);
            translate([0, 0, Flange_T])
            cylinder(h = Connector_H, d = Bot_Post_OD);
        }
        translate([0, 0, Flange_T - 0.1])
        cylinder(h = Connector_H + 0.2, d = Bot_Post_ID);
    }
}

module Top_Button() {
    union() {
        cylinder(h = Flange_T, d = Flange_D);
        translate([0, 0, Flange_T])
        cylinder(h = Connector_H, d = Top_Post_OD);
    }
}
