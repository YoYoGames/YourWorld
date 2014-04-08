/// CreateObjectsFromList(list);
//
//  Create Objects from a list previously created during LoadMap().
//  We delete this list here, but that can be changed if needed.
//
//*****************************************************************************

var numberOfObjects;
numberOfObjects = ds_list_size(argument0);

var n, xPos, yPos, zPos, type, rotation, newObject;
for (n=0; n<numberOfObjects; n+=5)
    {
    // Get all the data from the list
    xPos     = ds_list_find_value(argument0, n+0);
    yPos     = ds_list_find_value(argument0, n+1);
    type     = ds_list_find_value(argument0, n+2);
    zPos     = ds_list_find_value(argument0, n+3);
    rotation = ds_list_find_value(argument0, n+4);
    
    // Create a new object and give it all that data
    newObject = instance_create(xPos, yPos, type);
    with (newObject)
        {
        z = zPos;
        zstart = z;
        phy_rotation = rotation;
        }
    }


// Free the list
ds_list_destroy(argument0);
