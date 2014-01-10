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
    
    // Collision
    for (n=0; n<4; n++)
        {
        switch (n)
            {
            case (0): potentialDir = 270; break;
            case (1): potentialDir = 0;   break;
            case (2): potentialDir = 90;  break;
            case (3): potentialDir = 180; break;
            }
        
        // Cancel directions in case of collision
        xPos = argument0*64+32 + lengthdir_x(64, potentialDir);
        yPos = argument1*64-32 + lengthdir_y(64, potentialDir);
        inst = instance_nearest(xPos, yPos, objTrafficCar);
        if (point_distance(xPos, yPos, inst.x, inst.y) < 32)
        && (inst.parked == true)
            {
            //show_debug_message("found parked");
            switch (n)
                {
                case (0): north = false; break;
                case (1): east  = false; break;
                case (2): south = false; break;
                case (3): west  = false; break;
                }
            }
        }
    
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

