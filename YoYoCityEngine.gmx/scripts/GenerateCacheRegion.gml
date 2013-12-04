/// FreeCacheRegion(map,x1,y1,x2,y2)
//
// Free a region of cache
// argument0 = map
// argument1 = x1
// argument2 = y1
// argument3 = x2
// argument4 = y2
//
with(argument0)
{
    var stepsize = GridCacheSize;
    var gx1 = floor(argument1/stepsize);
    var gy1 = floor(argument2/stepsize);
    var gx2 = floor(argument3/stepsize);
    var gy2 = floor(argument4/stepsize);
    
    for(var yy=gy1;yy<=gy2;yy++)
    {
        for(var xx=gx1;xx<=gx2;xx++)
        {
            global.TileCacheCreationCount=1;
            if( xx>=0 && xx<CacheWidth && yy>=0 && yy<CacheHeight ){
                GetCacheEntry(xx,yy);
            }
        }
    }

}
