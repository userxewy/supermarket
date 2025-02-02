CreateThread(function()
    for _,v in pairs(SupermarketSettings.Positions) do    
        local SupermarketBlips = AddBlipForCoord(v.pos)
        SetBlipSprite(SupermarketBlips, 59)
        SetBlipDisplay(SupermarketBlips, 4)
        SetBlipScale(SupermarketBlips, 0.7)
        SetBlipColour(SupermarketBlips, 2)
        SetBlipAsShortRange(SupermarketBlips, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Supérette")
        EndTextCommandSetBlipName(SupermarketBlips)
    end
    while true do
        local pCoords = GetEntityCoords(PlayerPedId())
        local onMarker = false
        for _,v in pairs(SupermarketSettings.Positions) do
            if #(pCoords - v.pos) < 15.0 then
                onMarker = true
                DrawMarker(1, v.pos, 0, 0, 0, 0, 0, 0, 0.75, 0.75, 0.25, 244, 171, 53, 1.0, 0, 0, 0, 0)               
            end
            if #(pCoords - v.pos) < 1.2 then
                ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accéder à la supérette")
                if IsControlJustReleased(0, 38) then
                    OpenSupermarketMenu()
                end                
            end
        end
        if onMarker then
            Wait(1)
        else
            Wait(500)
        end
    end
end)