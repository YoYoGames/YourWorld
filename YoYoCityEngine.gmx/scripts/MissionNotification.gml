/// MissionNotification(text);
//
//*****************************************************************************

var newNotification;
newNotification = instance_create(0, 0, objMissionNotification);
newNotification.text = argument0;
debug("NOTIFICATION: "+argument0);

