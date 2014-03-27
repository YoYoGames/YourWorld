/// ObjectRestore();
//

respawnTimer--;
if (respawnTimer == 0)
    {
    // restore
    phy_position_x = xstart;
    phy_position_y = ystart;
    z = zstart;
    respawnTimer = -1;
    doEffect = false;
    }
    
