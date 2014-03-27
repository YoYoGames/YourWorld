/// CreateSplat(x, y, z, sprite, scale);
//
//  
//
//*****************************************************************************

// Create new splat and position
var newSplat;
newSplat = instance_create(argument0, argument1, objSplat);
newSplat.z = argument2;
newSplat.sprite_index = argument3;
newSplat.image_xscale = argument4;
newSplat.image_yscale = image_yscale;
newSplat.image_angle = random(360);


// If the given sprite has animation frames
if (sprite_get_number(argument3) > 1)
    {
    newSplat.animated = true;
    newSplat.image_speed = 0.5;
    newSplat.image_index = 1;
    newSplat.alpha = 1000000;
    }

