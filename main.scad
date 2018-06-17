// Dyson Fluffy (DC74) Clamp
// To reinforce cracked latch.
// Developed by: Michael McCool
// Depends on: https://github.com/mmccool/openscad-library (put in OPENSCADPATH)
include <tols.scad>

// Uncomment "model" to speed rendering during modelling, "make" when ready to export STL
//include <smooth_model.scad>
include <smooth_make.scad>

include <bolt_params.scad>
use <bolts.scad>

sm = 10*sm_base;

dyson_r = 50/2;
dyson_w = 23;
dyson_h = 8;
dyson_rr = 1;
dyson_br = 18/2;
dyson_fr = 2.7;

clamp_t = 3;
clamp_bg = 2;
clamp_r = dyson_r + clamp_t;
clamp_h = 20;
clamp_bh = 15;
clamp_cc = 3;

clamp_br = m3_hole_radius + 0.2;
clamp_cr = m3_cap_radius + 0.5;
clamp_rr = clamp_cr + 2;
clamp_bo = dyson_r + clamp_rr + 2;
clamp_ch = m3_cap_height;
clamp_nr = m3_nut_radius + 0.8;
clamp_nh = m3_locknut_height;

clamp_sm = 4*sm;

module clamp() {
  difference() {
    union() {
      // basic clamp
      hull() {
        cylinder(r=clamp_r,h=clamp_h,$fn=clamp_sm);
        translate([-dyson_w/2,dyson_r+dyson_h-clamp_cc,0]) 
          cylinder(r=clamp_rr,h=clamp_h,$fn=clamp_sm);
        translate([ dyson_w/2,dyson_r+dyson_h-clamp_cc,0]) 
          cylinder(r=clamp_rr,h=clamp_h,$fn=clamp_sm);
      }
      // bolt extension (on bottom)
      difference() {
        hull() {
          translate([0,-clamp_bo,clamp_rr])
            rotate([0,90,0])
              translate([0,0,-clamp_bh/2])
                 cylinder(r=clamp_rr,h=clamp_bh,$fn=clamp_sm);
          translate([0,-clamp_bo,clamp_h-clamp_rr])
            rotate([0,90,0])
              translate([0,0,-clamp_bh/2])
                 cylinder(r=clamp_rr,h=clamp_bh,$fn=clamp_sm);
          translate([0,0,clamp_rr])
            rotate([0,90,0])
              translate([0,0,-clamp_bh/2])
                 cylinder(r=clamp_rr,h=clamp_bh,$fn=clamp_sm);
          translate([0,0,clamp_h-clamp_rr])
            rotate([0,90,0])
              translate([0,0,-clamp_bh/2])
                 cylinder(r=clamp_rr,h=clamp_bh,$fn=clamp_sm);
        }
        // holes for bolt shafts
        translate([0,-clamp_bo,clamp_rr])
          rotate([0,90,0])
            translate([0,0,-clamp_bh/2-1])
               cylinder(r=clamp_br,h=clamp_bh+2,$fn=clamp_sm);
        translate([0,-clamp_bo,clamp_h-clamp_rr])
          rotate([0,90,0])
            translate([0,0,-clamp_bh/2-1])
               cylinder(r=clamp_br,h=clamp_bh+2,$fn=clamp_sm);
        // holes for bolt caps (for M3 cap-head bolts)
        translate([0,-clamp_bo,clamp_rr])
          rotate([0,90,0])
            translate([0,0,clamp_bh/2-clamp_ch])
               cylinder(r=clamp_cr,h=clamp_bh+2,$fn=clamp_sm);
        translate([0,-clamp_bo,clamp_h-clamp_rr])
          rotate([0,90,0])
            translate([0,0,clamp_bh/2-clamp_ch])
               cylinder(r=clamp_cr,h=clamp_bh+2,$fn=clamp_sm);
        // holes for bolt nuts (low-profile 3mm high M3 locknuts recommended)
        translate([0,-clamp_bo,clamp_rr])
          rotate([0,90,0])
            translate([0,0,clamp_nh-3*clamp_bh/2])
               cylinder(r=clamp_cr,h=clamp_bh,$fn=6);
        translate([0,-clamp_bo,clamp_h-clamp_rr])
          rotate([0,90,0])
            translate([0,0,clamp_nh-3*clamp_bh/2])
               cylinder(r=clamp_cr,h=clamp_bh,$fn=6);
      }
    }
    // central hole
    rotate([-90,0,0])
      cylinder(r=dyson_br,h=dyson_r+dyson_h+clamp_rr+5,$fn=clamp_sm);
    // latch clearance hole
    translate([0,0,-1]) {
      // latch button access hole
      cylinder(r=dyson_r,h=clamp_h+2,$fn=clamp_sm);
      // latch clearance
      hull() {
        translate([-dyson_w/2+dyson_rr,dyson_r+dyson_h-clamp_cc,0]) 
          cylinder(r=dyson_rr,h=clamp_h+2,$fn=clamp_sm);
        translate([ dyson_w/2-dyson_rr,dyson_r+dyson_h-clamp_cc,0]) 
          cylinder(r=dyson_rr,h=clamp_h+2,$fn=clamp_sm);
        translate([-dyson_w/2+dyson_rr,0,0]) 
          cylinder(r=dyson_rr,h=clamp_h+2,$fn=clamp_sm);
        translate([ dyson_w/2-dyson_rr,0,0]) 
          cylinder(r=dyson_rr,h=clamp_h+2,$fn=clamp_sm);
      }
      // gap in clamp to allow bolts to tighten
      translate([-clamp_bg/2,-dyson_r-clamp_bo+clamp_t+1,0])
        cube([clamp_bg,dyson_r+clamp_t+1,clamp_h+2]);
      // fillet clearance
      translate([-dyson_w/2+1,dyson_r-4,0]) 
        rotate(7)
          cylinder(r=dyson_fr,h=clamp_h+2,$fn=4);
      translate([ dyson_w/2-1,dyson_r-4,0]) 
        rotate(-7)
          cylinder(r=dyson_fr,h=clamp_h+2,$fn=4);
    }
  }

}

clamp();