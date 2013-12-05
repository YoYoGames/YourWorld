/// Draw3dSprite(sprite,subimg,x,y,z,scalex,scaley,rotation,colour,alpha)
// Almost the same as draw_sprite_ext()
// argument0 = sprite
// argument1 = subimage
// argument2 = x
// argument3 = y
// argument4 = z
// argument5 = scalex   (must be the same as scaley)
// argument6 = scaley   (must be the same as scalex)
// argument7 = rotation
// argument8 = colour 
// argument9 = alpha


var _x1,_x2,_y1,_y2,_z1,_z2,_sprw,_sprh,_cx,_cy, _colour,_alpha;

sprw = sprite_get_width(argument0);
sprh = sprite_get_height(argument0);
cx = sprite_get_xoffset(argument0);
cy = sprite_get_yoffset(argument0);
 
_x1 = -cx;
_x2 = -cx+sprw;
_y1 = -cy;
_y2 = -cy+sprh;
_z1 = 0; //-argument4;
_alpha = argument9;
_colour = argument8 | ((argument9*255)<<24)

var m = matrix_build(argument2,-argument3,-argument4, 0,0, argument7, argument5,argument6,1);
matrix_set(matrix_world, m);

var buff = global.TempSpriteBuffer;
var tex = sprite_get_texture( argument0, argument1 );
vertex_begin(buff,global.SpriteFormat);

var uvs = sprite_get_uvs(argument0,argument1);
vertex_position_3d(buff,_x1,_y2,_z1);
vertex_argb(buff, _colour );
vertex_texcoord(buff,uvs[0],uvs[1] );

vertex_position_3d(buff,_x2,_y2,_z1);
vertex_argb(buff, _colour );
vertex_texcoord(buff,uvs[2],uvs[1] );

vertex_position_3d(buff,_x2,_y1,_z1);
vertex_argb(buff, _colour );
vertex_texcoord(buff,uvs[2],uvs[3] );



vertex_position_3d(buff,_x2,_y1,_z1);
vertex_argb(buff, _colour );
vertex_texcoord(buff,uvs[2],uvs[3] );

vertex_position_3d(buff,_x1,_y1,_z1);
vertex_argb(buff, _colour );
vertex_texcoord(buff,uvs[0],uvs[3] );

vertex_position_3d(buff,_x1,_y2,_z1);
vertex_argb(buff, _colour );
vertex_texcoord(buff,uvs[0],uvs[1] );

vertex_end(buff);
vertex_submit( buff, pr_trianglelist, tex );




