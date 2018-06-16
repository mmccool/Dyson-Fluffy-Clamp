// Dyson Fluffy (DC74) Clamp
// To reinforce cracked latch.
// Developed by: Michael McCool
include <tols.scad>
include <smooth_model.scad>
//include <smooth_make.scad>
include <bolt_params.scad>
use <bolts.scad>

sm = 10*sm_base;

dyson_r = 50/2;
dyson_w = 23;
dyson_h = 8;
dyson_rr = 1;
dyson_br = 18/2;

clamp_t = 2;
clamp_bg = 2;
clamp_r = dyson_r + clamp_t;
clamp_h = 15;
clamp_bh = 15;
clamp_cc = 3;

clamp_br = m3_hole_radius;
clamp_cr = m3_cap_radius;
clamp_rr = clamp_cr + 1;
clamp_bo = dyson_r + clamp_rr + 2;
clamp_ch = m3_cap_height;
clamp_nr = m3_nut_radius;
clamp_nh = m3_locknut_height;

clamp_sm = 8*sm;

module clamp() {
  difference() {
    union() {
      hull() {
        cylinder(r=clamp_r,h=clamp_h,$fn=clamp_sm);
        translate([-dyson_w/2,dyson_r+dyson_h-clamp_cc,0]) 
          cylinder(r=clamp_rr,h=clamp_h,$fn=clamp_sm);
        translate([ dyson_w/2,dyson_r+dyson_h-clamp_cc,0]) 
          cylinder(r=clamp_rr,h=clamp_h,$fn=clamp_sm);
      }
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
        // holes for bolt caps
        translate([0,-clamp_bo,clamp_rr])
          rotate([0,90,0])
            translate([0,0,clamp_bh/2-clamp_ch])
               cylinder(r=clamp_cr,h=clamp_bh+2,$fn=clamp_sm);
        translate([0,-clamp_bo,clamp_h-clamp_rr])
          rotate([0,90,0])
            translate([0,0,clamp_bh/2-clamp_ch])
               cylinder(r=clamp_cr,h=clamp_bh+2,$fn=clamp_sm);
        // holes for bolt nuts
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
    rotate([-90,0,0])
      cylinder(r=dyson_br,h=dyson_r+dyson_h+clamp_rr+5,$fn=clamp_sm);
    translate([0,0,-1]) {
      cylinder(r=dyson_r,h=clamp_h+2,$fn=clamp_sm);
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
      translate([-clamp_bg/2,-dyson_r-clamp_bo+clamp_t+1,0])
        cube([clamp_bg,dyson_r+clamp_t+1,clamp_h+2]);
    }
  }
}

clamp();