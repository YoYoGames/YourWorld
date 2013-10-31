// uvs  = argument0 
// flags = argument1;
var uvs = argument0;
var flags= argument1;



// 0=none, 1=90, 2=180, 3=270
var rot=(flags>>14)&3;
if(rot!=3){
    rot = 3-rot;
    for(var i=0;i<rot;i++){
        var tu1 = uvs[0];
        var tu2 = uvs[1];
    
        uvs[0] = uvs[2];
        uvs[1] = uvs[3];
        uvs[2] = uvs[4];
        uvs[3] = uvs[5];
        uvs[4] = uvs[6];
        uvs[5] = uvs[7];
        uvs[6] = tu1;
        uvs[7] = tu2;
    }
}
return uvs;



