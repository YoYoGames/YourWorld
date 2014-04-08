/// ProcessKeys()

if( instance_exists(oHeadMenu) ) exit;

var camera = global.Camera;

//Set four temporary variables to whether the player is pressing each of the four direction buttons
var Kleft,Kup,Kright,Kdown,KZup,KZdown,Kshift;

Kup=keyboard_check(ord("W")) or keyboard_check(vk_up);
Kleft=keyboard_check(ord("A")) or keyboard_check(vk_left);
Kdown=keyboard_check(ord("S")) or keyboard_check(vk_down);
Kright=keyboard_check(ord("D")) or keyboard_check(vk_right);
KZup=keyboard_check(vk_pageup);
KZdown=keyboard_check(vk_pagedown);
Kshift=keyboard_check(vk_lshift) or keyboard_check(vk_rshift);


if (!instance_exists(objBody))
    {
    if (Kshift)
        {
        if (KZdown) camera.CameraZ += global.ZSpeed/4;
        if (KZup)   camera.CameraZ -= global.ZSpeed/4;
        if (Kleft)  camera.CameraX -= global.XSpeed/4;
        if (Kright) camera.CameraX += global.XSpeed/4;
        if (Kup)    camera.CameraY += global.YSpeed/4;
        if (Kdown)  camera.CameraY -= global.YSpeed/4;
        }
    else
        {
        if (KZdown) camera.CameraZ += global.ZSpeed;
        if (KZup)   camera.CameraZ -= global.ZSpeed;
        if (Kleft)  camera.CameraX -= global.XSpeed;
        if (Kright) camera.CameraX += global.XSpeed;
        if (Kup)    camera.CameraY += global.YSpeed;
        if (Kdown)  camera.CameraY -= global.YSpeed;
        }
    }

camera.CameraZ = min(-32, camera.CameraZ);
