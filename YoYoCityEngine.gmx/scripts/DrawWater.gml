/// DrawWater()
//
// Draw the water plane
//
{
        d3d_set_zwriteenable(false);
        d3d_set_culling(false);
        texture_set_repeat(true);
        d3d_set_lighting(false);
        texture_set_interpolation(true);
        texture_set_repeat(true);
        
        // First set surfaces and reset projection
        var texture = sprite_get_texture(sprite_index,image_index); 
        //surface_set_target(global.Map.DiffuseSurface);
        //SetProjection();
         
        var s = sin(degtorad(ang))*16;
        
        var m = matrix_build(0,0,(-2.2*64)+s,0,0,0,1,1,1);
        matrix_set(matrix_world,m);
        
        // Now render the map
        shader_set(WaterShader);
        vertex_submit(WaterMesh, pr_trianglelist,texture);        
        shader_reset();
                
        //surface_reset_target();
        texture_set_repeat(false);
        texture_set_interpolation(false);
        d3d_set_culling(true);
        texture_set_repeat(false);
        d3d_set_zwriteenable(true);

        ang+=1;
        if( ang>360 ) ang-=360;
}


