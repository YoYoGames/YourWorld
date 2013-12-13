/// SetBlockRoadFlags(map, button, x, y, z);
//

//show_debug_message("Setting road flags");

var _map    = argument0;
var _button = argument1;
var _x      = argument2;
var _y      = argument3;
var _z      = argument4;

with (_map)
    {
    // Left click
    if (_button == 1)
        {
        if(( _z>=0 && _z<MapDepth ) && (_x>=0 && _x<MapWidth) && (_y>=0 && _y<MapHeight))
            {
            // Get the info we're about to change
            var block = MakeUnique(_map, _x, _y, _z);
            var info  = block_info[block];
            var flags = info[BLK_FLAGS1];
            
            // Change it, (flags&$F87FFFFF) zeros directional bits, (objRoadCompass.roadFlag<<25) puts in the new ones
            flags = (flags&$FC3FFFFF) | (objRoadCompass.roadFlag<<22);
            
            // Put it back
            info[BLK_FLAGS1] = flags;
            block_info[block] = info;
            
            // Update the map to show the changes
            FreeCacheRegion(id,_x-1,_y-1, _x+1,_y+1);   
            GenerateCacheRegion(id, _x-1,_y-1, _x+1,_y+1);  
            }
        }
    }

