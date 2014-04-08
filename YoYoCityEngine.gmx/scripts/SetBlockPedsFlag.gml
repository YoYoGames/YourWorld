/// SetBlockRoadFlags(map, button, x, y, z);
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
    if (_z>=0 && _z<MapDepth)
    && (_x>=0 && _x<MapWidth)
    && (_y>=0 && _y<MapHeight)
        {
        // Left click
        if (_button == 1)
            {
            // Get the info we're about to change
            var block, info, flags;
            block = MakeUnique(_map, _x, _y, _z);
            info  = block_info[block];
            flags = info[BLK_FLAGS1];
            
            // Change it, (flags&$F87FFFFF) zeros directional bits, (objRoadCompass.roadFlag<<22) puts in the new ones
            flags = (flags&$FBFFFFFF) | (1<<26);
            
            // Put it back
            info[BLK_FLAGS1] = flags;
            block_info[block] = info;
            
            // Update the map to show the changes
            FreeCacheRegion(id,_x-1,_y-1, _x+1,_y+1);   
            GenerateCacheRegion(id, _x-1,_y-1, _x+1,_y+1);  
            }
            
        // Right click
        else if (_button == 2)
            {
            // Get the info we're about to change
            var block, info, flags;
            block = MakeUnique(_map, _x, _y, _z);
            info  = block_info[block];
            flags = info[BLK_FLAGS1];
            
            // Change it, (flags&$F87FFFFF) zeros directional bits, (objRoadCompass.roadFlag<<22) puts in the new ones
            flags = (flags&$FBFFFFFF) | (0<<26);
            
            // Put it back
            info[BLK_FLAGS1] = flags;
            block_info[block] = info;
            
            // Update the map to show the changes
            FreeCacheRegion(id,_x-1,_y-1, _x+1,_y+1);   
            GenerateCacheRegion(id, _x-1,_y-1, _x+1,_y+1);  
            }
        }
    }

