ESX.RegisterCommand('faktura', 'user', function(xPlayer, args, showError)
    for i = 1, #Config['allowedJobs'] do
        if xPlayer.getJob().name == Config['allowedJobs'][i] then 
	        args.playerId.triggerEvent('lokos_faktura:client:send', xPlayer.source, args.money)
        end 
    end 
end, true, {help = 'Wyślij fakturę (dla frakcji)', validate = true, arguments = {
	{name = 'playerId', help = 'ID gracza', type = 'player'},
	{name = 'money', help = 'Kwota', type = 'number'}
}})

RegisterServerEvent('lokos_faktura:server:payment', function(player, howMuch, account)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getAccount(account).money >= howMuch then 
        local targetPlayer = ESX.GetPlayerFromId(player)

        xPlayer.removeAccountMoney(account, howMuch)

        xPlayer.showNotification('Opłacono fakturę od ID ' .. targetPlayer.source .. ' na kwotę ' .. howMuch)

        targetPlayer.addAccountMoney(account, howMuch)

        targetPlayer.showNotification('ID ' .. xPlayer.source .. ' opłacił/a fakturę na kwotę $' .. howMuch)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'Nie jesteś w stanie opłacić tej faktury wybraną metodą')

        TriggerClientEvent('esx:showNotification', player, 'ID ' .. xPlayer.source .. ' nie jest w stanie opłacić faktury wybraną metodą')
    end 
end)

RegisterServerEvent('lokos_faktura:server:anuluj', function(player, money)
    TriggerClientEvent('esx:showNotification', source, 'Odrzucono fakturę od ID ' .. player .. ' na kwotę $' .. money)

    TriggerClientEvent('esx:showNotification', player, 'ID ' .. source .. ' odrzucił/a twoją fakturę na $' .. money)
end)