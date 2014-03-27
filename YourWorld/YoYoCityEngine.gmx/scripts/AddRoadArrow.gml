/// AddRoadArrow(Vbuffer, sprite, image, x, y, z, scalex, scaley, angle, colour, flags)
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

var _x1,_x2,_y1,_y2,_z1,_z2,_sprw,_sprh,_cx,_cy, _colour,_alpha, _buff, tex, uvs, _roadflag;

_buff = argument0;

sprw = sprite_get_width(argument1);
sprh = sprite_get_width(argument1);
cx = sprite_get_xoffset(argument1);
cy = sprite_get_xoffset(argument1);
tex = sprite_get_texture( argument1, argument2 );
 
_x1 = argument3;
_x2 = argument3 + 64;
_y1 = argument4 - 64;
_y2 = argument4 ;
_z1 = argument5 - 4;
_scalex = argument6;
_scaley = argument7;
_angle = argument8;
_colour = argument9;
_roadflag = argument10;

// Convert _roadflag into variables we can read
var _northFlag = (_roadflag & 8) > 0; // 1000 = 8
var _eastFlag  = (_roadflag & 4) > 0; // 0100 = 4
var _southFlag = (_roadflag & 2) > 0; // 0010 = 2
var _westFlag  = (_roadflag & 1) > 0; // 0001 = 1

// Get this image index to use, and how it should be translated
_img = 0;
rotate = false;
mirror = false;
var flagCount = _northFlag + _eastFlag + _southFlag + _westFlag;
switch (flagCount)
    {
    case (1):
        _img = 0;
        if (_northFlag) { rotate = true; mirror = true; }
        if (_eastFlag)  { mirror = false; }
        if (_southFlag) { rotate = true; }
        if (_westFlag)  { mirror = true; }
        break;
    case (3):
        _img = 3;
        if (!_southFlag)  { rotate = true; mirror = true; }
        if (!_westFlag) { mirror = false; }
        if (!_northFlag)  { rotate = true; }
        if (!_eastFlag) { mirror = true; }
        break;
    case (4):
        _img = 4;
        break;
    case (2):
        _img = 1 + ((_northFlag && _southFlag) || (_eastFlag && _westFlag));
        if (_img == 1)
            {
            if (_eastFlag && _southFlag) { rotate = true; }
            if (_westFlag && _southFlag) { _img = 5; }   // Hack fix, for now
            if (_westFlag && _northFlag) { rotate = false; mirror = true;}
            }
        else if (_img == 2)
            {
            if (_northFlag) { rotate = true; }
            }
        break;
    }
    
// Do the translating
uvs = sprite_get_uvs(argument1, _img);
uvX1 = uvs[0];
uvY1 = uvs[1];
uvX2 = uvs[2];
uvY2 = uvs[3];

if (mirror)
    {
    uvX1 = uvs[2];
    uvX2 = uvs[0];
    }

if (rotate)
    {
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
    }
else
    {
    vertex_position_3d(_buff,_x1,_y2,_z1);
    vertex_colour(_buff, _colour, 1.0 );
    vertex_texcoord(_buff,uvX1,uvY1);
    
    vertex_position_3d(_buff,_x2,_y2,_z1);
    vertex_colour(_buff, _colour, 1.0 );
    vertex_texcoord(_buff,uvX2,uvY1);
    
    vertex_position_3d(_buff,_x2,_y1,_z1);
    vertex_colour(_buff, _colour, 1.0 );
    vertex_texcoord(_buff,uvX2,uvY2 );
    
    
    vertex_position_3d(_buff,_x2,_y1,_z1);
    vertex_colour(_buff, _colour, 1.0 );
    vertex_texcoord(_buff,uvX2,uvs[3] );
    
    vertex_position_3d(_buff,_x1,_y1,_z1);
    vertex_colour(_buff, _colour, 1.0 );
    vertex_texcoord(_buff,uvX1,uvY2 );
    
    vertex_position_3d(_buff,_x1,_y2,_z1);
    vertex_colour(_buff, _colour, 1.0 );
    vertex_texcoord(_buff,uvX1,uvY1);
    }

