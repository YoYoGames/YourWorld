/// Flip_tile_UD(uvs)
{
// uvs  = argument0 
var uvs = argument0;

//uvs[0]=0;
//uvs[2]=0;
//return uvs;




    var tu1 = uvs[0];
    var tu2 = uvs[1];
    var tu3 = uvs[2];
    var tu4 = uvs[3];

    uvs[0] = uvs[6];
    uvs[1] = uvs[7];
    uvs[2] = uvs[4];
    uvs[3] = uvs[5];
    uvs[6] = tu1;
    uvs[7] = tu2;
    uvs[4] = tu3;
    uvs[5] = tu4;
    
    return uvs;
}

