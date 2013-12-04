/// FreeCacheRegion(map,GridCellX1,GridCellY1,GridCellX2,GridCellY2)
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
        show_debug_message("yy="+string(yy));
        for(var xx=gx1;xx<=gx2;xx++)
        {
            show_debug_message("xx="+string(xx));
            FreeCacheEntry(id, xx*stepsize,yy*stepsize);
        }
    }

}
