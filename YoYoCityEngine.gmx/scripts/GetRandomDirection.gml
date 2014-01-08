/// GetRandomDirection(x, y, z, default);
//
//  Takes the road flags from the block at the given coordinates
//  and returns a direction in degrees that the road may lead to.
//  Returns default if no new direction could be gained.
//   -- Block didn't exist at this position.
//   -- Block exists, but has no road flags.
//
//*****************************************************************************

var block, info, flags, north, east, south, west, dir, n, xPos, yPos;

block = MakeUnique(global.Map, argument0, -argument1, argument2);
info  = oMap.block_info[block];
flags = (info[BLK_FLAGS1] >> 22) & $F;
dir = argument3;
if (flags)
    {
    // Get flags
    north = (flags & 8) > 0; // 1000 = 8
    east  = (flags & 4) > 0; // 0100 = 4
    south = (flags & 2) > 0; // 0010 = 2
    west  = (flags & 1) > 0; // 0001 = 1
    
    // Get a default direction
    if (north) dir = 270;
    if (east)  dir = 0;
    if (south) dir = 90;
    if (west)  dir = 180;
    
    // Chose a random direction if possible
    if (north && choose(0, 1)) dir = 270;
    if (east  && choose(0, 1)) dir = 0;
    if (south && choose(0, 1)) dir = 90;
    if (west  && choose(0, 1)) dir = 180;
    }
    
return dir;

