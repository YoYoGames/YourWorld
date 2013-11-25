//*****************************************************************************
// pcCreateWheel();
//

var scale = argument2;
var inst = instance_create(argument0, argument1, objWheel);
var fixture = physics_fixture_create();
inst.scale = scale;
inst.image_xscale = scale;
inst.image_yscale = scale;

// Define shape, currently based on sprite size
physics_fixture_set_polygon_shape(fixture);
physics_fixture_add_point(fixture, 0-inst.sprite_xoffset, 0-inst.sprite_yoffset);
physics_fixture_add_point(fixture, 0+inst.sprite_xoffset, 0-inst.sprite_yoffset);
physics_fixture_add_point(fixture, 0+inst.sprite_xoffset, 0+inst.sprite_yoffset);
physics_fixture_add_point(fixture, 0-inst.sprite_xoffset, 0+inst.sprite_yoffset);

// Define properties
physics_fixture_set_density(fixture, 0.5);
physics_fixture_set_restitution(fixture, 0);
physics_fixture_set_collision_group(fixture, 0);
physics_fixture_set_linear_damping(fixture, 0);
physics_fixture_set_angular_damping(fixture, 0);
physics_fixture_set_friction(fixture, 0);
physics_fixture_set_awake(fixture, true);

// Bind to object and destroy to finish
physics_fixture_bind(fixture, inst);
physics_fixture_delete(fixture);

with (inst)
    {
    GetLateralVelocity();
    GetForwardVelocity();
    UpdateFriction();
    }
    
return inst;
    
