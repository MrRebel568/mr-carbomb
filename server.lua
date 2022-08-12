local QBCore = exports[Config.Core]:GetCoreObject()

-- Event 

QBCore.Functions.CreateUseableItem(Config.Item, function(source)
    local src = source
    TriggerClientEvent("mr-carbomb:CheckVehicle", src)
end)

QBCore.Functions.CreateUseableItem(Config.defuseditem, function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    if Config.JobDefused then
        if Player.PlayerData.job.name == Config.PoliceJob then
            TriggerClientEvent('mr-carbomb:defusedBomb', source)
        else
            TriggerClientEvent('QBCore:Notify', source, Config.Alerts['bomb_defusednot'], 'error')
        end
    else
        TriggerClientEvent('mr-carbomb:defusedBomb', source)
    end
end)

RegisterNetEvent('mr-carbomb:client:buybomb', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local MRBombRebelPrice = Config.BombPrice
    Player.Functions.AddItem(Config.Item, 1)
    TriggerClientEvent(Config.InventoryTrigger, source, QBCore.Shared.Items[Config.Item], "add")
    Player.Functions.RemoveMoney(Config.Payment, MRBombRebelPrice)
end)

RegisterServerEvent('mr-carbomb:RemoveBombFromInv')
AddEventHandler('mr-carbomb:RemoveBombFromInv', function()
    local Player = QBCore.Functions.GetPlayer(source)
    local item = Player.Functions.GetItemByName(Config.Item)

    if item.amount > 0 then
        Player.Functions.RemoveItem(Config.Item, 1)
    end
end)
