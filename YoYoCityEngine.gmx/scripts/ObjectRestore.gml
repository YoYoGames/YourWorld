/// ObjectRestore();
//
//  Handle the respawn timer. When ready, "un-Hide()" this current instance,
//  putting it back in it's original position.
//
//*****************************************************************************

respawnTimer--;
if (respawnTimer == 0)
    {
    phy_position_x = xstart;
    phy_position_y = ystart;
    z = zstart;
    respawnTimer = -1;
    doEffect = false;
    }
    
