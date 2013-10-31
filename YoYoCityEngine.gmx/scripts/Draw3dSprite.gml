// same as draw_sprite_ext()
// argument0 = sprite
// argument1 = subimage
// argument2 = x
// argument3 = y
// argument4 = y
// argument5 = scalex
// argument6 = scaley
// argument7 = rotation (unused)
// argument8 = colour
// argument9 = alpha


var x1,x2,y1,y2,z1,z2;

x1 = (argument2);
x2 = (argument2+16);
y1 = (argument3);
y2 = (argument3+16);
z1 = argument4;
var v5 = argument5;
var v6 = argument6;
var v7 = argument7;
var v9 = argument9;

//var tex = sprite_get_texture( argument0, argument1 );
//d3d_primitive_begin_texture(pr_trianglefan, tex);
//d3d_vertex_texture_color(x1,y2,z1, 0, 0, argument8,argument9);
//d3d_vertex_texture_color(x2,y2,z1, 1, 0, argument8,argument9);
//d3d_vertex_texture_color(x2,y1,z1, 1, 1, argument8,argument9);
//d3d_vertex_texture_color(x1,y1,z1, 0, 1, argument8,argument9);
//d3d_primitive_end();
vertex_begin(global.vbuffer,global.vformat);

var uvs = sprite_get_uvs(argument0,argument1);
uvs[0]=0;
uvs[1]=0;
uvs[2]=1;
uvs[3]=1;
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
var tex = sprite_get_texture( argument0, argument1 );
vertex_submit( global.vbuffer, pr_trianglelist, tex );




