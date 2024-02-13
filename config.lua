Config = {

    delivery_cd = 5000,
    delivery_payment = 600, --or math.random(600, 1200)
    money_type = "cash",
    delivery_item = "phone",
    selling_time = 2500,
    start_coord = vector3(-1671.75, 136.5, 63.27),
    npc_coord = vector4(-1671.75, 136.5, 63.27, 310.45),
    ["coords"] = {
        [1] = vector3(-595.57, 393.08, 101.88),
        [2] = vector3(-1649.85, 151.02, 62.16),
        [3] = vector3(-1291.84, 650.42, 141.5),
        [4] = vector3(-1367.34, 610.65, 133.88),
        [5] = vector3(-1337.04, 606.08, 134.38),
        [6] = vector3(-1405.03, 561.92, 125.41),
        [7] = vector3(-1540.09, 420.53, 110.01),
        [8] = vector3(-1218.85, 665.01, 144.53),
        [9] = vector3(-1196.74, 693.12, 147.43),
        [10] = vector3(-1165.61, 726.77, 155.61)
    },

    ["blip_settings"] = {
        ["customer_blip"] = {
            BlipSprite = 842,
            BlipColour = 2,
            BlipScale = 0.9,
            BlipName = "Customer"
        },
        ["npc_blip"] = {
            BlipSprite = 280,
            BlipColour = 1,
            BlipScale = 0.5,
            BlipName = "Human"
        }
    },

    ["lang"] = {
        delivery_label = "Delivery Menu",
        sell_label = "Sell",
        start_selling = "Start Selling",
        stop_selling = "Stop Selling",
        no_item = "No Item to Sell!",
        selling = "Selling in Progress",
        search_customer = "Searching for Customer",
        new_customer = "Location of New Customer will be Shared with You Shortly.",
        
    }
}
