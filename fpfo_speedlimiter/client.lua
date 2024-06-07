local function setVehicleSpeedLimit(vehicle, speed, useMph)
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        local speedInMs = useMph and speed * 0.44704 or speed / 3.6 
        SetEntityMaxSpeed(vehicle, speedInMs)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Check every second

        local playerPed = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if vehicle and (GetPedInVehicleSeat(vehicle, -1) == playerPed) then
            if config.globallimiter then
                setVehicleSpeedLimit(vehicle, config.speedlimit, config.usemph)
            elseif config.modellimiter then
                local model = GetEntityModel(vehicle)
                for _, modelName in ipairs(config.models) do
                    if model == GetHashKey(modelName) then
                        setVehicleSpeedLimit(vehicle, config.speedlimit, config.usemph)
                        break
                    end
                end
            end
        end
    end
end)
