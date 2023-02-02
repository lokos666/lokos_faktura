fx_version 'adamant'
game 'gta5'

author 'github.com/lokos666'
description 'lokos_faktura'

lua54 'yes'

shared_script '@es_extended/imports.lua'

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua',
    'config.lua'
}