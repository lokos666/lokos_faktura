RegisterNetEvent('lokos_faktura:client:send', function(fromWho, howMuch)
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'paymentMenu', {
        title = ('Faktura - %s$ od ID %s'):format(howMuch, fromWho),
        align = 'center',
        elements = {
            {label = 'Zapłać gotówką', value = 'money'},
            {label = 'Zapłać kartą', value = 'bank'},
            {label = 'Odrzuć', value = 'odrzuc'},
        }
    }, function(data, menu)
        if data.current.value ~= 'odrzuc' then
            TriggerServerEvent('lokos_faktura:server:payment', fromWho, howMuch, data.current.value)
        else 
            TriggerServerEvent('lokos_faktura:server:anuluj', fromWho, howMuch)
        end 

        menu.close()
    end, function(data, menu)
        TriggerServerEvent('lokos_faktura:server:anuluj', fromWho, howMuch)

        menu.close()
    end)
end)