/// ObjectGetIndex(object_type)
/// Give a sprite type, return the image
switch( argument0 )
{
    case (0): return -1;
    
    // Movables
    case (1): return objCrate;
    case (2): return objCone;
    case (3): return objBin;
    
    // Static
    
    default:
        return objCrate;
}


