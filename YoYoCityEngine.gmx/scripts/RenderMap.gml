// gx1 = argument0      grid top left
// gy1 = argument1
// gx2 = argument2      grid bottom right
// gy2 = argument3
// texture = argument4  texture to render with
// shader = argument5   shader to use

{
    var _gx1 = argument0
    var _gy1 = argument1
    var _gx2 = argument2
    var _gy2 = argument3
    var _texture = argument4
    var _shader = argument5
    
    frustum_build();

    draw_enable_alphablend(false);
    shader_set( _shader );
/*
    global.TileCacheCreationCount = 2;
    var scale = GridCacheSize*TileSize;
    var cx = (GridCacheSize*TileSize)/2;
    var cy = (GridCacheSize*TileSize)/2;
    var cz = (GridCacheSize*TileSize)/2;
    var rad = sqrt(cz*cz + cx*cx + cy*cy);
    var max_gx = floor(MapWidth/GridCacheSize);
    var scale = GridCacheSize*TileSize;
    var half_scale = scale/2;
    for(var yy=0;yy<max_gx;yy++){
        for(var xx=0;xx<max_gx;xx++){
            var sx = (xx*scale)+half_scale;
            var sy = (-yy*scale)-half_scale;
            var inout = frustum_test_sphere( sx,sy,0, rad );
            if( inout) {
                var MeshA = GetCacheEntry(xx,yy);
                if( is_array(MeshA) ){
                    vertex_submit(MeshA[0], pr_trianglelist,_texture);
                    global.CurrentPolyCount += MeshA[1];
                }
            }
        }
    }
*/
           
    global.TileCacheCreationCount = 2;
    var CacheWidth = floor(MapWidth/GridCacheSize);
    var CacheHeight = floor(MapWidth/GridCacheSize);
    if( _gx1>CacheWidth ) _gx1=CacheWidth;
    if( _gx2>CacheWidth ) _gx2=CacheWidth;
    if( _gy1>CacheHeight ) _gy1=CacheHeight;
    if( _gy2>CacheHeight ) _gy2=CacheHeight;
    for(var yy=_gy1;yy<_gy2;yy++){
        for(var xx=_gx1;xx<_gx2;xx++){
            if( xx>=0 && xx<CacheWidth) && (yy>=0 && yy<CacheHeight)
            {
                var MeshA = GetCacheEntry(xx,yy);
                if( is_array(MeshA) ){
                    vertex_submit(MeshA[0], pr_trianglelist,_texture);
                    global.CurrentPolyCount += MeshA[1];
                }
            }
        }
    }        

    shader_reset();
    draw_enable_alphablend(true);        
}
