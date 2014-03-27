/// SpawnPlayer();
//
//  Spawns the player car at a position.
//
//  TODO:
//  -- Pass the position in as script arguments.
//  -- Find/pass in a direction to begin facing.
//
//*****************************************************************************

var spawnX, spawnY, newCar;

// Create player car
spawnX = 303*64  +32;
spawnY = -153*64 +32;
newCar = instance_create(spawnX, spawnY, objBody);
newCar.z = 255 + 8;

// Move camera to car position
oCamera.CameraX = newCar.x;
oCamera.CameraY = newCar.y;

