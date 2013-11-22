/// FreeCacheRegion(map,GridCellX1,GridCellY1,GridCellX2,GridCellY2)
//
// Free a region of cache
// argument0 = x1
// argument1 = y1
// argument2 = x2
// argument3 = y2
//

/*show_debug_message("tl: "+string(argument0)+","+string(argument1));
show_debug_message("t2: "+string(argument2)+","+string(argument3));

var stepsize = GridCacheSize;
var gx1 = floor(argument0/stepsize);
var gy1 = floor(argument1/stepsize);
var gx2 = floor(argument2/stepsize);
var gy2 = floor(argument3/stepsize);

show_debug_message("tl: "+string(gx1)+","+string(gy1));
show_debug_message("t2: "+string(gx2)+","+string(gy2));

for(var yy=gy1;yy<=gy2;yy++)
{
    show_debug_message("yy="+string(yy));
    for(var xx=gx1;xx<=gx2;xx++)
    {
        show_debug_message("xx="+string(xx));
        FreeCacheEntry(xx*stepsize,yy*stepsize);
    }
}
*/

with(argument0)
{
    for(var yy=argument2;yy<=argument4;yy++)
    {
        for(var xx=argument1;xx<=argument3;xx++)
        {
            FreeCacheEntry(xx,yy);
        }
    }
}
