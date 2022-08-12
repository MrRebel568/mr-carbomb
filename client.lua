local QBCore = exports[Config.Core]:GetCoreObject()
local timer = 0
local armedVeh

CreateThread(function()
    RequestModel("s_m_y_garbage")
      while not HasModelLoaded("s_m_y_garbage") do
      Wait(1)
    end
      MRboss = CreatePed(2, "s_m_y_garbage", 69.53, 3762.02, 38.74, 51.26, false, false) 
      SetPedFleeAttributes(MRboss, 0, 0)
      SetPedDiesWhenInjured(MRboss, false)
      TaskStartScenarioInPlace(MRboss, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
      SetPedKeepTask(MRboss, true)
      SetBlockingOfNonTemporaryEvents(MRboss, true)
      SetEntityInvincible(MRboss, true)
      FreezeEntityPosition(MRboss, true)
      
      MRboss = CreatePed(2, "s_m_y_garbage", 1744.86, 3808.01, 33.74, 353.04, false, false) 
      SetPedFleeAttributes(MRboss, 0, 0)
      SetPedDiesWhenInjured(MRboss, false)
      TaskStartScenarioInPlace(MRboss, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
      SetPedKeepTask(MRboss, true)
      SetBlockingOfNonTemporaryEvents(MRboss, true)
      SetEntityInvincible(MRboss, true)
      FreezeEntityPosition(MRboss, true)
end)

-- Event

RegisterNetEvent('mr-carbomb:client:MissionStart', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"wait"})
    QBCore.Functions.Progressbar('name_here', Config.Alerts['bomb_startpro'], 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent(Config.Phone, {
            sender = 'Boss',
            subject = Config.Alerts['bomb_sunject'],
            message = Config.Alerts['boss_message'],
        })
        SetNewWaypoint(Config.Waypoint)
    end)
end)

RegisterNetEvent('mr-carbomb:client:getbomb', function()
    TriggerServerEvent('mr-carbomb:client:buybomb')
end)

RegisterNetEvent('mr-carbomb:CheckVehicle', function()
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    local veh = QBCore.Functions.GetClosestVehicle(pCoords)
    local vCoords = GetEntityCoords(veh)
    local dist = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, vCoords.x, vCoords.y, vCoords.z, true)

    if not IsPedInAnyVehicle(ped, false) then
        if veh and (dist < 4.0) then
            local playerPed = PlayerPedId()
            local success = exports[Config.QBLock]:StartLockPickCircle(4,15)
            QBCore.Functions.Progressbar("name_here", Config.Alerts['bomb_plant'], Config.TimeToSet, false, true,{
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
                anim = "weed_spraybottle_crouch_base_inspector"
            }, {}, {}, function()
                ClearPedTasksImmediately(ped)
                for k,v in pairs(Config.Distance) do
                    if k == Config.DistanceType then
                        results = v
                        if Config.DistanceType == 1 then
                            QBCore.Functions.Notify(Config.Alerts['bomb_usenotify'], 'success')
                        end
                    end
                    break
                end
                armedVeh = veh
                TriggerServerEvent('mr-carbomb:RemoveBombFromInv')
            end, function()
                ClearPedTasks(ped)
            end)
        else
            QBCore.Functions.Notify(Config.Alerts['bomb_notvehicle'], "error")
        end
    else
        QBCore.Functions.Notify(Config.Alerts['bomb_invehicle'], "error")
    end
end)

RegisterNetEvent('mr-carbomb:defusedBomb', function()
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    local veh = QBCore.Functions.GetClosestVehicle(pCoords)
    local vCoords = GetEntityCoords(veh)
    local dist = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, vCoords.x, vCoords.y, vCoords.z, true)

    if dist < 2.0 and armedVeh then
        local playerPed = PlayerPedId()
        local success = exports[Config.QBLock]:StartLockPickCircle(6,15)
        QBCore.Functions.Progressbar("carbomb_disarm", Config.Alerts['bomb_disablepro'], Config.TimeToSet, false, true,{
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer"
        }, {}, {}, function()
            ClearPedTasksImmediately(ped)
            QBCore.Functions.Notify(Config.Alerts['bomb_disable'], 'success')
            armedVeh = nil
        end)
    end
end)

-- Threads

CreateThread(function()
    while true do
        if armedVeh then
            for k,v in pairs(Config.Distance) do
                if k == Config.DistanceType then
                    results = v
                    if Config.DistanceType == 1 and armedVeh then
                        if IsControlJustReleased(0, results.key) then
                            DetonateVehicle(armedVeh)
                        end
                    end
                end
            end
        end
        Wait(3)
    end
end)

CreateThread(function()
    exports[Config.QBTarget]:AddBoxZone("name-here", Config.Targer1Boss, 1, 1, {
        name="name-here",
        heading=0,
        debugpoly = false,
    }, {
        options = {
            {
                event = "mr-carbomb:client:Mission",
                icon = Config.Alerts['target_icon'],
                label = Config.Alerts['target_label'],
            },
        },
        distance = 1.5
    })
    exports[Config.QBTarget]:AddBoxZone("seller", Config.Targer2Boss, 0.8, 0.6, {
        name="seller",
        heading=90,
        minZ=31.7,
        maxZ=35.7,
        debugpoly = false,
    }, {
        options = {
            {
            event = "mr-carbomb:client:getbomb1",
            icon = Config.Alerts['target_buticon'],
            label = Config.Alerts['target_buylab'],
            },
        },
        distance = 1.5
    })
end)

-- Functions

function RunTimer(veh, time)
    timer = time
    while timer > 0 do
        timer = timer - 1
        Wait(1000)
        if timer == 0 then
            DetonateVehicle(veh)
            armedVeh = nil
        end
    end
end

function DetonateVehicle(veh)
    local vCoords = GetEntityCoords(veh)
    if DoesEntityExist(veh) then
        armedVeh = nil
        AddExplosion(vCoords.x, vCoords.y, vCoords.z, 5, 500.0, true, false, true)
    end
end

RegisterNetEvent('mr-carbomb:client:Mission', function()
    exports[Config.QBMenu]:openMenu({
        {
            header = Config.Alerts['bomb_menumiss'],
            txt = Config.Alerts['bomb_txt1'],
            isMenuHeader = true,
        },
        {
            header = Config.Alerts['bomb_header1'],
            txt = '',
            params = {
                event = "mr-carbomb:client:MissionStart",
            }
        },
        {
            header = Config.Alerts['bomb_cancel1'],
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)

RegisterNetEvent('mr-carbomb:client:getbomb1', function()
    exports[Config.QBMenu]:openMenu({
        {
            header = Config.Alerts['bomb_seller'],
            txt = Config.Alerts['seller_txt'],
            isMenuHeader = true,
        },
        {
            header = Config.Alerts['seller_header'],
            txt = '',
            params = {
                event = "mr-carbomb:client:getbomb",
            }
        },
        {
            header = Config.Alerts['Cancel_seller'],
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end)