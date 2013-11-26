//argument0: x
//argument1: y
//argument2: z
//argument3: r

with(oCamera)
{
    if (point_distance_3d(CameraX,CameraY,CameraZ,argument0,argument1,argument2)>farDist+argument3)
    {
        return false;
    }
    else                                                                                          
    {
        var result=true;
        
        for(var i=0; i<6; i+=1)
        {
            //If the point is infront of the plane, result remains true
            if (dot_product_3d(Frustum_cppx[i],Frustum_cppy[i],Frustum_cppz[i],argument0,argument1,argument2)+Frustum_pdis[i]<0)
            {
                return false;    
            }            
        }
        
        return result;
    }
}
