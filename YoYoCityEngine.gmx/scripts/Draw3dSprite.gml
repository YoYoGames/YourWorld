// same as draw_sprite_ext()
// argument0 = sprite
// argument1 = subimage
// argument2 = x
// argument3 = y
// argument4 = z
// argument5 = scalex
// argument6 = scaley
// argument7 = rotation (unused)
// argument8 = colour
// argument9 = alpha


var _x1,_x2,_y1,_y2,_z1,_z2,_sprw,_sprh,_cx,_cy, _scalex,_scaley,_angle,_colour,_alpha;

sprw = sprite_get_width(argument0);
sprh = sprite_get_width(argument0);
cx = sprite_get_xoffset(argument0);
cy = sprite_get_xoffset(argument0);
 
_x1 = argument2+cx;
_x2 = argument2+cx+sprw;
_y1 = argument3+cy;
_y2 = argument3+cy+sprh;
_z1 = argument4;
_scalex = argument5;
_scaley = argument6;
_angle  = argument7;
_colour = argument8 | ((argument9*255.0)<<24);


var tex = sprite_get_texture( argument0, argument1 );
vertex_begin(global.vbuffer,global.vformat);

var uvs = sprite_get_uvs(argument0,argument1);
vertex_position_3d(global.vbuffer,x1,y2,z1);
vertex_colour(global.vbuffer, argument8, 1.0 );
vertex_texcoord(global.vbuffer,uvs[0],uvs[1] );

vertex_position_3d(global.vbuffer,x2,y2,z1);
vertex_colour(global.vbuffer, argument8, 1.0 );
vertex_texcoord(global.vbuffer,uvs[2],uvs[1] );

vertex_position_3d(global.vbuffer,x2,y1,z1);
vertex_colour(global.vbuffer, argument8, 1.0 );
vertex_texcoord(global.vbuffer,uvs[2],uvs[3] );



vertex_position_3d(global.vbuffer,x2,y1,z1);
vertex_colour(global.vbuffer, argument8, 1.0 );
vertex_texcoord(global.vbuffer,uvs[2],uvs[3] );

vertex_position_3d(global.vbuffer,x1,y1,z1);
vertex_colour(global.vbuffer, argument8, 1.0 );
vertex_texcoord(global.vbuffer,uvs[0],uvs[3] );

vertex_position_3d(global.vbuffer,x1,y2,z1);
vertex_colour(global.vbuffer, argument8, 1.0 );
vertex_texcoord(global.vbuffer,uvs[0],uvs[1] );

vertex_end(global.vbuffer);
vertex_submit( global.vbuffer, pr_trianglelist, tex );




