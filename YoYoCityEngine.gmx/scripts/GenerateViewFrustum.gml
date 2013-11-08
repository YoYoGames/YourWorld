//Get the normalised vector of the camera's facing direction

with(oCamera)
{
    //Normalise the camera facing direction
    var lx,ly,lz;
    lx = (CameraX)-(CameraX+cos( dir*pi/180));
    ly = (CameraY)-(CameraY-sin( dir*pi/180));
    lz = (CameraZ)-(CameraZ+tan(zdir*pi/180));
    var d = 1.0/sqrt(lx*lx+ly*ly+lz*lz);
    lx = lx*d;
    ly = ly*d;
    lz = lz*d;
    
    //"Up" vector
    var ux,uy,uz;
    ux=0;
    uy=0;
    uz=-1;
    
    //Initialise the size of the fructum's near plane and far plane
    var nearDist=10; //Near plane distance from camera
    var Hnear=200;   //The height of the near plane
    var Wnear=320;   //The width of the near plane
    var farDist=1000;//Far plane distance from camera
    var Hfar=1080;   //The height of the far plane
    var Wfar=1920;   //The width of the far plane
    
    //Calculate the "Right" vector
    //(a cross product of the "Up" vector and the camera facing direction)
    //http://www.lighthouse3d.com/tutorials/maths/vector-cross-product/
    var rx,ry,rz;
    rx=ly*uz-lz*uy;
    ry=lz*ux-lx*uz;
    rz=lx*uy-ly*ux;
    
    //Calculate far and near centre points
    var fcx,fcy,fcz;
    fcx=CameraX+lx*farDist;
    fcy=CameraY+ly*farDist;
    fcz=CameraZ+lz*farDist;
    
    var ncx,ncy,ncz;
    ncx=CameraX+lx*nearDist;
    ncy=CameraY+ly*nearDist;
    ncz=CameraZ+lz*nearDist;
    
    //NEAR PLANE
    //Top left
    Frustum_ntl_x=ncx+(ux*Hnear/2)-(rx*Wnear/2);
    Frustum_ntl_y=ncy+(uy*Hnear/2)-(ry*Wnear/2);
    Frustum_ntl_z=ncz+(uz*Hnear/2)-(rz*Wnear/2);
    //Top right
    Frustum_ntr_x=ncx+(ux*Hnear/2)+(rx*Wnear/2);
    Frustum_ntr_y=ncy+(uy*Hnear/2)+(ry*Wnear/2);
    Frustum_ntr_z=ncz+(uz*Hnear/2)+(rz*Wnear/2);
    //Bottom left
    Frustum_nbl_x=ncx-(ux*Hnear/2)-(rx*Wnear/2);
    Frustum_nbl_y=ncy-(uy*Hnear/2)-(ry*Wnear/2);
    Frustum_nbl_z=ncz-(uz*Hnear/2)-(rz*Wnear/2);
    //Bottom right
    Frustum_nbr_x=ncx-(ux*Hnear/2)+(rx*Wnear/2);
    Frustum_nbr_y=ncy-(uy*Hnear/2)+(ry*Wnear/2);
    Frustum_nbr_z=ncz-(uz*Hnear/2)+(rz*Wnear/2);
    //FAR PLANE
    //Top left
    Frustum_ftl_x=fcx+(ux*Hfar/2)-(rx*Wfar/2);
    Frustum_ftl_y=fcy+(uy*Hfar/2)-(ry*Wfar/2);
    Frustum_ftl_z=fcz+(uz*Hfar/2)-(rz*Wfar/2);
    //Top right
    Frustum_ftr_x=fcx+(ux*Hfar/2)+(rx*Wfar/2);
    Frustum_ftr_y=fcy+(uy*Hfar/2)+(ry*Wfar/2);
    Frustum_ftr_z=fcz+(uz*Hfar/2)+(rz*Wfar/2);
    //Bottom left
    Frustum_fbl_x=fcx-(ux*Hfar/2)-(rx*Wfar/2);
    Frustum_fbl_y=fcy-(uy*Hfar/2)-(ry*Wfar/2);
    Frustum_fbl_z=fcz-(uz*Hfar/2)-(rz*Wfar/2);
    //Bottom right
    Frustum_fbr_x=fcx-(ux*Hfar/2)+(rx*Wfar/2);
    Frustum_fbr_y=fcy-(uy*Hfar/2)+(ry*Wfar/2);
    Frustum_fbr_z=fcz-(uz*Hfar/2)+(rz*Wfar/2);
}

