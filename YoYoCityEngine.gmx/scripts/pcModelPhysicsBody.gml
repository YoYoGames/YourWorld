//*****************************************************************************
// pcModelPhysicsBody();
//

bodyFixture = physics_fixture_create();

var xoff = sprite_xoffset*3//77;//sprite_xoffset;
var yoff = sprite_yoffset*3//301;//sprite_yoffset;

// Define shape, currently based on sprite size
physics_fixture_set_polygon_shape(bodyFixture);
physics_fixture_add_point(bodyFixture, x1-xoff*scale, y1-yoff*scale);
physics_fixture_add_point(bodyFixture, x2-xoff*scale, y1-yoff*scale);
physics_fixture_add_point(bodyFixture, x2-xoff*scale, y2-yoff*scale);
physics_fixture_add_point(bodyFixture, x1-xoff*scale, y2-yoff*scale);

// Define properties
physics_fixture_set_density(bodyFixture, 1.5);
physics_fixture_set_restitution(bodyFixture, 0.25);
physics_fixture_set_collision_group(bodyFixture, 1);
physics_fixture_set_linear_damping(bodyFixture, 0.1);
physics_fixture_set_angular_damping(bodyFixture, 2.5);
physics_fixture_set_friction(bodyFixture, 0);
physics_fixture_set_awake(bodyFixture, true);

// Bind to object and destroy to finish
physics_fixture_bind(bodyFixture, id);

