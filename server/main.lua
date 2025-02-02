RegisterNetEvent("supermarket:buyItems")
AddEventHandler("supermarket:buyItems", function(item, count, price, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.canCarryItem(item, count) then
        if type == 1 then
            if xPlayer.getAccount("money").money >= price then
                xPlayer.addInventoryItem(item, count) 
                xPlayer.removeAccountMoney("money", price)  
                TriggerClientEvent('esx:showNotification', source,  "Vous avez payé ~g~"..price.."$")
                SupermarketDiscordLog("Achat supérette", string.format("**Joueur** : %s\n**Article acheté** : %s (%s)\n**Quantité** : %d\n**Prix total** : %d$\n**Mode de paiement** : Liquide\n**ID** : %d", xPlayer.getName(), ESX.GetItemLabel(item), item, count, price, source), 16034613)
            else
                TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'argent")
            end
        else
            if xPlayer.getAccount("bank").money >= price then
                xPlayer.removeAccountMoney("bank", price)            
                xPlayer.addInventoryItem(item, count)
                TriggerClientEvent('esx:showNotification', source,  "Vous avez payé ~b~"..price.."$")
                SupermarketDiscordLog("Achat supérette", string.format("**Joueur** : %s\n**Article acheté** : %s (%s)\n**Quantité** : %d\n**Prix total** : %d$\n**Mode de paiement** : Carte bancaire\n**ID** : %d", xPlayer.getName(), ESX.GetItemLabel(item), item, count, price, source), 16034613)
            else
                TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'argent")
            end
        end
    else
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez de place dans votre inventaire")
    end
end)