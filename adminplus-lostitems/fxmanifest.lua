fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'AdminPlus#0001 | AdminPlus'
description 'AdminPlus Lost Items'

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
    'client/*'
}

shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
    '@async/async.lua',
	'server/*'
}

dependencies {
	'es_extended'
}

 