fx_version 'cerulean'
game 'gta5'

author 'MrRebel#7457 (mr-scripts)'
description 'mr-carbomb'
version '1.2'

client_scripts{
    'client.lua',
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua'
}

shared_scripts{
    'config.lua',
}

server_scripts{
    'server.lua',
}

dependencies {
    'PolyZone',
    'qb-menu',
    'qb-target'
}
