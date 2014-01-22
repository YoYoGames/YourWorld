/// GetDirectionOptions(x, y, z);
//
//  Returns how many road direction options the given cell has.
//
//*****************************************************************************

var block, info, flags, count;

block = MakeUnique(global.Map, argument0, -argument1, argument2);
info  = oMap.block_info[block];
flags = (info[BLK_FLAGS1] >> 22) & $F;
count = 0;
if (flags)
    {
    count  = (flags & 8) > 0; // 1000 = 8
    count += (flags & 4) > 0; // 0100 = 4
    count += (flags & 2) > 0; // 0010 = 2
    count += (flags & 1) > 0; // 0001 = 1
    }
    
return count;

