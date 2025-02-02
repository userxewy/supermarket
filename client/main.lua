local Quantity = { Index = 1 }

local SupermarketMenu = RageUI.CreateMenu("Supérette", "Interactions disponibles")
local BuyItems =  RageUI.CreateSubMenu(SupermarketMenu, "Supérette", "Interactions disponibles")

SupermarketMenu.Closed = function()
    RageUI.CloseAll()
    MenuIsOpen = false 
    FreezeEntityPosition(PlayerPedId(), false)
end
BuyItems.Closed = function()
    Quantity.Index = 1
    Price = nil
end

function OpenSupermarketMenu()
    if MenuIsOpen then 
        RageUI.CloseAll()
        MenuIsOpen = false 
    else
        MenuIsOpen = true 
        RageUI.Visible(SupermarketMenu, true)
        CreateThread(function ()
            while MenuIsOpen do 
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(SupermarketMenu, function()
                    RageUI.Separator("← Liste des articles disponibles →")
                    for k,v in pairs (SupermarketSettings.Items) do
                        if activeCode == true then
                            RageUI.Button(v.label, nil, {RightLabel = "~g~"..Round(v.price * (1-(percent/100))).."$"} ,true, {
                                onSelected = function()
                                    currentItem = v.item
                                    currentPrice = Round(v.price * (1-(percent/100)))
                                    Quantity.Index = 1
                                end
                            },BuyItems)
                        else
                            RageUI.Button(v.label, nil, {RightLabel = "~g~"..v.price.."$"} ,true, {
                                onSelected = function()
                                    currentItem = v.item
                                    currentPrice = v.price
                                    Quantity.Index = 1
                                end
                            },BuyItems)
                        end
                    end
                end)
                RageUI.IsVisible(BuyItems, function()
                    RageUI.List('Quantité :', {"1","2","3","4","5","6","7","8","9","10"}, Quantity.Index, nil, {}, true, {
                        onListChange = function(Index)
                            Quantity.Index = Index
                            Price = "Prix total : ~g~"..currentPrice*Index.."$"
                        end
                    })
                    if Quantity.Index ~= 1 then 
                        RageUI.Separator(Price)
                    end
                    RageUI.Separator("← Moyens de paiement →")
                    RageUI.Button("Paiement en liquide", nil, {RightLabel = "→"} ,true, {
                        onSelected = function()
                            TriggerServerEvent("supermarket:buyItems", currentItem, Quantity.Index, Quantity.Index*currentPrice, 1)

                        end
                    })
                    RageUI.Button("Paiement par compte bancaire", nil, {RightLabel = "→"} ,true, {
                        onSelected = function()
                            TriggerServerEvent("supermarket:buyItems", currentItem, Quantity.Index, Quantity.Index*currentPrice, 2)
                        end
                    })
                end)
                Wait(0)
            end
        end)
    end
end