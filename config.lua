Config = {}


-- Coords for all safezones
Config.zones = {
	{ ['x'] = 1847.916015625, ['y'] = 3675.8190917968, ['z'] = 33.767009735108}, -- Sandy Shores PD
	{ ['x'] = -1688.43811035156, ['y'] = -1073.62536621094, ['z'] = 13.1521873474121},
	{ ['x'] = -2195.1352539063, ['y'] = 4288.7290039063, ['z'] = 49.173923492432}
}


Config.safezoneMessage = "You are currently in a Safezone" -- Change the message that shows when you are in a safezone
Config.radius = 50.0 -- Change the RADIUS of the Safe Zone. Remember, whatever you put here will DOUBLE
Config.speedlimitinSafezone = 30.0 -- Set a speed limit in a Safezone

-- Change the color of the notification
Config.notificationstyle = "success"
--Notification Styles
-- inform
-- error
-- success