/// OccupyFree(cellList, index);
//
//*****************************************************************************

var cellList, index;
cellList = argument0;
index = argument1;

// Delete from shared list
var findValue, sIndex;
findValue = ds_list_find_value(cellList, index);
sIndex = ds_list_find_index(objTrafficSpawner.occupiedCells, findValue);
if (sIndex != -1)
    ds_list_delete(objTrafficSpawner.occupiedCells, sIndex);

// Delete from given local list
ds_list_delete(cellList, index);
