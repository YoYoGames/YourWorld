/// FindPavementRect(x1, y1, x2, y2);
//
//  Returns an array of coordinates of a discovered pavement tile.
//
//*****************************************************************************


// Initialize
var pos;
pos[2] = 0;


// Scan through random coords until we find valid space
do
    {
    pos[0] = irandom_range(argument0, argument2);
    pos[1] = irandom_range(argument1, argument3);
    pos[2] = 4;
    }
until (GetHasPavement(pos[0], -pos[1], pos[2]))


// Return array carrying valid coords
return pos;

