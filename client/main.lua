local QBCore = exports['qb-core']:GetCoreObject()
local delivery = false

RegisterNetEvent('rz-delivery:client:sell', function()
    QBCore.Functions.TriggerCallback('rz:delivery:server:GetItem', function(hasItem)
        if hasItem then 
            exports['qb-target']:RemoveZone("sell")
            QBCore.Functions.Progressbar('selling', Config.lang.selling, Config.selling_time, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'timetable@jimmy@doorknock@',
                anim = 'knockdoor_idle',
                flags = 49
            }, {}, {}, function()
                TriggerServerEvent('rz-delivery:server:sell')
                RemoveBlip(delivery_blip)
                Delivery()
            end)
        else
            QBCore.Functions.Notify(Config.lang.no_item, 'error', 5000)
        end
    end, Config.delivery_item)
end)

function Delivery()
    QBCore.Functions.Notify(Config.lang.new_customer, "primary", 5000)
    Wait(Config.delivery_cd)
    random = math.random(1,#Config.coords)
    exports['qb-target']:AddCircleZone('sell', vector3(Config.coords[random]["x"],Config.coords[random]["y"],Config.coords[random]["z"]), 2.0,{ 
        name = 'sell', debugPoly = false, useZ=true}, {
        options = {{label = Config.lang.sell_label ,icon = 'fa-solid fa-hand-holding', action = function() TriggerEvent('rz-delivery:client:sell') end}},
        distance = 2.0
    })
    SetNewWaypoint(Config.coords[random]["x"],Config.coords[random]["y"])
    delivery_blip = AddBlipForCoord(Config.coords[random]["x"],Config.coords[random]["y"],Config.coords[random]["z"])
    SetBlipSprite(delivery_blip, Config.blip_settings.customer_blip.BlipSprite)
    SetBlipColour(delivery_blip, Config.blip_settings.customer_blip.BlipColour)
    SetBlipScale(delivery_blip, Config.blip_settings.customer_blip.BlipScale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.blip_settings.customer_blip.BlipName)
    EndTextCommandSetBlipName(delivery_blip)
end

RegisterNetEvent('rz-delivery:menu', function(data)
    if delivery == false then
        exports['qb-menu']:openMenu({
            {
                header = Config.lang.delivery_label,
                isMenuHeader = true
            },
            { 
                header = Config.lang.start_selling, 
                params = {
                    event = "rz-delivery:client:delivery-start",
                }
            },
        })
    elseif delivery == true then
        exports['qb-menu']:openMenu({
            {
                header =  Config.lang.delivery_label,
                isMenuHeader = true
            },
            { 
                header = Config.lang.stop_selling,
                params = {
                    event = "rz-delivery:client:delivery-stop",
                }
            },
        })
    end
end)

RegisterNetEvent('rz-delivery:client:delivery-start', function() -- small
    QBCore.Functions.Progressbar('serach_customer', Config.lang.search_customer, Config.selling_time, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        delivery = true
        Delivery()
    end)
end)

RegisterNetEvent('rz-delivery:client:delivery-stop', function() -- small
    delivery = false
    exports['qb-target']:RemoveZone("sell")
    RemoveBlip(delivery_blip)
end)

exports['qb-target']:AddCircleZone('delivery', vector3(Config.start_coord.x, Config.start_coord.y, Config.start_coord.z), 2.0,{
    name = 'delivery', debugPoly = false, useZ=true}, {
    options = {{label = Config.lang.delivery_label ,icon = 'fa-solid fa-hand-holding', action = function() TriggerEvent('rz-delivery:menu') end}},
    distance = 2.0
})


Citizen.CreateThread(function()
    local spawn_ped = 0xEFE5AFE6 
    local ped_coord = { x = Config.npc_coord.x, y = Config.npc_coord.y, z = Config.npc_coord.z - 1, h = Config.npc_coord.w}
    RequestModel(spawn_ped)
    while not HasModelLoaded(spawn_ped) do
        Wait(1)
    end
    ped = CreatePed(1, spawn_ped, ped_coord.x, ped_coord.y, ped_coord.z, ped_coord.h, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true) 
    SetPedDiesWhenInjured(ped, false) 
    SetPedCanPlayAmbientAnims(ped, true) 
    SetPedCanRagdollFromPlayerImpact(ped, false) 
    SetEntityInvincible(ped, true)    
    FreezeEntityPosition(ped, true) 
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GUARD_STAND", 0, true); 
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(vector3(Config.start_coord.x, Config.start_coord.y, Config.start_coord.z))
    SetBlipSprite(blip, Config.blip_settings.npc_blip.BlipSprite)
    SetBlipColour(blip, Config.blip_settings.npc_blip.BlipColour)
    SetBlipScale(blip, Config.blip_settings.npc_blip.BlipScale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.blip_settings.npc_blip.BlipName)
    EndTextCommandSetBlipName(blip)
end)

