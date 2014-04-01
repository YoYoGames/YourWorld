///ButtonControlSub(sprite,sub,tooltip)

buttonX=HoverX;
buttonY+=buttonS;

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
}

return rtn;