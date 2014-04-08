/// GetOptionExists(x, y, z, direction);
//
//  Returns TRUE if the given cell has the given road direction available.
//
//*****************************************************************************

// Get the block info
var block, info, flags;
block = MakeUnique(global.Map, argument0, -argument1, argument2);
info  = oMap.block_info[block];
flags = (info[BLK_FLAGS1] >> 22) & $F;

// Check the flags against the desired direction
var north, east, south, west;
if (flags)
    {
    north = ((flags & 8) > 0) & (argument3 == 270);
    east  = ((flags & 4) > 0) & (argument3 == 0);
    south = ((flags & 2) > 0) & (argument3 == 90);
    west  = ((flags & 1) > 0) & (argument3 == 180);
    return north|east|south|west;
    }

// Direction was not available
return 0;
