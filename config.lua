Config = {}

Config.Core = 'qb-core'
Config.InventoryTrigger = 'inventory:client:ItemBox'
Config.Phone = 'qb-phone:server:sendNewMail'
Config.QBTarget = "qb-target"
Config.QBMenu = "qb-menu"
Config.QBLock = "qb-lock"

Config.Payment = "cash" --cash/bank

Config.BombPrice = 10000  -- bomb price

Config.Item = 'carbomb'
Config.defuseditem = 'bomb_controler'

Config.PoliceJob = 'police'   -- bomb diffuse job

Config.Targer1Boss = vector3(69.53, 3762.02, 39.74)    -- target location
Config.Targer2Boss = vector3(1744.87, 3808.09, 34.7)    -- target location

Config.Waypoint = vector3(1749.07, 3809.99, 34.57)

Config.JobDefused = true -- True for police only to disarm/False for everyone to disarm

Config.TimeToSet = math.random(5000, 5000)    -- set progressbar time

Config.Distance = {
    [1] = {
        key = 47, -- Key to explosion the vehicle G
    },
}

Config.Alerts = {
    ['bomb_sunject'] = 'Bomb Boss...',
    ['boss_message'] = 'Follow the GPS and get the bomb!',
    ['bomb_plant'] = "PLACING BOMB ON VEHICLE...",
    ['bomb_usenotify'] = 'Detonate the device by pressing [G]',
    ['bomb_notvehicle'] = "You are not near any vehicles",
    ['bomb_invehicle'] = "You can't use that in a vehicle",
    ['bomb_disable'] = 'Bomb Disable whit success!',

    ['target_label'] = "Start Mission",
    ['target_icon'] = "far fa-bomb",

    ['target_buylab'] = "Buy Bomb",
    ['target_buticon'] = "far fa-bomb",

    ['bomb_menumiss'] = 'Bomb Mission',
    ['bomb_txt1'] = 'Hey,how can i help you?',
    ['bomb_header1'] = '[💣]I need a bomb for explosion a car!',
    ['bomb_cancel1'] = '[❌]Cancel the mission',

    ['bomb_seller'] = 'Bomb Seller',
    ['seller_txt'] = 'Hey,how can i help you?',
    ['seller_header'] = '[💣]I want to buy a bomb!',
    ['Cancel_seller'] = '[❌]Cancel',

    ['bomb_disablepro'] = "DISABLE THE BOMB OF THE VEHICLE...",
    ['bomb_startpro'] = 'OBTAINING THE INFORMATION...',
    ['bomb_defusednot'] = 'You can\'t disarm a vehicle...',
}

Config.DistanceType = 1 -- DO NOT TOUCH!