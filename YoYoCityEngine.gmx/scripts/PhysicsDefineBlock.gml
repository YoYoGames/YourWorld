
var width  = 512;
var height = 512;

global.physicsBlock = physics_fixture_create();

// Use this if the block origin is to be centered
//physics_fixture_set_box_shape(global.physicsBlock, width/2, height/2);

// Use this if block origin is to be in the top left (0, 0)
physics_fixture_set_polygon_shape(global.physicsBlock);
physics_fixture_add_point(global.physicsBlock, 0,     0);
physics_fixture_add_point(global.physicsBlock, width, 0);
physics_fixture_add_point(global.physicsBlock, width, height);
physics_fixture_add_point(global.physicsBlock, 0,     height);

// Apply settings
physics_fixture_set_density(global.physicsBlock, 0);
physics_fixture_set_restitution(global.physicsBlock, 0);
physics_fixture_set_collision_group(global.physicsBlock, 1);
physics_fixture_set_linear_damping(global.physicsBlock, 0);
physics_fixture_set_angular_damping(global.physicsBlock, 0);
physics_fixture_set_friction(global.physicsBlock, 0);

