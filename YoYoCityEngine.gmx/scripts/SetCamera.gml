/// SetCamera(cam);
//
//  Initialise the camera
//
//*****************************************************************************

with(argument0)
    {
    // Directions the camera is facing (X/Y axis and Z axis)
    dir = 0;
    zdir = 180;
    
    CameraX = 0;
    CameraY = 0;
    CameraZ = -1000;
    global.Camera = argument0;
    
    FOV = 45;
    AspectRatio = room_width/room_height;
    
    // Clip zone based on camera position and height
    GroundX1 = 0;
    GroundY1 = 0;
    GroundX2 = 0;
    GroundY2 = 0;
    
    d3d_start();
    d3d_set_perspective(true);
    d3d_set_hidden(true);
    d3d_set_culling(true);        
    d3d_set_projection_perspective(0,0, room_width, room_height, 90);  
    vsync = false;
    AA = 0;       
    }

