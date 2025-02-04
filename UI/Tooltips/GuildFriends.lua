local _, addon = ...
local Guild = addon:GetObject("Guild")
local Tooltip = addon:NewTooltip("GuildFriends", "Friends")

local L = addon.L

Tooltip:RegisterHookScript(GuildMicroButton, "OnEnter", function(self)
    if not self:IsEnabled() then
        return
    end

    local numTotalGuildMembers, numOnlineGuildMembers = GetNumGuildMembers()

    if numTotalGuildMembers > 0 then
        Tooltip:AddFormattedHeader(L["X Members Y Online"], numTotalGuildMembers, numOnlineGuildMembers)

        local totalOnlineGuildFriends = Guild:GetTotalOnlineFriends()

        if totalOnlineGuildFriends > 0 then
            Tooltip:AddFormattedHeader(L["Guild Friends (X):"], totalOnlineGuildFriends)

            for friend in Guild:IterableOnlineFriendsInfo() do
                local charName = Tooltip:GetFormattedCharName(friend)
                charName = Tooltip:GetFormattedStatus(friend, charName)

                Tooltip:SetLine(charName)

                if IsShiftKeyDown() and friend.zoneName then
                    Tooltip:SetLine(friend.zoneName)

                    if friend.sameZone then
                        Tooltip:SetGreenColor()
                    else
                        Tooltip:SetGrayColor()
                    end
                end

                Tooltip:ToLine()
            end
        end

        Tooltip:Show()
    end
end)
