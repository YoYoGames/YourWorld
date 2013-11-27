//*****************************************************************************
// pcHandleSteering();
//
// Handle input and apply it to steering control.
//

var forwardVelocity = abs(GetForwardVelocity());
var fraction = forwardVelocity / maxMoveSpeed;
var steerSensitivity = 1 - (steerLow - steerHigh) * fraction;
var angleSensitivity = lerp(maxSteerAngle, minSteerAngle, fraction);


// Steer left
if (keyboard_check(vk_left) || keyboard_check(ord("A")))
    steeringAngle += (5 * steerSensitivity);
    
// Steer right
else if (keyboard_check(vk_right) || keyboard_check(ord("D")))
    steeringAngle -= (5 * steerSensitivity);
    
// Auto-straighten steering
else
    steeringAngle -= min(abs(steeringAngle), 5 * steerSensitivity) * sign(steeringAngle);
    

// Limit the steering angle
steeringAngle = median(-angleSensitivity, angleSensitivity, steeringAngle);


// Calculate ackerman steering, kinda pretend but effective
var left  = steeringAngle;
var right = steeringAngle;
if (steeringAngle > 0)
    left = steeringAngle / ackerman;
else if (steeringAngle < 0)
    right = steeringAngle / ackerman;
    
// Add toe angle
left  += toe;
right -= toe;

// Apply angle to the steering wheels
physics_joint_set_value(jointFL, phy_joint_upper_angle_limit, left);
physics_joint_set_value(jointFL, phy_joint_lower_angle_limit, left);
physics_joint_set_value(jointFR, phy_joint_upper_angle_limit, right);
physics_joint_set_value(jointFR, phy_joint_lower_angle_limit, right);

