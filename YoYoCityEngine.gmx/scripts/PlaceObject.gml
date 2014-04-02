/// PlaceObject(map, button, x, y, z);
//
//  
//
//*****************************************************************************

var _map, _button, _x, _y, _z;
_map    = argument0;
_button = argument1;
_x      = argument2;
_y      = argument3;
_z      = argument4;

with (_map)
    {
    // Left click
    if (_button == 1)
        {
        var xx, yy, zz;
        xx = _x;   // The tile x
        yy = _y;   // The tile y
        zz = _z++; // The ACTUAL z (0-65535)
        
        var newObject;
        show_debug_message("global.LeftMouseSprite = "+string(global.LeftMouseSprite));
        newObject = instance_create(xx*64+32+irandom_range(-8, 8), -yy*64-32+irandom_range(-8, 8), ObjectGetIndex(global.LeftMouseSprite));
        newObject.z = zz*64+8;
        newObject.zstart = newObject.z;
        newObject.phy_rotation = random(360);
        return newObject;
        }
    
    // Right click, remove the selected object
    else if (_button == 2)
        {
        /*
        var xx, yy, zz;
        xx = _x;   //The tile x
        yy = _y;   //The tile y
        zz = _z++; //The ACTUAL z (0-65535)
        
        show_debug_message("Clicked @ ("+string(xx)+","+string(yy)+","+string(zz)+")");
        
        if (_z > 0)
            {
            ds_grid_set(Sprites, xx, yy, -1)
            FreeCacheRegion(id,_x-1,_y-1, _x+1,_y+1);   
            GenerateCacheRegion(id, _x-1,_y-1, _x+1,_y+1);  
            }
        */
        }
    }
    
