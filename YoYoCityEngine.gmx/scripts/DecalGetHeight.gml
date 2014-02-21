/// DecalGetHeight(id);
//
//  The height the given decal should be from the ground.
//
//*****************************************************************************

switch( argument0 )
{
    case 0 : return -1;
    //Landscape
    case 1 : return 16;
    case 2 : return 8;
    case 3 : return 8;
    case 4 : return 8;
    case 5 : return 8;
    case 6 : return 1;
    case 7 : return 1;
    //Pavement
    case 8 : return 1;
    case 9 : return 1;
    case 10: return 1;
    case 11: return 1;
    case 12: return 1;
    case 13: return 1;
    case 14: return 1;
    case 15: return 1;
    case 16: return 1;
    case 17: return 1;
    case 18: return 1;
    //Road
    case 19: return 1;
    case 20: return 1;
    case 21: return 1;
    case 22: return 1;
    case 23: return 1;
    case 24: return 1;
    case 25: return 1;
    case 26: return 1;
    case 27: return 1;
    case 28: return 1;
    case 29: return 1;
    case 30: return 1;
    case 31: return 1;
    case 32: return 1;
    case 33: return 1;
    //Buildings
    case 34: return 8;
    case 35: return 8;
    case 36: return 8;
    case 37: return 8;
    case 38: return 8;
    case 39: return 8;
    case 40: return 8;
    case 41: return 8;
    case 42: return 8;
    case 43: return 8;
    case 44: return 8;
    case 45: return 8;
    case 46: return 8;
    default:
        return 1;
}


