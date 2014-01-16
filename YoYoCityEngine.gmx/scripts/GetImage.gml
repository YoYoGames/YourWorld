/// GetImage(sprite_type)
/// Give a sprite type, return the image
switch( argument0 )
{
    case 0 : return -1;
    //Landscape
    case 1 : return sTree;
    case 2 : return sBush1;
    case 3 : return sBush2;
    case 4 : return sBush3;
    case 5 : return sBush4;
    case 6 : return sBushBare;
    case 7 : return sShrubPot;
    //Pavement
    case 8 : return sLitter1;
    case 9 : return sLitter2;
    case 10: return sLitter3;
    case 11: return sLitter4;
    case 12: return sPavementDrain;
    case 13: return sPavementVent;
    case 14: return sPuddle1;
    case 15: return sBrokenGlass;
    case 16: return sCracks1;
    case 17: return sCracks2;
    case 18: return sCracks3;
    //Road
    case 19: return sMarksBusStop;
    case 20: return sMarksCrossing;
    case 21: return sMarksGetInLane;
    case 22: return sMarksSlow;
    case 23: return sMarksStop;
    case 24: return sMarksTurn;
    case 25: return sMarksTyre1;
    case 26: return sMarksTyre2;
    case 27: return sMarksTyre3;
    case 28: return sMarksTyre4;
    case 29: return sDrain;
    case 30: return sSpiltOil1;
    case 31: return sSpiltOil2;
    case 32: return sPothole1;
    case 33: return sPothole2;
    //Buildings
    case 34: return sPhoneLineConnecter;
    case 35: return sRoofAirConCorner;
    case 36: return sRoofAirConH;
    case 37: return sRoofAirConV;
    case 38: return sEdgeDirtCorner;
    case 39: return sEdgeDirtStraight;
    case 40: return sPipeCorner;
    case 41: return sPipeV;
    case 42: return sPipeH;
    case 43: return sIndPipe1;
    case 44: return sIndPipe2;
    case 45: return sIndPipe3;
    case 46: return sIndPipe4;
    default:
        return sTree;
}


