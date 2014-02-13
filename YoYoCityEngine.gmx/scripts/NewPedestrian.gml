/// NewPedestrian(array);
//
//  array - And array of pavement cells available to spawn this pedestrian on.
//
//*****************************************************************************

var paveArray;
paveArray = argument0;

// Choose one of the possible spawn locations that we found
var points, randomPoint, xPos, yPos;
points = array_length_1d(paveArray)/2;
randomPoint = irandom(points-1)*2;
xPos = paveArray[randomPoint+0];
yPos = paveArray[randomPoint+1];

// Spawn car at the position
var newPed;
newPed = instance_create(xPos, yPos, objPedestrian);
newPed.z = 255+8;

