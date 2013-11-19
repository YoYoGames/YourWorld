/// Process the Editor state
var camera = global.Camera;

if !instance_exists(oHUDParent)
{
    camera.dir += (display_mouse_get_x()-display_get_width()/2)/6
    camera.zdir += (display_mouse_get_y()-display_get_height()/2)/6
    camera.zdir = clamp(camera.zdir,-80,+80)
    display_mouse_set(display_get_width()/2,display_get_height()/2)
}

//Set four temporary variables to whether the player is pressing each of the four direction buttons
var Cl,Cu,Cr,Cd,KZup,KZdown;
Cu=keyboard_check(ord("W")) or keyboard_check(vk_up);
Cl=keyboard_check(ord("A")) or keyboard_check(vk_left);
Cd=keyboard_check(ord("S")) or keyboard_check(vk_down);
Cr=keyboard_check(ord("D")) or keyboard_check(vk_right);
KZup=keyboard_check(vk_pageup);
KZdown=keyboard_check(vk_pagedown);
Kshift=keyboard_check(vk_lshift) or keyboard_check(vk_rshift);


//Forward/backward and strafing speed (quartered if you're holding left shift)
var CameraVSpeed=global.YSpeed; 
var CameraHSpeed=global.XSpeed; 

if(keyboard_check(vk_lshift) )
{
    CameraVSpeed/=4; 
    CameraHSpeed/=4; 
}
if((global.Mode==MODE_PLAY) )
{
    CameraVSpeed*=-1;
    CameraHSpeed*=-1;
}

//Move the camera if you're telling it to
if Cu {camera.CameraX+=lengthdir_x(CameraVSpeed,camera.dir   );camera.CameraY+=lengthdir_y(CameraVSpeed,camera.dir   );}
if Cl {camera.CameraX+=lengthdir_x(CameraHSpeed,camera.dir-90);camera.CameraY+=lengthdir_y(CameraHSpeed,camera.dir-90);}
if Cd {camera.CameraX-=lengthdir_x(CameraVSpeed,camera.dir   );camera.CameraY-=lengthdir_y(CameraVSpeed,camera.dir   );}
if Cr {camera.CameraX+=lengthdir_x(CameraHSpeed,camera.dir+90);camera.CameraY+=lengthdir_y(CameraHSpeed,camera.dir+90);}
if( Kshift ){
    if( KZdown ) camera.CameraZ += global.ZSpeed/4;
    if( KZup ) camera.CameraZ -= global.ZSpeed/4;
}else{
    if( KZdown ) camera.CameraZ += global.ZSpeed;
    if( KZup ) camera.CameraZ -= global.ZSpeed;
}
camera.CameraZ=min(-32,camera.CameraZ)



