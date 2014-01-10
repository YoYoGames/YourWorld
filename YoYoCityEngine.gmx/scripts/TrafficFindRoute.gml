
var routePoints, block, info, flags, hasRoad;


// Get my current cell
myCellX = floor(DesiredX/64);
myCellY = ceil(DesiredY/64);
myCellZ = 4;
myCellIndex = GetBlockIndex(myCellX, -myCellY, myCellZ);
hasRoad = GetHasRoad(myCellX, myCellY, myCellZ);


// Add new coordiantes to route list
// X, Y, DIRECTION
/*TEST BREAKAGE*/ds_list_clear(routeCoordinates);

routePoints = ds_list_size(routeCoordinates) div 3;

// List is empty, add NEXT from current cell to list
if (routePoints == 0)
    {
    // Get infomation about current cell, and calculate new cell
    newCellX = myCellX + lengthdir_x(1, DesiredDirection);
    newCellY = myCellY + lengthdir_y(1, DesiredDirection);
    newCellZ = myCellZ;
    
    // Add new cell to list
    ds_list_add(routeCoordinates, newCellX);
    ds_list_add(routeCoordinates, newCellY);
    ds_list_add(routeCoordinates, GetRandomDirection(newCellX, newCellY, newCellZ, DesiredDirection));
    }


//Animate = false;
if (hasRoad)
    {
    DesiredX         = ds_list_find_value(routeCoordinates, 0)*64+32;
    DesiredY         = ds_list_find_value(routeCoordinates, 1)*64-32;
    DesiredDirection = ds_list_find_value(routeCoordinates, 2);
    }
else
    {
    parked = true;
    }
    
