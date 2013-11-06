// Single copy of the projection line... This is needed everytime you set a surface
var cam = global.Camera;
d3d_set_projection_ext(cam.CameraX,cam.CameraY,cam.CameraZ,  cam.CameraX,cam.CameraY,1024, 0,1,0,  cam.FOV, cam.AspectRatio,  32, 20000.0);
