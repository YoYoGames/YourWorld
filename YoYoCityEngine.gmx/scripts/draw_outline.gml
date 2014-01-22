/// draw_outline(x,y,string,colour)

var xx, yy, ss, cc;

xx = argument0;             // x coordinate
yy = argument1;             // y coordinate
ss = argument2;             // string to render
cc = argument3;             // colour

draw_set_color(c_black);
draw_text(xx-1,yy, ss);
draw_text(xx+1,yy, ss);
draw_text(xx,yy-1, ss);
draw_text(xx,yy+1, ss);

draw_set_color(cc);
draw_text(xx,yy, ss);

