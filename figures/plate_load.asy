// Plate under distributed load q(x,y)
settings.outformat = "pdf";
settings.tex = "pdflatex";
settings.render = 8;
import three;
import graph3;
usepackage("amsmath");

size(18cm, 0);
currentprojection = orthographic(4.5, 3.5, 3);
defaultpen(fontsize(24pt));

// ============================================================
// Square plate (unit square in xy-plane, with thickness)
// ============================================================
real a = 1.0;
real z = -0.2;

// Top surface
path3 top = (0,0,z) -- (a,0,z) -- (a,a,z) -- (0,a,z) -- cycle;
draw(surface(top), palegray+opacity(0.35));
draw(top, black+1.5pt);
// ============================================================
// Distributed load arrows
// ============================================================
real D = 0.2;
real f(pair z){
    real x = z.x;
    real y = z.y;
    return D*(12*y*(y-1)*(5*x^2-5*x+1)*(2*y^2*(y-1)^2+x*(x-1)*(5*y^2-5*y+1))+12*x*(x-1)*(5*y^2-5*y+1)*(2*x^2*(x-1)^2+y*(y-1)*(5*x^2-5*x+1)));
}
surface q = surface(f, (0, 0), (1, 1), nx = 5, Spline);
draw(q,palered+opacity(0.35));
pen arrowPen = mediumred+1.5pt;
real dx = 0.25;
for (real x = 0.0; x <= 1.0; x += dx) {
    for (real y = 0.0; y <= 1.0; y += dx) {
        draw((x, y, f((x,y))) -- (x, y, z), arrowPen,
            Arrow3(emissive(mediumred),size=12pt));
    }
}

pen axisPen = black+1.2pt;
draw(shift(0,0,z)*(O -- (1.25, 0, 0)), axisPen, Arrow3,L=Label("$x$",position=EndPoint));
draw(shift(0,0,z)*(O -- (0, 1.25, 0)), axisPen, Arrow3,L=Label("$y$",position=EndPoint));
label("$\bar p$", (0.5,0.5,0.4));
draw(shift(0,1.1,z)*(O -- (1, 0, 0)), axisPen, Bars3(dir=(0,1,0)),L=Label("$L$",position=MidPoint,E));

