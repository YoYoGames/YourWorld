/// OccupyCells(cellList, routeList, reserveSpaces);
//
//*****************************************************************************

var cellList, routeList, reserveSpaces;
cellList = argument0;
routeList = argument1;
reserveSpaces = argument2;

// Generate cell IDs and add them to occupied cells list
var index, xx, yy, cellID;
for (index=0; index<reserveSpaces; index++)
    {
    // Get unique cell id
    xx = ds_list_find_value(routeList, index*3+0);
    yy = ds_list_find_value(routeList, index*3+1);
    cellID = (yy * oMap.MapHeight) + xx;
    
    // If this cell has not been taken at all
    if (ds_list_find_index(objTrafficSpawner.occupiedCells, cellID) == -1)
        {
        ds_list_add(cellList, cellID);
        ds_list_add(objTrafficSpawner.occupiedCells, cellID);
        }
        
    // If this cell has not been taken by the calling instance
    else if (ds_list_find_index(cellList, cellID) == -1)
        exit;
    }
