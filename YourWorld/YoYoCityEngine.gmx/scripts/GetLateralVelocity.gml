//*****************************************************************************
// GetLateralVelocity()
//
// Gets the speed the object is moving sideways.
//

var normalDirection = GetWorldDirection(0);
var normalX = lengthdir_x(1, normalDirection);
var normalY = lengthdir_y(1, normalDirection);

var dot = dot_product(normalX, normalY, phy_speed_x, phy_speed_y);
lateralX = normalX * dot;
lateralY = normalY * dot;

// Returns lateralX and lateralY

