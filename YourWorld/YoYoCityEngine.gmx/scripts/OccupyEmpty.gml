/// OccupyEmpty(cellList);
//
//  cellList: A list of cells occupied by the calling instance.
//
//  Removes all cells occupied by this vehicle.
//
//*****************************************************************************

var findValue, sIndex;

repeat (ds_list_size(argument0))
    {
    // Delete from shared list
    findValue = ds_list_find_value(argument0, 0);
    sIndex = ds_list_find_index(objTrafficSpawner.occupiedCells, findValue);
    if (sIndex != -1)
        ds_list_delete(objTrafficSpawner.occupiedCells, sIndex);
    
    // Delete from given local list
    ds_list_delete(argument0, 0);
    }

