fx_version 'cerulean'
game 'gta5'

author 'ChefAmbrosia'
description 'Lockpick Script'
version '1.1.1'

lua54 'yes'

shared_scripts { 
    '@ox_lib/init.lua',
    'config.lua'
}

client_script 'client.lua'

dependencies {
    'ox_lib',
    't3_lockpick'
}
