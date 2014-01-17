/// GetOptionExists(x, y, z, direction);
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
    north = ((flags & 8) > 0) & (argument3 == 270);
    east  = ((flags & 4) > 0) & (argument3 == 0);
    south = ((flags & 2) > 0) & (argument3 == 90);
    west  = ((flags & 1) > 0) & (argument3 == 180);
    
    return north|east|south|west;
    }
    
return false;

