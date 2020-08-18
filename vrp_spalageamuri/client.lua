----------- CREDIT SCRIPT -----------
---------- DICLOPARTZ#1028 ----------
-------------------------------------

local holograma = {
    {117.59071350098,6451.5473632813,31.763572692871}
}

local animatiecoord = {
    {117.59071350098,6451.5473632813,31.763572692871}
}

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local jucator = PlayerPedId(-1)
        local coordjuc = GetEntityCoords(jucator)
        for k,v in pairs(holograma) do
            local Distanta = GetDistanceBetweenCoords(coordjuc.x, coordjuc.y, coordjuc.z, v[1], v[2], v[3], true) -- DEFINIM DISTANTA DINTRE JUCATOR SI COORDONATELE SELECTATE
                if Distanta < 20 then -- DACA DISTANTA E MAI MICA DE 20 METRI VEI VEDEA TEXTUL SPALA GEAMURI
                    Draw3DText(v[1], v[2], v[3] + 1, "~b~Spala Geamuri", 1.0)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local coordsjuc = GetEntityCoords(GetPlayerPed(-1))
        if(Vdist(GetEntityCoords(GetPlayerPed(-1)),117.76728057861,6451.8120117188,31.763568878174) <= 2.0) then -- IA DISTANTA DINTRE COORDONATELE SELECTATE SI POZITIA JUCATORULUI, SI DACA TE AFLI LA O DISTANTA MAI MICA DE 2 METRI, APARE TEXTUL PE CARACTER APASA E PENTRU A SPALA GEAMURI
            Draw3DText(coordsjuc.x,coordsjuc.y,coordsjuc.z +0.2,"~w~[ ~b~APASA ~w~E ~b~PENTRU A SPALA GEAMURI ~w~]",0.4) 
        end
    end
end)

cooldownGeamuriTime = 60        -- time for cooldown in seconds

cooldownGeamuri = false     -- don't modify
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local jucator = PlayerPedId()
        local coordjuc = GetEntityCoords(jucator)
        for k,v in pairs(animatiecoord) do
            local Distanta = GetDistanceBetweenCoords(coordjuc.x, coordjuc.y, coordjuc.z, v[1], v[2], v[3], true)
            if Distanta < 0.5 then
                if IsControlJustPressed(1, 38) and cooldownGeamuri == false then
                    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BUM_WASH", 0, true)
                    Wait(10000)
                    TriggerServerEvent("DICLO:SPALAGEAMURI")
                    ClearPedTasks(PlayerPedId())
                    TriggerEvent('cooldown:geamuri')
                elseif IsControlJustPressed(1, 38) and cooldownGeamuri == true then
                    TriggerEvent('chatMessage', '', {0, 0, 255}, "Trebuie sa mai astepti "..timeRemaining.." secunde.")
                end
            end
        end
    end
end)

RegisterNetEvent('cooldown:geamuri')
AddEventHandler('cooldown:geamuri', function()
    cooldownGeamuri = true
    timeRemaining = cooldownGeamuriTime
    local temp = cooldownGeamuriTime
    for i = 1, temp do
        Citizen.Wait(1000)
        timeRemaining = timeRemaining - 1
    end
    cooldownGeamuri = false
end)

----------- NU ATINGE CA DACA STRIGI SI NU STII SA REPARI AI BELIT PULA VERE -----------


function Draw3DText(x,y,z, text,scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(1.0*scale, 1.0*scale)
        SetTextFont(7)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(""..text)
        DrawText(_x,_y)
    end
end