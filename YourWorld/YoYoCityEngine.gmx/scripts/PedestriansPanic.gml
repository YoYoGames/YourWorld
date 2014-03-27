/// PedestriansPanic(x, y, z, radius);
//
//  Finds all pedestrians within a radius at the given point
//  and makes them run away from that point.
//
//*****************************************************************************

var numberOfPeds, n, ped, dist, xPos, yPos, zPos, radius;

// Get the bits we need
xPos = argument0;
yPos = argument1;
zPos = argument2;
radius = argument3;
numberOfPeds = instance_number(objPedestrian);

// Scan through ALL pedestrians, panicking those within the given radius
for (n=0; n<numberOfPeds; n++)
    {
    ped = instance_find(objPedestrian, n);
    dist = point_distance(xPos, yPos, ped.x, ped.y);
    if (dist <= radius)
        {
        ped.scatter = true;
        ped.scatterTimer = room_speed*4;
        ped.moveSpeed = 1.5+random(0.7);
        ped.direction = point_direction(xPos, yPos, ped.x, ped.y);
        }
    }

