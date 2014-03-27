/// OccupyFree(cellList, index);
//
//*****************************************************************************

var cellList, xx, yy, cellID, index, sIndex;

cellList = argument0;
index = argument1;

//show_debug_message('GET: '+string(ds_list_find_value(cellList, index)));

// Delete from shared list
findValue = ds_list_find_value(cellList, index);
sIndex = ds_list_find_index(objTrafficSpawner.occupiedCells, findValue);
if (sIndex != -1)
    ds_list_delete(objTrafficSpawner.occupiedCells, sIndex);

// Delete from given local list
ds_list_delete(cellList, index);

