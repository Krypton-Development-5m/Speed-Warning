local warningDisplayed = false

-- Function to show the warning message using codem-notification
function showWarning()
    TriggerEvent('codem-notification', 'Please drive at realistic speeds or you are at risk from receiving staff punishment.', 5000, "info")
end

-- Constantly check the player's speed
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500) -- Check every half second

        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        -- Check if player is in a vehicle
        if vehicle ~= 0 then
            -- Get the current speed of the vehicle in MPH
            local speed = GetEntitySpeed(vehicle) * 2.23694  -- Convert m/s to MPH

            -- If speed is greater than 190 MPH and the warning isn't already displayed
            if speed > 190 and not warningDisplayed then
                warningDisplayed = true
                showWarning()
            elseif speed <= 190 and warningDisplayed then
                warningDisplayed = false
            end
        end
    end
end)
