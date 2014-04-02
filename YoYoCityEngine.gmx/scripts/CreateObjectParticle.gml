/// CreateObjectParticle(x, y, z, sprite, index, speed, direction);
//
//  Creates an object particle with the given properties.
//  This is a physical particle, that'll collide with buildings and other particles.
//
//*****************************************************************************

var newParticle;
newParticle = instance_create(argument0, argument1, objObjectParticle);
with (newParticle)
    {
    z = argument2;
    sprite_index = argument3;
    image_speed = 0;
    image_index = argument4;
    phy_speed_x = lengthdir_x(argument5, argument6);
    phy_speed_y = lengthdir_y(argument5, argument6);
    }

