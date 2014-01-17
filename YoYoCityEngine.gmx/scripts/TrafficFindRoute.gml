
var routePoints, block, info, flags, hasRoad;


// Get my current cell
myCellX = floor(DesiredX/64);
myCellY = ceil(DesiredY/64);
myCellZ = 4;
myCellIndex = GetBlockIndex(myCellX, -myCellY, myCellZ);
hasRoad = GetHasRoad(myCellX, myCellY, myCellZ);


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
    
else if (routePoints < 10)
    {
    // Get infomation about last cell, and calculate new cell
    var start = ds_list_size(routeCoordinates)-3;
    var lastDirection = ds_list_find_value(routeCoordinates, start+2);
    newCellX = ds_list_find_value(routeCoordinates, start+0) + lengthdir_x(1, lastDirection);
    newCellY = ds_list_find_value(routeCoordinates, start+1) + lengthdir_y(1, lastDirection);
    newCellZ = myCellZ;
    
    // There was no decision to make as there was only 1 choice
    if (GetDirectionOptions(newCellX, newCellY, newCellZ) == 1)
        madeDecision = false;
    
    // Add new cell to list
    var newDirection = lastDirection;
    if (madeDecision == false)
        newDirection = GetRandomDirection(newCellX, newCellY, newCellZ, DesiredDirection);
    ds_list_add(routeCoordinates, newCellX);
    ds_list_add(routeCoordinates, newCellY);
    ds_list_add(routeCoordinates, newDirection);
    
    // We made a decision and changed direction
    if (lastDirection != newDirection)
        madeDecision = true;
    }


//Animate = false;
if (hasRoad)
    {
    // TEST. Check for collision
    var inst = instance_nearest(newCellX*64+32, newCellY*64-32, objTrafficCar);
    if (point_distance(x, y, inst.x, inst.y) < 96)
    && (inst != id)
        {
        //Animate = false;
        }
    else
        {
        DesiredX         = ds_list_find_value(routeCoordinates, 0)*64+32;
        DesiredY         = ds_list_find_value(routeCoordinates, 1)*64-32;
        DesiredDirection = ds_list_find_value(routeCoordinates, 2);
        }
    }
else
    {
    parked = true;
    }

