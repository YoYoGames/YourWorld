/// mesh = GetCacheEntry(GridX,GridY)
//

var gx = argument0;
var gy = argument1;


// Entry already exists. Check if we can add more, then return
var MeshA = ds_grid_get(Cache,gx,gy); 
if (is_array(MeshA))
    {
    return MeshA;
    }


// Generate all
if (global.TileCacheCreationCount > 0)
    {
    MeshA[3] = -1;
    MeshA = GenerateCacheEntry(gx, gy);
    ds_grid_set(Cache,gx,gy,MeshA);
    global.TileCacheCreationCount--;
    return MeshA;
    }
else
    {
    return MeshA;
    }

