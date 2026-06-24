// Circular plate under uniform distributed load q_0
settings.outformat = "pdf";
settings.tex = "pdflatex";
settings.render = 8;
import three;
usepackage("amsmath");

size(16cm, 0);
currentprojection = orthographic(4.5, 3.5, 3);
defaultpen(fontsize(24pt));

// ============================================================
// Circular plate geometry
// ============================================================
real R = 1.0;
triple O = (0,0,0);
real z = 0.2;

// Top disk surface: scale3 * unitdisk
surface disk = scale3(R) * unitdisk;
draw(disk, palegrey+opacity(0.4));
path3 top_edge = path3(circle((0,0), R));
draw(top_edge, black+1.5pt);
surface disk = shift(0,0,z)*scale3(R) * unitdisk;
draw(disk, palered+opacity(0.4));

// path3 sector = (0,0,0) -- arc((0,0,0), (1,0,0), (0,1,0)) -- (0,0,0);
path3 section = (0,0,0.0001)--(1,0,0.0001);
surface sector = surface(section, c=O, axis=Z, angle1=0, angle2=90);
draw(sector, paleblue);

// ============================================================
// Uniform distributed load arrows (polar grid, constant height)
// ============================================================
pen arrowPen = mediumred+1.5pt;
real[] radii = {0.7, 1.0};
for (real r : radii) {
    for (real angle = 0; angle < 360; angle += 30) {
        real rad = angle * pi/180;
        triple start = (r*cos(rad), r*sin(rad), z);
        triple endpt = (r*cos(rad), r*sin(rad), 0);
        draw(start -- endpt, arrowPen, Arrow3(emissive(mediumred), size=12pt));
    }
}
real[] radii = {0.2, 0.5};
for (real r : radii) {
    for (real angle = 0; angle < 360; angle += 120) {
        real rad = angle * pi/180;
        triple start = (r*cos(rad), r*sin(rad), z);
        triple endpt = (r*cos(rad), r*sin(rad), 0);
        draw(start -- endpt, arrowPen, Arrow3(emissive(mediumred), size=12pt));
    }
}
// ============================================================
// Coordinate axes
// ============================================================
pen axisPen = black+1.2pt;
draw(O -- (1.4, 0, 0), axisPen, Arrow3,L=Label("$x$",position=EndPoint));
draw(O -- (0, 1.4, 0), axisPen, Arrow3,L=Label("$y$",position=EndPoint));

// Radius annotation
triple direct = (cos(pi/3),sin(pi/3),0);
draw((0,0,0) -- 0.8*direct, axisPen+dashed);
draw(shift(0.8*direct)*scale3(0.01)*unitsphere, mediumred);
path3 arc_path = arc((0,0,0),(0.1,0,0),0.1*direct);
draw(arc_path,axisPen,arrow=Arrows3(TeXHead2(normal=Z)));

draw(shift(0.03*(-sin(pi/3),cos(pi/3),0))*(O--0.8*direct),axisPen,Bars3(dir=(-sin(pi/3),cos(pi/3),0)));

label("$\bar p$", shift(0,0,0.8)*O);
label("$\theta$", shift(0.35,0.25,0.1)*O);
label("$r$", shift(0.05,0.1,0.1)*(0.5*(O+0.8*direct)));