/// SetBlockRoadFlags(map, button, x, y, z);
//

show_debug_message("Setting road flags");

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
            var block = MakeUnique(_map, _x, _y, _z);
            
            var info  = block_info[block];           // get the info we're about change
            var flags = info[BLK_FLAGS1];  
            
            debug("Current flag: "+string(flags));
            debug("Compass flag: "+string(objRoadCompass.roadFlag));
            
            flags |= objRoadCompass.roadFlag << 25;
            
            debug("New flag: "+string(flags));
            debug("New flag > compass: "+string(flags>>25));
            
            // << 25
            
            info[BLK_FLAGS1] = flags;
            block_info[block] = info;
            }
        }
    }

