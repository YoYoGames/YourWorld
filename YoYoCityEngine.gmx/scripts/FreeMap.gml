/// Free the map completely


// First free the map arrays
ds_grid_destroy(Map);
ds_grid_destroy(Sprites);
Map=-1;
Sprites=-1;

// free render list
RenderList = 0;


// Next destroy the cache
var gw=(MapWidth+GridCacheSize-1)/GridCacheSize;
var gh=(MapHeight+GridCacheSize-1)/GridCacheSize;
for(var yy=0;yy<gh;yy++){
    for(var xx=0;xx<gw;xx++){
        FreeCacheEntry(id, xx,yy);
    }
}
ds_grid_destroy(Cache);
Cache=-1;

// Now delete the block_info structs
var len = array_length_1d(block_info);
for(xx=0;xx<len;xx++){
    block_info[xx]=0;
}
block_info=0;
block_info_size=0;


// Lastly delete the ref count array, and the free array
ds_stack_destroy(FreeList);
RefCount = 0;


// Destroy physics controller and other gameplay stuff
with (objPhysicsController) instance_destroy();
with (objTrafficSpawner) instance_destroy();
with (parObject) instance_destroy();

