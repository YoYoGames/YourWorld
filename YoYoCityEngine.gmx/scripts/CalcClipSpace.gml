//
// Calculate the clip area needed for the current (top-down) camera view
// The ground is at Z=0, meaning we can solve the equation below easily as farDist = CameraZ-0
//
// Hfar = 2 * tan(fov / 2) * farDist
// Wfar = Hfar * ratio
//
// http://zach.in.tu-clausthal.de/teaching/cg_literatur/lighthouse3d_view_frustum_culling/
//


if( global.Map>=0 ){
    var Hfar = 2*tan(degtorad(FOV)/2)*(abs(CameraZ));
    var Wfar = Hfar*AspectRatio;

    if(global.Mode==MODE_EDIT )
    {
        GroundX1 = 0;
        GroundX2 = 100000;
        GroundY1 = 0;
        GroundY2 = 100000;
    }else{
        GroundX1 = CameraX - Wfar*0.5;
        GroundX2 = CameraX + Wfar*0.5;
        GroundY1 = -CameraY - Hfar*0.5;         // Y positions are negated
        GroundY2 = -CameraY + Hfar*0.5;
    }
}

