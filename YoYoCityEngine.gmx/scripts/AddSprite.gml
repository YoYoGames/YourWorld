/// AddSprite(Vbuffer,sprite,image,x,y,z,scalex,scaley,angle,_colourolour)
//
// Add a sprite to our "sprite mesh"
// argument0 = VertexBuffer
// argument1 = sprite
// argument2 = subimage
// argument3 = x
// argument4 = y
// argument5 = z
// argument6 = scalex   (unused)
// argument7 = scaley   (unused)
// argument8 = rotation (unused)
// argument9 = colour 

var _x1,_x2,_y1,_y2,_z1,_z2,_sprw,_sprh,_cx,_cy, _colour,_alpha, _buff, tex, uvs;

_buff = argument0;

sprw = sprite_get_width(argument1);
sprh = sprite_get_height(argument1);
cx = sprite_get_xoffset(argument1);
cy = sprite_get_yoffset(argument1);
tex = sprite_get_texture( argument1, argument2 );
uvs = sprite_get_uvs(argument1,argument2);
 
_x1 = -cx + argument3;
_x2 = -cx+sprw + argument3;
_y1 = -cy + argument4;      
_y2 = -cy+sprh + argument4; 
_z1 = -argument5;
_scalex = argument6;
_scaley = argument7;
_angle = argument8;
_colour = argument9 |(1<<26);;

vertex_position_3d(_buff,_x1,_y2,_z1);
vertex_argb(_buff,_colour);
//vertex_colour(_buff, _colour, 1.0 );
vertex_texcoord(_buff,uvs[0],uvs[1] );

vertex_position_3d(_buff,_x2,_y2,_z1);
vertex_argb(_buff,_colour);
//vertex_colour(_buff, _colour, 1.0 );
vertex_texcoord(_buff,uvs[2],uvs[1] );

vertex_position_3d(_buff,_x2,_y1,_z1);
vertex_argb(_buff,_colour);
//vertex_colour(_buff, _colour, 1.0 );
vertex_texcoord(_buff,uvs[2],uvs[3] );



vertex_position_3d(_buff,_x2,_y1,_z1);
vertex_argb(_buff,_colour);
//vertex_colour(_buff, _colour, 1.0 );
vertex_texcoord(_buff,uvs[2],uvs[3] );

vertex_position_3d(_buff,_x1,_y1,_z1);
vertex_argb(_buff,_colour);
//vertex_colour(_buff, _colour, 1.0 );
vertex_texcoord(_buff,uvs[0],uvs[3] );

vertex_position_3d(_buff,_x1,_y2,_z1);
vertex_argb(_buff,_colour);
//vertex_colour(_buff, _colour, 1.0 );
vertex_texcoord(_buff,uvs[0],uvs[1] );







