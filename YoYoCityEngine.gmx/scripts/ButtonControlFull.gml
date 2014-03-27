///ButtonControlFull(sprite,sub,tooltip,advance)

draw_sprite(argument0,mouse_hold_rectangle(buttonX,buttonY,buttonX+buttonS,buttonY+buttonS)+argument1,buttonX,buttonY);

if( mouse_release_rectangle(buttonX,buttonY,buttonX+buttonS,buttonY+buttonS,string(argument2)) )
{
    var rtn=true;            
}
else
{
    var rtn=false;
}

if( mouse_rectangle(buttonX,buttonY,buttonX+buttonS,buttonY+buttonS) )
{
    with(oController) {alarm[0]=2;}
    
    HoverContent=argument0;
    HoverX=buttonX;
}

if( argument3==true ) buttonX+=buttonS;

return rtn;
