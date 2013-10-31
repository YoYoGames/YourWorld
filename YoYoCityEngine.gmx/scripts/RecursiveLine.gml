// line[] = argument0
// count  = argument1
// depth  = argument2

var list = argument0;
var line = argument1;
var count=argument2;
var _depth =  argument3;

var xx,yy,xx2,yy2;

for(var i=0;i<count;i++)
{
    var horiz = false;
    // horizontal or vertical?
    if(line[0]==line[2]){
        // if  vertical, we need a horizontal split
        xx = line[0];
        yy = line[1];
        split = line[3]-line[1];
    
    }else{
        // if  horizontal, we need a vertical split
        // for vertical splits, we just pretend its a horizonal one, then flip it at the end
        horiz = true;
        xx = line[1];
        yy = line[0];
        split = line[2]-line[0];
        
    }
    if( split<10 ) return false;

    var done=false;
    var attempt=0;
    while(!done){
        var starty = irandom(split) + yy + 5;
        var startx = irandom(250)+5;
        var dir = irandom(1);
        if( dir==0 ) startx = -startx;
        startx+=xx;       
        if( startx>xx ){
            var tx = xx;
            xx = startx;
            startx=tx;
        }
        
        var newline=0;                 // setting to 0 clears the array  (VAR scoping)
        newline[0]= startx;
        newline[2]= xx;
        newline[1] = starty;
        newline[3] = starty;
        newline[4]= !horiz;             // opposit of last line
        done = CheckLine(list,newline,10);
        //if(!done) show_debug_message("inner");
        attempt++;
        if(attempt>10) return false;
    }
    if( horiz){
        var tx = newline[0];
        newline[0]=newline[1];
        newline[1]=tx;
        tx = newline[2];
        newline[2]=newline[3];
        newline[3]=tx;
    }

    for(var o=0;o<4;o++){
        if( newline[o]<5 )newline[o]=5;
        if( newline[o]>250 )newline[o]=250;
    }

    
        
    //show_debug_message("count="+string(i)+":  ("+string(newline[0])+","+string(newline[1])+"), ("+string(newline[2])+","+string(newline[3])+")");
    ds_list_add(list, newline);
    global.linecount++;
    if( (_depth-1)>=0){
        RecursiveLine(list, newline, count, _depth-1);    
    }

}
