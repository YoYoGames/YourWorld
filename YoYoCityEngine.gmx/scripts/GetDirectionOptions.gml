/// GetDirectionOptions(x, y, z);
//
//  Returns how many road direction options the given cell has.
//
//*****************************************************************************

// Get the block info
var block, info, flags;
block = MakeUnique(global.Map, argument0, -argument1, argument2);
info  = oMap.block_info[block];
flags = (info[BLK_FLAGS1] >> 22) & $F;

// Check for possible directions
var count;
count = 0;
if (flags)
    {
    count  = (flags & 8) > 0;
    count += (flags & 4) > 0;
    count += (flags & 2) > 0;
    count += (flags & 1) > 0;
    }

// Return the number of possibly directions
return count;
