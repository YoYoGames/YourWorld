//Get the normalised vector of the camera's facing direction

with(oCamera)
{
    //Normalise the camera facing direction
    var lx,ly,lz;
    lx = (CameraX+cos( dir*pi/180))-(CameraX);
    ly = (CameraY-sin( dir*pi/180))-(CameraY);
    lz = (CameraZ+tan(zdir*pi/180))-(CameraZ);
    var d = 1.0/sqrt(sqr(lx)+sqr(ly)+sqr(lz));
    lx = lx*d;
    ly = ly*d;
    lz = lz*d;
    
    //"Up" vector
    var ux,uy,uz;
    ux = (CameraX+cos( dir*pi/180))-(CameraX);//cos( dir*pi/180)//0;
    uy = (CameraY-sin( dir*pi/180))-(CameraY);//sin( dir*pi/180)//0;
    uz = (CameraZ+tan((zdir+90)*pi/180))-(CameraZ);//tan((zdir+90)*pi/180)//-1;
    var d = 1.0/sqrt(sqr(ux)+sqr(uy)+sqr(uz));
    ux = ux*d;
    uy = uy*d;
    uz = uz*d;
    
    //Initialise the size of the frustum's near plane and far plane
    nearDist = 10; //Near plane distance from camera
    Hnear = 200;   //The height of the near plane
    Wnear = 320;   //The width of the near plane
    farDist = 3000;//Far plane distance from camera
    Hfar = (Hnear*farDist)/100;   //The height of the far plane
    Wfar = (Wnear*farDist)/100;   //The width of the far plane
    
    //Calculate the "Right" vector
    //(a cross product of the "Up" vector and the camera facing direction)
    //http://www.lighthouse3d.com/tutorials/maths/vector-cross-product/
    var rx,ry,rz;
    rx = ly*uz-lz*uy;
    ry = lz*ux-lx*uz;
    rz = lx*uy-ly*ux;
    
    //Calculate far and near centre points
    var fcx,fcy,fcz;
    fcx = CameraX+lx*farDist;
    fcy = CameraY+ly*farDist;
    fcz = CameraZ+lz*farDist;
    
    var ncx,ncy,ncz;
    ncx = CameraX+lx*nearDist;
    ncy = CameraY+ly*nearDist;
    ncz = CameraZ+lz*nearDist;
    
    //Define coordinates
    
    //NEAR PLANE
    //Top left    
    Frustum_ntl_x = ncx+(ux*Hnear/2)-(rx*Wnear/2);
    Frustum_ntl_y = ncy+(uy*Hnear/2)-(ry*Wnear/2);
    Frustum_ntl_z = ncz+(uz*Hnear/2)-(rz*Wnear/2);
    //Top right     
    Frustum_ntr_x = ncx+(ux*Hnear/2)+(rx*Wnear/2);
    Frustum_ntr_y = ncy+(uy*Hnear/2)+(ry*Wnear/2);
    Frustum_ntr_z = ncz+(uz*Hnear/2)+(rz*Wnear/2);
    //Bottom left   
    Frustum_nbl_x = ncx-(ux*Hnear/2)-(rx*Wnear/2);
    Frustum_nbl_y = ncy-(uy*Hnear/2)-(ry*Wnear/2);
    Frustum_nbl_z = ncz-(uz*Hnear/2)-(rz*Wnear/2);
    //Bottom right  
    Frustum_nbr_x = ncx-(ux*Hnear/2)+(rx*Wnear/2);
    Frustum_nbr_y = ncy-(uy*Hnear/2)+(ry*Wnear/2);
    Frustum_nbr_z = ncz-(uz*Hnear/2)+(rz*Wnear/2);
    //FAR PLANE      
    //Top left    
    Frustum_ftl_x = fcx+(ux*Hfar/2)-(rx*Wfar/2);
    Frustum_ftl_y = fcy+(uy*Hfar/2)-(ry*Wfar/2);
    Frustum_ftl_z = fcz+(uz*Hfar/2)-(rz*Wfar/2);
    //Top right     
    Frustum_ftr_x = fcx+(ux*Hfar/2)+(rx*Wfar/2);
    Frustum_ftr_y = fcy+(uy*Hfar/2)+(ry*Wfar/2);
    Frustum_ftr_z = fcz+(uz*Hfar/2)+(rz*Wfar/2);
    //Bottom left   
    Frustum_fbl_x = fcx-(ux*Hfar/2)-(rx*Wfar/2);
    Frustum_fbl_y = fcy-(uy*Hfar/2)-(ry*Wfar/2);
    Frustum_fbl_z = fcz-(uz*Hfar/2)-(rz*Wfar/2);
    //Bottom right  
    Frustum_fbr_x = fcx-(ux*Hfar/2)+(rx*Wfar/2);
    Frustum_fbr_y = fcy-(uy*Hfar/2)+(ry*Wfar/2);
    Frustum_fbr_z = fcz-(uz*Hfar/2)+(rz*Wfar/2);
    
    
    //Define planes

    //0: TOP
    var a=0;
    Frustum_p1x[a] = Frustum_ntr_x;  Frustum_p1y[a] = Frustum_ntr_y;  Frustum_p1z[a] = Frustum_ntr_z;
    Frustum_p2x[a] = Frustum_ntl_x;  Frustum_p2y[a] = Frustum_ntl_y;  Frustum_p2z[a] = Frustum_ntl_z;
    Frustum_p3x[a] = Frustum_ftl_x;  Frustum_p3y[a] = Frustum_ftl_y;  Frustum_p3z[a] = Frustum_ftl_z;
    //1: BOTTOM                                                                       
    a=1;                                                                              
    Frustum_p1x[a] = Frustum_nbl_x;  Frustum_p1y[a] = Frustum_nbl_y;  Frustum_p1z[a] = Frustum_nbl_z;
    Frustum_p2x[a] = Frustum_nbr_x;  Frustum_p2y[a] = Frustum_nbr_y;  Frustum_p2z[a] = Frustum_nbr_z;
    Frustum_p3x[a] = Frustum_fbr_x;  Frustum_p3y[a] = Frustum_fbr_y;  Frustum_p3z[a] = Frustum_fbr_z;
    //2: LEFT                                                                         
    a=2;                                                                              
    Frustum_p1x[a] = Frustum_ntl_x;  Frustum_p1y[a] = Frustum_ntl_y;  Frustum_p1z[a] = Frustum_ntl_z;
    Frustum_p2x[a] = Frustum_nbl_x;  Frustum_p2y[a] = Frustum_nbl_y;  Frustum_p2z[a] = Frustum_nbl_z;
    Frustum_p3x[a] = Frustum_fbl_x;  Frustum_p3y[a] = Frustum_fbl_y;  Frustum_p3z[a] = Frustum_fbl_z;
    //3: RIGHT                                                                        
    a=3;                                                                              
    Frustum_p1x[a] = Frustum_nbr_x;  Frustum_p1y[a] = Frustum_nbr_y;  Frustum_p1z[a] = Frustum_nbr_z;
    Frustum_p2x[a] = Frustum_ntr_x;  Frustum_p2y[a] = Frustum_ntr_y;  Frustum_p2z[a] = Frustum_ntr_z;
    Frustum_p3x[a] = Frustum_fbr_x;  Frustum_p3y[a] = Frustum_fbr_y;  Frustum_p3z[a] = Frustum_fbr_z;
    //4: NEARP                                                                        
    a=4;                                                                              
    Frustum_p1x[a] = Frustum_ntl_x;  Frustum_p1y[a] = Frustum_ntl_y;  Frustum_p1z[a] = Frustum_ntl_z;
    Frustum_p2x[a] = Frustum_ntr_x;  Frustum_p2y[a] = Frustum_ntr_y;  Frustum_p2z[a] = Frustum_ntr_z;
    Frustum_p3x[a] = Frustum_nbr_x;  Frustum_p3y[a] = Frustum_nbr_y;  Frustum_p3z[a] = Frustum_nbr_z;
    //5: FARP                                                                        
    a=5;                                                                             
    Frustum_p1x[a] = Frustum_ftr_x;  Frustum_p1y[a] = Frustum_ftr_y;  Frustum_p1z[a] = Frustum_ftr_z;
    Frustum_p2x[a] = Frustum_ftl_x;  Frustum_p2y[a] = Frustum_ftl_y;  Frustum_p2z[a] = Frustum_ftl_z;
    Frustum_p3x[a] = Frustum_fbl_x;  Frustum_p3y[a] = Frustum_fbl_y;  Frustum_p3z[a] = Frustum_fbl_z;
                                                   
    //Plane-specific 
    for(var i=0; i<6; i+=1)
    {                
        //Plane coordinates defined as vectors
        var Frustum_pv1x,Frustum_pv1y,Frustum_pv1z,Frustum_pv2x,Frustum_pv2y,Frustum_pv2z;
        Frustum_pv1x[i] = Frustum_p2x[i]-Frustum_p1x[i];
        Frustum_pv1y[i] = Frustum_p2y[i]-Frustum_p1y[i];
        Frustum_pv1z[i] = Frustum_p2z[i]-Frustum_p1z[i];
        Frustum_pv2x[i] = Frustum_p3x[i]-Frustum_p1x[i];
        Frustum_pv2y[i] = Frustum_p3y[i]-Frustum_p1y[i];
        Frustum_pv2z[i] = Frustum_p3z[i]-Frustum_p1z[i];
        
        //Cross product of the plane vectors
        Frustum_cppx[i] = Frustum_pv1y[i]*Frustum_pv2z[i]-Frustum_pv1z[i]*Frustum_pv2y[i];
        Frustum_cppy[i] = Frustum_pv1z[i]*Frustum_pv2x[i]-Frustum_pv1x[i]*Frustum_pv2z[i];
        Frustum_cppz[i] = Frustum_pv1x[i]*Frustum_pv2y[i]-Frustum_pv1y[i]*Frustum_pv2x[i]; //plane.normal
        
        //Normalise the cross product
        var d = 1.0/sqrt( sqr(Frustum_cppx[i])+sqr(Frustum_cppy[i])+sqr(Frustum_cppz[i]) );
        Frustum_cppx[i] *= d;
        Frustum_cppy[i] *= d;
        Frustum_cppz[i] *= d;
        
        //Calculate length of the line from 0,0 to the first coordinate of the plane
        Frustum_pdis[i]=sqrt(sqr(Frustum_p1x[i])+sqr(Frustum_p1y[i])+sqr(Frustum_p1z[i])); //plane.distance
    }
}

