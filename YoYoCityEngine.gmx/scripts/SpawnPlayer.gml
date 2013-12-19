/// SpawnPlayer()
// Create player car
var spawnX = 303*64  +32;
var spawnY = -153*64 +32;
var newCar = instance_create(spawnX, spawnY, objBody);
newCar.z = 255 + 8;

// Move camera to car position
oCamera.CameraX = newCar.x;
oCamera.CameraY = newCar.y;

