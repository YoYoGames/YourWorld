/// GetDirectionOptions(x, y, z);
//
//*****************************************************************************

var block, info, flags, north, east, south, west, count;

block = MakeUnique(global.Map, argument0, -argument1, argument2);
info  = oMap.block_info[block];
flags = (info[BLK_FLAGS1] >> 22) & $F;
count = 0;
if (flags)
    {
    // Get flags
    north = (flags & 8) > 0; // 1000 = 8
    east  = (flags & 4) > 0; // 0100 = 4
    south = (flags & 2) > 0; // 0010 = 2
    west  = (flags & 1) > 0; // 0001 = 1
    
    count = north+east+south+west;
    }
    
return count;

