//*****************************************************************************
// pcHandleDriving();
//
// Handle input and apply it to driving control.
//

// Get desired state
var state  = STATE_NONE;
var state2 = STATE_LOOSE;
var forwardVelocity = GetForwardVelocity();
if (keyboard_check(vk_up) || keyboard_check(ord("W")))
    {
    if (forwardVelocity < 0)
        {
        state = STATE_BRAKE;
        state2 = STATE_BRAKE;
        }
    else
        {
        state = STATE_UP;
        traction = 1.0;
        if ((forwardVelocity / maxMoveSpeed) != 0)
            traction = (0.5 / (forwardVelocity / maxMoveSpeed));
        wheelRL.modLateralImpulse = min(traction, wheelRR.modLateralImpulse);
        wheelRR.modLateralImpulse = min(traction, wheelRR.modLateralImpulse);
        }
    }
else if (keyboard_check(vk_down) || keyboard_check(ord("S")))
    {
    if (forwardVelocity > 0)
        {
        state = STATE_BRAKE;
        state2 = STATE_BRAKE;
        }
    else
        {
        state = STATE_DOWN;
        }
    }

if (keyboard_check(ord("Z")))
    {
    state2 = STATE_LOOSE;
    state = STATE_HANDBRAKE;
    wheelFL.modLateralImpulse = 0.75;
    wheelFR.modLateralImpulse = 0.75;
    wheelRL.modLateralImpulse = 0.75;
    wheelRR.modLateralImpulse = 0.75;
    }


// Apply state to wheels, depending on drive type
switch (driveType)
    {
    case (DRIVE_4WD):                   // Four wheel drive
        wheelRL.controlState = state;
        wheelRR.controlState = state;
        wheelFL.controlState = state;
        wheelFR.controlState = state;
        break;
    case (DRIVE_RWD):                   // Rear wheel drive
        wheelRL.controlState = state;
        wheelRR.controlState = state;
        wheelFL.controlState = state2;
        wheelFR.controlState = state2;
        break;
    case (DRIVE_FWD):                   // Front wheel drive
        wheelRL.controlState = state2;
        wheelRR.controlState = state2;
        wheelFL.controlState = state;
        wheelFR.controlState = state;
        break;
    }

