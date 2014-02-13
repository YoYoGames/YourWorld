/// NewTrafficCar(array);
//
//  array - And array of road cells available to spawn this car on.
//
//  Creates a new traffic car in the world, basing it's intial direction on it's starting tile.
//
//*****************************************************************************

var roadArray;
roadArray = argument0;


// Choose one of the possible spawn locations that we found
var points, randomPoint, xPos, yPos, roadFlags;
points = array_length_1d(roadArray)/3;
randomPoint = irandom(points-1)*3;
xPos = roadArray[randomPoint+0];
yPos = roadArray[randomPoint+1];
roadFlags = roadArray[randomPoint+2];


// Spawn car at the position
var newCar;
newCar = instance_create(xPos, yPos, objTrafficCar);
newCar.z = 255+8;


// Choose and available starting direction
if (roadFlags & 8) newCar.direction = 270;
if (roadFlags & 4) newCar.direction = 0;
if (roadFlags & 2) newCar.direction = 90;
if (roadFlags & 1) newCar.direction = 180;


// Apply starting settings to thew car
newCar.image_angle = newCar.direction-90;
newCar.Direction = newCar.direction;
newCar.DesiredDirection = newCar.direction;

