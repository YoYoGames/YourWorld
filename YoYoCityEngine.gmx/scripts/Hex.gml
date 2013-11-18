/// string = Hex(value)
var _colour=argument0;

var hex="";
var shift=28;
for(var d=0;d<8;d++){
    var v = (_colour>>shift)&$f;
    if( v>9 ) 
        v=((v-10)+ord("A"));
    else
        v+=ord("0");
    hex+=chr(v);
    shift-=4;
}
return hex;


