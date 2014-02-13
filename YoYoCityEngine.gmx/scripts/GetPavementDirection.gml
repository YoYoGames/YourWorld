/// GetNewPavement(x, y, z);
//
//  GOAL: This script should find a new pavement we can move to.
//      But it should always pick one ahead of the ped, only moving back for lack of other options.
//
//  Returns an array with X and Y coordinates in it.
//
//*****************************************************************************

var block, info, flags, count, north, east, south, west;

block = MakeUnique(global.Map, argument0, -argument1-1, argument2);
info  = oMap.block_info[block];
north = (info[BLK_FLAGS1] >> 26) & $1;

block = MakeUnique(global.Map, argument0, -argument1+1, argument2);
info  = oMap.block_info[block];
south = (info[BLK_FLAGS1] >> 26) & $1;

block = MakeUnique(global.Map, argument0+1, -argument1, argument2);
info  = oMap.block_info[block];
east = (info[BLK_FLAGS1] >> 26) & $1;

block = MakeUnique(global.Map, argument0-1, -argument1, argument2);
info  = oMap.block_info[block];
west = (info[BLK_FLAGS1] >> 26) & $1;


myDir = 0;
if (north) myDir = 0;
if (east)  myDir = 1;
if (south) myDir = 2;
if (west)  myDir = 3;

//show_debug_message(string(north)+", "+string(east)+", "+string(south)+", "+string(west)+", ");

var position;
position[0] = -1;
position[1] = -1;

switch (myDir)
    {
    case (0): // North
        position[0] = (argument0)*64+random_range(8, 56);
        position[1] = (argument1-1)*64+random_range(8, 56);
        break;
    case (1): // East
        position[0] = (argument0+1)*64+random_range(8, 56);
        position[1] = (argument1)*64+random_range(8, 56);
        break;
    case (2): // South
        position[0] = (argument0)*64+random_range(8, 56);
        position[1] = (argument1+1)*64+random_range(8, 56);
        break;
    case (3): // West
        position[0] = (argument0-1)*64+random_range(8, 56);
        position[1] = (argument1)*64+random_range(8, 56);
        break;
    }
    
return position;

