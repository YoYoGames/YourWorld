/// pcApplySettingsToWheels();
//
//  This is a weird one, it tries to emulate different drive types via individual tyre settings.
//
//*****************************************************************************

wheelFL.maxDriveForce = maxDriveForce;
wheelFR.maxDriveForce = maxDriveForce;
wheelRL.maxDriveForce = maxDriveForce;
wheelRR.maxDriveForce = maxDriveForce;

wheelFL.maxMoveSpeed   = maxMoveSpeed;
wheelFR.maxMoveSpeed   = maxMoveSpeed;
wheelRL.maxMoveSpeed   = maxMoveSpeed;
wheelRR.maxMoveSpeed   = maxMoveSpeed;

wheelFL.maxLateralImpulse = frontGrip;
wheelFR.maxLateralImpulse = frontGrip;
wheelRL.maxLateralImpulse = rearGrip;
wheelRR.maxLateralImpulse = rearGrip;

wheelFL.brakingPower = frontBrakes;
wheelFR.brakingPower = frontBrakes;
wheelRL.brakingPower = rearBrakes;
wheelRR.brakingPower = rearBrakes;

