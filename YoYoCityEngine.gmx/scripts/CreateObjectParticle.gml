/// CreateObjectParticle(x, y, z, sprite, index, speed, direction);
//

var newParticle;
newParticle = instance_create(argument0, argument1, objObjectParticle);
newParticle.z = argument2;
newParticle.sprite_index = argument3;
newParticle.image_speed = 0;
newParticle.image_index = argument4;
newParticle.phy_speed_x = lengthdir_x(argument5, argument6);
newParticle.phy_speed_y = lengthdir_y(argument5, argument6);

