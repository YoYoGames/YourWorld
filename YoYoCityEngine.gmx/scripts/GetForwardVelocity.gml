/// GetForwardVelocity();
// 
//  Returns the magnitude of speed along the forward vector
//  as well as saving the forwardX and forwardY variables (these are the vector)
//
//*****************************************************************************

var normalDirection = GetWorldDirection(90);
var normalX = lengthdir_x(1, normalDirection);
var normalY = lengthdir_y(1, normalDirection);

var dot = dot_product(normalX, normalY, phy_speed_x, phy_speed_y);
forwardX = normalX * dot;
forwardY = normalY * dot;

var forwardDistance = point_distance(0, 0, forwardX, forwardY);
var relativeDistanceA = point_distance(normalX, normalY, forwardX, forwardY);
var relativeDistanceB = point_distance(-normalX, -normalY, forwardX, forwardY);

if (relativeDistanceB < relativeDistanceA)      // Are we moving backwards to the vector?
    {
    forwardDistance *= -1;      // flip the distance to negative, moving backwards
    }

return forwardDistance;
// Also returns forwardX and forwardY for use *elsewhere*

