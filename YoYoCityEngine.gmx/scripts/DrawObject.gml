/// DrawObject(sprite, subimg, x, y, z, scalex, scaley, rotation, colour, alpha);
//
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
//
//*****************************************************************************

// Get sprite dimentions, and find out how much we need to scale as uvs don't cover lost space
var _sprw, _sprh, _cx, _cy, tex, uvs, uvwidth, uvheight, texelx, texely, needwidth, needheight, scalex, scaley;
_sprw = sprite_get_width(argument0);
_sprh = sprite_get_height(argument0);
_cx = sprite_get_xoffset(argument0);
_cy = sprite_get_yoffset(argument0);
tex = sprite_get_texture(argument0, argument1);
uvs = sprite_get_uvs(argument0,argument1);      // NOTE, on texture page, empty space on image in animation is still removed
uvwidth = uvs[2]-uvs[0];
uvheight = uvs[3]-uvs[1];
texelw = texture_get_texel_width(tex);
texelh = texture_get_texel_height(tex);
needwidth = _sprw*texelw;
needheight = _sprh*texelh;
scalex = uvwidth/needwidth;
scaley = uvheight/needheight;

 
var _x1, _x2, _y1, _y2, _z1, _alpha, _colour, _idColour;
_x1 = -_cx*scalex;
_x2 = -_cx*scalex+_sprw*scalex;
_y1 = -_cy*scaley;
_y2 = -_cy*scaley+_sprh*scaley;
_z1 = 0;
_alpha = argument9;
_colour = argument8 | ((argument9*255)<<24)


// Rotate everything for drawing as needed
var m;
m = matrix_build(argument2,-argument3,-argument4, 0,0, argument7, argument5,argument6,1);
matrix_set(matrix_world, m);


// Begin drawing
var buff;
buff = global.TempSpriteBuffer;
vertex_begin(buff,global.SpriteFormat);


// Draw the first triangle
vertex_position_3d(buff,_x1,_y2,_z1);
vertex_argb(buff, _colour );
vertex_texcoord(buff,uvs[0],uvs[1] );

vertex_position_3d(buff,_x2,_y2,_z1);
vertex_argb(buff, _colour );
vertex_texcoord(buff,uvs[2],uvs[1] );

vertex_position_3d(buff,_x2,_y1,_z1);
vertex_argb(buff, _colour );
vertex_texcoord(buff,uvs[2],uvs[3]);


// Draw the second triangle
vertex_position_3d(buff,_x2,_y1,_z1);
vertex_argb(buff, _colour );
vertex_texcoord(buff,uvs[2],uvs[3] );

vertex_position_3d(buff,_x1,_y1,_z1);
vertex_argb(buff, _colour );
vertex_texcoord(buff,uvs[0],uvs[3] );

vertex_position_3d(buff,_x1,_y2,_z1);
vertex_argb(buff, _colour );
vertex_texcoord(buff,uvs[0],uvs[1] );


// Finish drawing
vertex_end(buff);
vertex_submit(buff, pr_trianglelist, tex);

