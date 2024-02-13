local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent('rz-delivery:server:sell', function()
    local src = source
    local price = Config.delivery_payment
    local xplayer = QBCore.Functions.GetPlayer(src)
    xplayer.Functions.AddMoney(Config.money_type, price)
    xplayer.Functions.RemoveItem(Config.delivery_item, 1)
end)

QBCore.Functions.CreateCallback('rz:delivery:server:GetItem', function(source, cb, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        local item = Player.Functions.GetItemByName(item)
        if item ~= nil and not Player.PlayerData.metadata["isdead"] and not Player.PlayerData.metadata["inlaststand"] then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

