local function sendToDiscord(playerName, playerId, weapon, roleList)
    local embed = {{
        color = 15158332,
        title = "❌ Unauthorized Weapon Removed",
        description = string.format("Player **%s** (ID: %s) had **%s**, not allowed for roles: `%s`.",
            playerName, playerId, weapon, table.concat(roleList, ", ")),
        footer = { text = os.date("Date: %Y-%m-%d | Time: %H:%M:%S") }
    }}

    PerformHttpRequest(Config.WebhookURL, function() end, "POST", json.encode({
        username = "Weapon Logger",
        embeds = embed
    }), { ["Content-Type"] = "application/json" })
end

RegisterServerEvent("weaponLogger:unauthorizedWeapon")
AddEventHandler("weaponLogger:unauthorizedWeapon", function(weaponName, roles)
    local src = source
    if type(roles) == "string" then
        roles = { roles }
    end
    sendToDiscord(GetPlayerName(src), src, weaponName, roles)
end)

RegisterServerEvent("weaponLogger:requestAceGroup")
AddEventHandler("weaponLogger:requestAceGroup", function()
    local src = source
    local playerRoles = {}

    local identifiers = GetPlayerIdentifiers(src)
    local discordId = nil

    for _, id in ipairs(identifiers) do
        if string.find(id, "discord:") then
            discordId = string.sub(id, 9)
            break
        end
    end

    if not discordId then
        print("^1[WeaponLogger] Player does not have Discord linked.^7")
        TriggerClientEvent("weaponLogger:setAceGroups", src, { "group.user" })
        return
    end

    local roles = exports.Badger_Discord_API:GetDiscordRoles(src)

    local allGroups = {
        [1367108945638064207] = "group.owner",
        [1369793148104081479] = "group.coowner",
        [1369793235417038848] = "group.manager",
        [1367109594802815006] = "group.senioradmin",
        [1369793289162850375] = "group.junioradmin",
        [1369793355885842574] = "group.seniormod",
        [1369793442531770498] = "group.juniormod",
        [1369793621406257182] = "group.trialmod",
        [1369788032911151166] = "group.high",
        [1369787920638283818] = "group.middle",
        [1369787867269828629] = "group.lower",
        [1369787741956739233] = "group.military",
        [1367109423008321596] = "group.fd",
        [1367109338359140392] = "group.ems",
        [1367109285741334588] = "group.leo",
        [1367111700238565437] = "group.user"
    }

    for roleId, group in pairs(allGroups) do
        if roles[tonumber(roleId)] then
            table.insert(playerRoles, group)
        end
    end

    if #playerRoles == 0 then
        table.insert(playerRoles, "group.user")
    end

    TriggerClientEvent("weaponLogger:setAceGroups", src, playerRoles)
end)
