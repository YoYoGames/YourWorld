{
// uvs  = argument0 
var uvs = argument0;


    var tu1 = uvs[0];
    var tu2 = uvs[1];
    var tu3 = uvs[6];
    var tu4 = uvs[7];

    uvs[0] = uvs[2];
    uvs[1] = uvs[3];
    uvs[6] = uvs[4];
    uvs[7] = uvs[5];
    uvs[2] = tu1;
    uvs[3] = tu2;
    uvs[4] = tu3;
    uvs[5] = tu4;
    
    return uvs;
}

