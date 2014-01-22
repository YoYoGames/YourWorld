/// OccupyEmpty(cellList);
//
//*****************************************************************************

var cellList, findValue, sIndex;

cellList = argument0;

repeat (ds_list_size(cellList))
    {
    // Delete from shared list
    findValue = ds_list_find_value(cellList, 0);
    sIndex = ds_list_find_index(objTrafficSpawner.occupiedCells, findValue);
    if (sIndex != -1)
        ds_list_delete(objTrafficSpawner.occupiedCells, sIndex);
    
    // Delete from given local list
    ds_list_delete(cellList, 0);
    }

