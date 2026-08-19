// Plate under distributed load q(x,y)
settings.outformat = "pdf";
settings.tex = "pdflatex";
settings.render = 8;
import three;
import graph3;
usepackage("amsmath");

size(18cm, 0);
currentprojection = orthographic(0, -8, 8);
defaultpen(fontsize(24pt));

real L = 1.0;

// Top surface
path3 s = (0,0,0) -- (L,0,0) -- (L*(1+cos(pi/6)),L*sin(pi/6),0) -- (L*cos(pi/6),L*sin(pi/6),0) -- cycle;
draw(surface(s), palegray+opacity(0.35));
draw(surface(shift(0,0,0.3)*s), palered+opacity(0.35));
draw(s, black+1.5pt);

pen axisPen = black+1.2pt;
draw(O -- (2*L, 0, 0), axisPen, Arrow3,L=Label("$x$",position=EndPoint));
draw(O -- (0, L, 0), axisPen, Arrow3,L=Label("$y$",position=EndPoint));

pen arrowPen = mediumred+1.5pt;
real dx = 0.25;
for (real y = 0.0; y <= L; y += dx) {
    for (real x = y*cos(pi/6); x <= y*cos(pi/6)+L+0.1; x += dx) {
        draw((x, y*sin(pi/6), 0.3) -- (x, y*sin(pi/6), 0), arrowPen,
            Arrow3(emissive(mediumred),size=12pt));
    }
}
label("$\bar p$", (0.5*(1+cos(pi/6)),0.5*sin(pi/6),0.7));
draw(shift(0,-0.1,0)*(O -- (L, 0, 0)), axisPen, Bars3(dir=(0,1,0)),L=Label("$L$",position=MidPoint,S));

path3 arc_path = arc((L,0,0),(1.2*L,0,0),(L*(1+0.2*cos(pi/6)),L*0.2*L*sin(pi/6),0.0));
draw(arc_path,axisPen,arrow=Arrows3(TeXHead2(normal=Z)));
label("$30^\circ$", (1.2*L,0,0),NE);