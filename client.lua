local SafezoneIn = false
local SafezoneOut = false
local closestZone = 1
local allowedToUse = false
local bypass = false

Citizen.CreateThread(function()
	TriggerServerEvent("SafeZones:isAllowed")
end)

RegisterNetEvent("SafeZones.returnIsAllowed")
AddEventHandler("SafeZones.returnIsAllowed", function(isAllowed)
    allowedToUse = isAllowed
end)

RegisterCommand("sbypass", function(source, args, rawCommand)
	if allowedToUse then
	if not bypass then
	bypass = true
	ShowInfo("~g~SafeZone Bypass Enabled!")
	elseif bypass then
	bypass = false
	ShowInfo("~r~SafeZone Bypass Disabled!")
	end
else
	ShowInfo("~r~Insufficient Permissions.")
end
end)

Citizen.CreateThread(function()
	for i = 1, #Config.zones, 1 do
	local blip = AddBlipForRadius(Config.zones[i].x, Config.zones[i].y, Config.zones[i].z, Config.radius)
	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 11)
	SetBlipAlpha (blip, 128)
    local blip1 = AddBlipForCoord(x, y, z)
	SetBlipSprite (blip1, sprite)
	SetBlipDisplay(blip1, true)
	SetBlipScale  (blip1, 0.9)
	SetBlipColour (blip1, 11)
    SetBlipAsShortRange(blip1, true)
	end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		Citizen.Wait(1)
		for i = 1, #Config.zones, 1 do
			dist = Vdist(Config.zones[i].x, Config.zones[i].y, Config.zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local player = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(Config.zones[closestZone].x, Config.zones[closestZone].y, Config.zones[closestZone].z, x, y, z)
		local vehicle = GetVehiclePedIsIn(player, false)
		local speed = GetEntitySpeed(vehicle)


		if dist <= Config.radius then
			if not SafezoneIn then
				NetworkSetFriendlyFireOption(false)
				SetEntityCanBeDamaged(vehicle, false)
				ClearPlayerWantedLevel(PlayerId())
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
				if Config.showNotification then
				exports['mythic_notify']:PersistentAlert('start', 'safezoneAlert', Config.notificationstyle, Config.safezoneMessage)
				end
				SafezoneIn = true
				SafezoneOut = false
			end
		else
			if not SafezoneOut then
				NetworkSetFriendlyFireOption(true)
				if Config.showNotification then
				exports['mythic_notify']:PersistentAlert('end', 'safezoneAlert')
				end
				if Config.speedlimitinSafezone then
				SetVehicleMaxSpeed(vehicle, 1000.00)
				end
				SetEntityCanBeDamaged(vehicle, true)
				SafezoneOut = true
				SafezoneIn = false
			end
			Citizen.Wait(200)
		end
		if SafezoneIn then
		Citizen.Wait(10)
    if not bypass then
		DisablePlayerFiring(player, true)
		SetPlayerCanDoDriveBy(player, false)
		DisableControlAction(2, 37, true)
      	DisableControlAction(0, 106, true)
		DisableControlAction(0, 24, true)
		DisableControlAction(0, 69, true)
		DisableControlAction(0, 70, true)
		DisableControlAction(0, 92, true)
		DisableControlAction(0, 114, true)
		DisableControlAction(0, 257, true)
		DisableControlAction(0, 331, true)
		DisableControlAction(0, 68, true)
		DisableControlAction(0, 257, true)
		DisableControlAction(0, 263, true)
		DisableControlAction(0, 264, true)

		if Config.speedlimitinSafezone then
		mphs = 2.237
		maxspeed = Config.speedlimitinSafezone/mphs
		SetVehicleMaxSpeed(vehicle, maxspeed)
		end

			if IsDisabledControlJustPressed(2, 37) then
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
			end
			if IsDisabledControlJustPressed(0, 106) then 
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
			end
	end
end
end
end)


function ShowInfo(text)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandThefeedPostTicker(true, false)
end
