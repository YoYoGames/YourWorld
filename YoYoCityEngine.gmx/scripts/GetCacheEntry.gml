//
// AddCacheEntry( Mesh, Polys )
//
// mesh = GenerateGridRegion( GridX,GridY )
//
var gx = argument0;
var gy = argument1;

var MeshA = ds_grid_get(Cache,gx,gy); 
if( is_array(MeshA) ){
    return MeshA;
}
if( global.TileCacheCreationCount>0 )
{
    MeshA = GenerateCacheEntry( gx,gy );
    ds_grid_set(Cache,gx,gy,MeshA);
    global.TileCacheCreationCount--;
    return MeshA;
}else{
    return MeshA;
}


