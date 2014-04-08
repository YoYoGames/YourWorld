/// GetHasRoad(x, y, z);
//
//  Returns TRUE if there are ANY road direction options in the given cell.
//
//*****************************************************************************

// Get block info
var block, info, flags;
block = MakeUnique(global.Map, argument0, -argument1, argument2);
info  = oMap.block_info[block];
flags = (info[BLK_FLAGS1] >> 22) & $F;

// Return whether there is a road flag set to true
return (flags > 0);
