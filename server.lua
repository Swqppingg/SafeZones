RegisterServerEvent("SafeZones:isAllowed")
AddEventHandler("SafeZones:isAllowed", function()
    if IsPlayerAceAllowed(source, "safezones.bypass") then
        TriggerClientEvent("SafeZones.returnIsAllowed", source, true)
    else
        TriggerClientEvent("SafeZones.returnIsAllowed", source, false)
    end
end)




versionChecker = true -- Set to false to disable version checker



-- Don't touch
resourcename = "SafeZones"
version = "1.0.4"
rawVersionLink = "https://raw.githubusercontent.com/Swqppingg/SafeZones/main/version.txt"


-- Check for version updates.
if versionChecker then
PerformHttpRequest(rawVersionLink, function(errorCode, result, headers)
    if (string.find(tostring(result), version) == nil) then
        print("\n\r[".. GetCurrentResourceName() .."] ^1WARNING: Your version of ".. resourcename .." is not up to date. Please make sure to update whenever possible.\n\r")
    else
        print("\n\r[".. GetCurrentResourceName() .."] ^2You are running the latest version of ".. resourcename ..".\n\r")
    end
end, "GET", "", "")
end