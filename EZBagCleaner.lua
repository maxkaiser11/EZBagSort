local f = CreateFrame("Frame")
f:RegisterEvent("MERCHANT_SHOW")
f:SetScript("OnEvent", function()
    if not EZSellButton then
        CreateSellButton()
    end
end)

function CreateSellButton()
    EZSellButton = CreateFrame("Button", nil, MerchantFrame, "UIPanelButtonTemplate")
    EZSellButton:SetSize(100, 25)
    EZSellButton:SetText("Sell Junk")
    EZSellButton:SetPoint("TOPRIGHT", MerchantFrame, "TOPRIGHT", -25, -35)

    EZSellButton:SetScript("OnClick", function()
        local total = 0
        for bag = 0, 4 do
            for slot = 1, C_Container.GetContainerNumSlots(bag) do
                local itemInfo = C_Container.GetContainerItemInfo(bag, slot)
                if itemInfo then
                    local quality = itemInfo.quality
                    local sellPrice = itemInfo.sellPrice or 0
                    if quality == 0 and sellPrice > 0 then -- gray items
                        C_Container.UseContainerItem(bag, slot)
                        total = total + (sellPrice * itemInfo.stackCount)
                    end
                end
            end
        end
        if total > 0 then
            print("|cff00ff00EZBagCleaner:|r Sold junk for " .. C_CurrencyInfo.GetCoinTextureString(total))
        else
            print("|cffff0000EZBagCleaner:|r No junk items to sell.")
        end
    end)
end
