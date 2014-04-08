/// TrafficFindRoute();
//
//  Builds a list of coordinates along the road for the car to follow.
//
//*****************************************************************************

var newCellX, newCellY, newCellZ, routePoints, start, lastDirection, newDirection;


// Get my current cell
var myCellX, myCellY, myCellZ, hasRoad;
myCellX = floor(DesiredX/64);
myCellY = ceil(DesiredY/64);
myCellZ = 4;
hasRoad = GetHasRoad(myCellX, myCellY, myCellZ);


//-----------------------------------------------------------------------------
// List is empty, add NEXT cell from current cell to list
routePoints = ds_list_size(routeCoordinates) div 3;
if (!routePoints)
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
    
// List isn't empty, but isn't complete
else if (routePoints < 10)
    {
    // Get infomation about last cell, and calculate new cell
    start = ds_list_size(routeCoordinates)-3;
    lastDirection = ds_list_find_value(routeCoordinates, start+2);
    newCellX = ds_list_find_value(routeCoordinates, start+0) + lengthdir_x(1, lastDirection);
    newCellY = ds_list_find_value(routeCoordinates, start+1) + lengthdir_y(1, lastDirection);
    newCellZ = myCellZ;
    
    // There was no decision to make as there was only 1 choice
    if (GetDirectionOptions(newCellX, newCellY, newCellZ) == 1)
        madeDecision = false;
    
    // Add new cell to list
    if (!madeDecision)
        newDirection = GetRandomDirection(newCellX, newCellY, newCellZ, DesiredDirection);
    else
        newDirection = lastDirection;
    ds_list_add(routeCoordinates, newCellX);
    ds_list_add(routeCoordinates, newCellY);
    ds_list_add(routeCoordinates, newDirection);
    
    // We made a decision and changed direction
    if (lastDirection != newDirection)
        madeDecision = true;
    }
    

// If we are on the road, allow movement to the next point
if (hasRoad)
    {
    DesiredX         = ds_list_find_value(routeCoordinates, 0)*64+32;
    DesiredY         = ds_list_find_value(routeCoordinates, 1)*64-32;
    DesiredDirection = ds_list_find_value(routeCoordinates, 2);
    }

// There's no road here, assume we're parked
else parked = true;
