/// Process the Editor state
var camera = global.Camera;

//Set four temporary variables to whether the player is pressing each of the four direction buttons
var Cl,Cu,Cr,Cd,KZup,KZdown,Cspace,AllowPick;
Cspace=keyboard_check_pressed(vk_f1);
Cu=keyboard_check(ord("W")) or keyboard_check(vk_up);
Cl=keyboard_check(ord("A")) or keyboard_check(vk_left);
Cd=keyboard_check(ord("S")) or keyboard_check(vk_down);
Cr=keyboard_check(ord("D")) or keyboard_check(vk_right);
KZup=keyboard_check(vk_pageup) or keyboard_check(vk_space);
KZdown=keyboard_check(vk_pagedown) or keyboard_check(vk_lshift) or keyboard_check(vk_rshift);
Kshift=keyboard_check(ord("C"))//keyboard_check(vk_lshift) or keyboard_check(vk_rshift);
KZctrl=keyboard_check(vk_control);
KMleft=mouse_check_button(mb_left);
KMmiddle=mouse_check_button(mb_middle);
KMright=mouse_check_button(mb_right);
KMwheelup=mouse_wheel_up();
KMwheeldown=mouse_wheel_down();
Kinsert=keyboard_check(ord("F"));
Kdelete=keyboard_check(ord("E"));
Kescape=keyboard_check(vk_escape);
AllowPick=true;

{
    //Forward/backward and strafing speed (quartered if you're holding left shift)
    var CameraVSpeed=global.YSpeed; 
    var CameraHSpeed=global.XSpeed; 
    
    if(Kshift || KZctrl)
    {
        CameraVSpeed/=4; 
        CameraHSpeed/=4; 
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
}


if( FreeCursorMode==1 ){
}else{
    camera.dir  +=( display_mouse_get_x()- (window_get_x()+(window_get_width() /2)) )/6
    camera.zdir +=( display_mouse_get_y()- (window_get_y()+(window_get_height()/2)) )/6
    camera.zdir = clamp(camera.zdir,-80,+80)
    display_mouse_set(window_get_x()+(window_get_width()/2),window_get_y()+(window_get_height()/2))

}

if( AllowPick )
{
    //Allow the clicks through to the 3D world unless the mouse is in an area occupied by the GUI
    var HaltProcessing=false;
    
    if (instance_exists(oHUDParent))
    {
        if (mouse_rectangle(oHUDParent.x,oHUDParent.y,oHUDParent.x+oHUDParent.WindowWidth,oHUDParent.y+oHUDParent.WindowHeight)
        or oHUDParent.Holding>0)
        {
            HaltProcessing=true;
        }
    }
    
    if (instance_exists(oHUDMain) && mouse_rectangle(0,0,window_get_width(),56))
    {
        HaltProcessing=true;
    }
    
    if (!HaltProcessing)
    {
        if( global.EditorMode==EDIT_SELECTION )
        or (global.EditorMode==EDIT_ROADS)
            ProcessPicking();
        if( global.EditorMode==EDIT_PAINT ) ProcessPainting();
    }
}
