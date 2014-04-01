/// ObjectGetObjectIndex(objectIndex)
//  Give a sprite type, return the image

switch (argument0)
    {
    // Movables
    case (objCrate): return 1;
    case (objCone): return 2;
    case (objBin): return 3;
    
    // Static
    // ......
    
    default:
        return -1;
    }

