/// AddPavementTile(Vbuffer, sprite, image, x, y, z, scalex, scaley, angle, colour, flag);
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
// argument10 = flag

var _x1,_x2,_y1,_y2,_z1,_z2,_sprw,_sprh,_cx,_cy, _colour,_alpha, _buff, uvs, _roadflag;

_buff = argument0;

sprw = sprite_get_width(argument1);
sprh = sprite_get_width(argument1);
cx = sprite_get_xoffset(argument1);
cy = sprite_get_xoffset(argument1);

BINTHIS = argument2;
 
_x1 = argument3;
_x2 = argument3 + 64;
_y1 = argument4 - 64;
_y2 = argument4 ;
_z1 = argument5 - 4;
_scalex = argument6;
_scaley = argument7;
_angle = argument8;
_colour = argument9;
_flag = argument10;
    
// Do the translating
uvs = sprite_get_uvs(argument1, 6);
uvX1 = uvs[0];
uvY1 = uvs[1];
uvX2 = uvs[2];
uvY2 = uvs[3];

vertex_position_3d(_buff,_x2,_y2,_z1);
vertex_colour(_buff, _colour, 1.0 );
vertex_texcoord(_buff,uvX1,uvY1);

vertex_position_3d(_buff,_x2,_y1,_z1);
vertex_colour(_buff, _colour, 1.0 );
vertex_texcoord(_buff,uvX2,uvY1);

vertex_position_3d(_buff,_x1,_y1,_z1);
vertex_colour(_buff, _colour, 1.0 );
vertex_texcoord(_buff,uvX2,uvY2 );


vertex_position_3d(_buff,_x1,_y1,_z1);
vertex_colour(_buff, _colour, 1.0 );
vertex_texcoord(_buff,uvX2,uvs[3] );

vertex_position_3d(_buff,_x1,_y2,_z1);
vertex_colour(_buff, _colour, 1.0 );
vertex_texcoord(_buff,uvX1,uvY2 );

vertex_position_3d(_buff,_x2,_y2,_z1);
vertex_colour(_buff, _colour, 1.0 );
vertex_texcoord(_buff,uvX1,uvY1);

