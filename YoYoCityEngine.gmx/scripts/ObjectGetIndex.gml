/// ObjectGetIndex(type);
//
//  Give an object type, return the object.
//
//*****************************************************************************

switch (argument0)
    {
    case (0): return -1; break;
    
    // Movables
    case (1): return objCrate; break;
    case (2): return objCone; break;
    case (3): return objBin; break;
    
    // Static
    // ......
    
    default:
        return objCrate; break;
    }

