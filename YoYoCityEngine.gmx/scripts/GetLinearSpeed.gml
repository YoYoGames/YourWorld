/// GetLinearSpeed();
//
//  Returns the speed the physics object is currently moving.
//
//*****************************************************************************

var dir = point_direction(0, 0, phy_speed_x, phy_speed_y);
linearX = lengthdir_x(1, dir);
linearY = lengthdir_y(1, dir);
return (point_distance(0, 0, phy_speed_x, phy_speed_y));

