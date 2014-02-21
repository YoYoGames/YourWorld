/// mouse_rectangle(x1, y1, x2, y2);
//
//  Returns true if the mouse is within the given rectangle.
//  NOTE: x1 and y1 MUST be the top left.
//
//*****************************************************************************

return(    device_mouse_raw_x(0) >= argument0
        && device_mouse_raw_y(0) >= argument1
        && device_mouse_raw_x(0) <= argument2
        && device_mouse_raw_y(0) <= argument3 );

