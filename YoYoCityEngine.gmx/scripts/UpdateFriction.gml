/// UpdateFriction();
//
//  Wheels, for example, use this to stop them moving sideways and return to "rolling" forward.
//
//*****************************************************************************

// Linear velocity handling, grip
// Wheel is being forced not to roll, so grip comes from all angles
var mult;
if (controlState == STATE_HANDBRAKE)
    {
    var linear;
    GetLinearSpeed();
    impulseX = -linearX;
    impulseY = -linearY;
    impulseLength = point_distance(0, 0, impulseX, impulseY);
    linear = maxLateralImpulse * modLateralImpulse * 0.25;
    mult = linear / impulseLength;
    impulseX *= mult;
    impulseY *= mult;
    physics_apply_impulse(x, y, impulseX*scale, impulseY*scale);
    }

    
// Lateral velocity handling, grip
// Wheel can still roll forward
else
    {
    GetLateralVelocity();
    impulseX = -lateralX;
    impulseY = -lateralY;
    impulseLength = point_distance(0, 0, impulseX, impulseY);
    var lateral = maxLateralImpulse * modLateralImpulse;
    if (impulseLength > lateral)
        {
        mult = lateral / impulseLength;
        impulseX *= mult;
        impulseY *= mult;
        }
    physics_apply_impulse(x, y, impulseX, impulseY);
    }


// Manage angular velocity
var torque;
torque = 0.1 * phy_inertia * -phy_angular_velocity;
physics_apply_torque(torque);


// Apply drag force, UNUSED CURRENTLY
fowardDirection = point_direction(0, 0, forwardX, forwardY);
currentX = lengthdir_x(1, forwardDirection);
currentY = lengthdir_y(1, forwardDirection);
currentForwardSpeed = point_distance(0, 0, currentX, currentY);
dragForceMagnitude = (-dragForce * modDragForce) * currentForwardSpeed;
forwardX *= dragForceMagnitude;
forwardY *= dragForceMagnitude;
physics_apply_force(x, y, forwardX, forwardY);
