//*****************************************************************************
// pcModelJointWheels();

// Front tyres
wheelFL = pcCreateWheel(x-frontWheelsX, y-frontWheelsY, scale);//instance_create(x-frontWheelsX, y-frontWheelsY, objWheel);
wheelFR = pcCreateWheel(x+frontWheelsX, y-frontWheelsY, scale);//instance_create(x+frontWheelsX, y-frontWheelsY, objWheel);
jointFL = physics_joint_revolute_create(id, wheelFL, wheelFL.x, wheelFL.y, 0, 0, true, 0, 0, false, false);
jointFR = physics_joint_revolute_create(id, wheelFR, wheelFR.x, wheelFR.y, 0, 0, true, 0, 0, false, false);

// Rear tyres
wheelRL = pcCreateWheel(x-rearWheelsX, y-rearWheelsY, scale);//instance_create(x-rearWheelsX, y-rearWheelsY, objWheel);
wheelRR = pcCreateWheel(x+rearWheelsX, y-rearWheelsY, scale);//instance_create(x+rearWheelsX, y-rearWheelsY, objWheel);
physics_joint_revolute_create(id, wheelRL, wheelRL.x, wheelRL.y, 0, 0, true, 0, 0, false, false);
physics_joint_revolute_create(id, wheelRR, wheelRR.x, wheelRR.y, 0, 0, true, 0, 0, false, false);

