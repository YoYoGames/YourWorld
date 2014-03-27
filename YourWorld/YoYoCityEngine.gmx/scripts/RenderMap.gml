/// RenderMap(GridX1,GridY1,GridX2,GridY2,TileTexture,SpriteTexture,TileShader,SpriteShader)
//
// gx1 = argument0      grid top left
// gy1 = argument1
// gx2 = argument2      grid bottom right
// gy2 = argument3
// texture = argument4  texture to render with
// shader = argument5   sides+lid shader to use  (-1 dont draw)
// shader = argument5   sprite shader to use (-1 don't draw)
//
{
    var _gx1 = argument0
    var _gy1 = argument1
    var _gx2 = argument2
    var _gy2 = argument3
    var _texture = argument4
    var _sprtexture = argument5
    var _shader = argument6
    var _spriteshader = argument7

    var xx,yy,i,MeshA,RenderListCount;
    
   
           
    // First get a list of all sectors we want to draw (do culling etc)
    global.TileCacheCreationCount = 1;                  // Number of tiles to create each frame
    RenderListCount=0;                                  // Number of tiles in render list
    var CacheWidth = floor(MapWidth/GridCacheSize);
    var CacheHeight = floor(MapWidth/GridCacheSize);
    if (_gx1>CacheWidth) _gx1 = CacheWidth;
    if (_gx2>CacheWidth) _gx2 = CacheWidth;
    if (_gy1>CacheHeight) _gy1 = CacheHeight;
    if (_gy2>CacheHeight) _gy2 = CacheHeight;
    for(yy=_gy1;yy<_gy2;yy++){
        for(xx=_gx1;xx<_gx2;xx++){
            if( xx>=0 && xx<CacheWidth) && (yy>=0 && yy<CacheHeight)
            {
                MeshA = GetCacheEntry(xx,yy);
                if (is_array(MeshA))
                {
                    RenderList[RenderListCount]=MeshA;
                    RenderListCount++;
                    global.CurrentPolyCount += MeshA[2];
                }
            }
        }
    }
    
    // Now, pass 1. Render all building sides and lids
    if( _shader>=0 )
    {
        draw_enable_alphablend(false);
        shader_set(_shader);
        for(i=0;i<RenderListCount;i++){
            MeshA = RenderList[i];
            if( MeshA[0]!=-1 ){
                vertex_submit(MeshA[0], pr_trianglelist,_texture);
            }        
        }
        shader_reset();
        draw_enable_alphablend(true);  
    }
    
    
    
    // Now, pass 2. Render all Decals
    if (global.decalsVisible)
        {
        if( _spriteshader>=0 )
            {
            shader_set( _spriteshader );
            for(i=0;i<RenderListCount;i++)
                {
                MeshA = RenderList[i];
                if (MeshA[1] != -1)
                    vertex_submit(MeshA[1], pr_trianglelist,_sprtexture);
                }
            shader_reset();
            }
        }
    
    
    // Render all road direction flags
    if (global.renderRoadFlags)
        {
        d3d_set_lighting(false);
        var _arrowsTexture = sprite_get_texture(sprRoadArrows, 0);
        for(i=0;i<RenderListCount;i++)
            {
            MeshA = RenderList[i];
            if( MeshA[3]!=-1 )
                {
                vertex_submit(MeshA[3], pr_trianglelist, _arrowsTexture);
                }
            }
        //d3d_set_lighting(true);
        }

      
}
