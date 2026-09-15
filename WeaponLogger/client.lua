local playerAceGroups = { "group.user" }

RegisterNetEvent("weaponLogger:setAceGroups", function(groups)
    if type(groups) ~= "table" then
        print("^1[WeaponLogger] Received invalid ACE group list!^7")
        return
    end
    playerAceGroups = groups
    print("^2[WeaponLogger] Received ACE groups: " .. json.encode(playerAceGroups) .. "^7")
end)

local function isWeaponAllowed(weaponName, aceGroups)
    if not Config or not Config.AllowedWeapons then
        print("^1[WeaponLogger] Config or AllowedWeapons is nil!^7")
        return false
    end

    for _, group in ipairs(aceGroups) do
        local allowed = Config.AllowedWeapons[group]
        if type(allowed) == "table" then
            for _, allowedWeapon in ipairs(allowed) do
                if weaponName == allowedWeapon then
                    return true
                end
            end
        end
    end

    return false
end

    local knownWeapons = {
        [-1569615261] = "WEAPON_UNARMED",
        [453432689] = "WEAPON_PISTOL",
        [-1834847097] = "WEAPON_DAGGER",
        [-1786099057] = "WEAPON_BAT",
        [-102323637] = "WEAPON_BOTTLE",
        [2067956739] = "WEAPON_CROWBAR",
        [-1951375401] = "WEAPON_FLASHLIGHT",
        [1141786504] = "WEAPON_GOLFCLUB",
        [1317494643] = "WEAPON_HAMMER",
        [-102973651] = "WEAPON_HATCHET",
        [-656458692] = "WEAPON_KNUCKLE",
        [-1716189206] = "WEAPON_KNIFE",
        [-581044007] = "WEAPON_MACHETE",
        [-538741184] = "WEAPON_SWITCHBLADE",
        [1737195953] = "WEAPON_NIGHTSTICK",
        [419712736] = "WEAPON_WRENCH",
        [-853065399] = "WEAPON_BATTLEAXE",
        [-1810795771] = "WEAPON_POOLCUE",
        [940833800] = "WEAPON_STONE_HATCHET",
        [-1075685676] = "WEAPON_PISTOL_MK2",
        [1593441988] = "WEAPON_COMBATPISTOL",
        [584646201] = "WEAPON_APPISTOL",
        [911657153] = "WEAPON_STUNGUN",
        [-1716589765] = "WEAPON_PISTOL50",
        [-1076751822] = "WEAPON_SNSPISTOL",
        [-2009644972] = "WEAPON_SNSPISTOL_MK2",
        [-771403250] = "WEAPON_HEAVYPISTOL",
        [137902532] = "WEAPON_VINTAGEPISTOL",
        [1198879012] = "WEAPON_FLAREGUN",
        [-598887786] = "WEAPON_MARKSMANPISTOL",
        [-1045183535] = "WEAPON_REVOLVER",
        [-879347409] = "WEAPON_REVOLVER_MK2",
        [-1746263880] = "WEAPON_DOUBLEACTION",
        [-1355376991] = "WEAPON_RAYPISTOL",
        [727643628] = "WEAPON_CERAMICPISTOL",
        [-1853920116] = "WEAPON_NAVYREVOLVER",
        [324215364] = "WEAPON_MICROSMG",
        [736523883] = "WEAPON_SMG",
        [2024373456] = "WEAPON_SMG_MK2",
        [-270015777] = "WEAPON_ASSAULTSMG",
        [171789620] = "WEAPON_COMBATPDW",
        [-619010992] = "WEAPON_MACHINEPISTOL",
        [-1121678507] = "WEAPON_MINISMG",
        [1198256469] = "WEAPON_RAYCARBINE",
        [487013001] = "WEAPON_PUMPSHOTGUN",
        [1432025498] = "WEAPON_PUMPSHOTGUN_MK2",
        [2017895192] = "WEAPON_SAWNOFFSHOTGUN",
        [-494615257] = "WEAPON_ASSAULTSHOTGUN",
        [-1654528753] = "WEAPON_BULLPUPSHOTGUN",
        [-1466123874] = "WEAPON_MUSKET",
        [984333226] = "WEAPON_HEAVYSHOTGUN",
        [-275439685] = "WEAPON_DBSHOTGUN",
        [317205821] = "WEAPON_AUTOSHOTGUN",
        [-1074790547] = "WEAPON_ASSAULTRIFLE",
        [961495388] = "WEAPON_ASSAULTRIFLE_MK2",
        [-2084633992] = "WEAPON_CARBINERIFLE",
        [-86904375] = "WEAPON_CARBINERIFLE_MK2",
        [-1357824103] = "WEAPON_ADVANCEDRIFLE",
        [-1063057011] = "WEAPON_SPECIALCARBINE",
        [-1768145561] = "WEAPON_SPECIALCARBINE_MK2",
        [2132975508] = "WEAPON_BULLPUPRIFLE",
        [-2066285827] = "WEAPON_BULLPUPRIFLE_MK2",
        [1649403952] = "WEAPON_COMPACTRIFLE",
        [-1660422300] = "WEAPON_MG",
        [2144741730] = "WEAPON_COMBATMG",
        [-608341376] = "WEAPON_COMBATMG_MK2",
        [1627465347] = "WEAPON_GUSENBERG",
        [100416529] = "WEAPON_SNIPERRIFLE",
        [205991906] = "WEAPON_HEAVYSNIPER",
        [177293209] = "WEAPON_HEAVYSNIPER_MK2",
        [-952879014] = "WEAPON_MARKSMANRIFLE",
        [1785463520] = "WEAPON_MARKSMANRIFLE_MK2",
        [-1312131151] = "WEAPON_RPG",
        [-1568386805] = "WEAPON_GRENADELAUNCHER",
        [1305664598] = "WEAPON_GRENADELAUNCHER_SMOKE",
        [1119849093] = "WEAPON_MINIGUN",
        [2138347493] = "WEAPON_FIREWORK",
        [1834241177] = "WEAPON_RAILGUN",
        [1672152130] = "WEAPON_HOMINGLAUNCHER",
        [125959754] = "WEAPON_COMPACTLAUNCHER",
        [-1238556825] = "WEAPON_RAYMINIGUN",
        [-1813897027] = "WEAPON_GRENADE",
        [-1600701090] = "WEAPON_BZGAS",
        [615608432] = "WEAPON_MOLOTOV",
        [-1420407917] = "WEAPON_PROXMINE",
        [126349499] = "WEAPON_SNOWBALL",
        [-1169823560] = "WEAPON_PIPEBOMB",
        [600439132] = "WEAPON_BALL",
        [-37975472] = "WEAPON_SMOKEGRENADE",
        [1233104067] = "WEAPON_FLARE",
        [741814745] = "WEAPON_STICKYBOMB",
        [883325847] = "WEAPON_PETROLCAN",
        [-72657034] = "GADGET_PARACHUTE",
        [101631238] = "WEAPON_FIREEXTINGUISHER",
        [-1168940174] = "WEAPON_HAZARDCAN",
        [406929569] = "WEAPON_FERTILIZERCAN",
        [62870901] = "WEAPON_SNOWBALL_LAUNCHER",
        [1470379660] = "WEAPON_GADGETPISTOL",
        [0x1BC4FDB9] = "WEAPON_PISTOLXM3",
        [485882440] = "GADGET_HACKINGDEVICE",
        [1171102963] = "WEAPON_STUNGUN_MP",
        [0xD1D5F52B] = "WEAPON_TACTICALRIFLE",
        [0x9D1F17E6] = "WEAPON_MILITARYRIFLE",
        [0xC78D71B4] = "WEAPON_HEAVYRIFLE",
        [1924557585] = "WEAPON_BATTLERIFLE",
        [0x6E7DDDEC] = "WEAPON_PRECISIONRIFLE",
        [0x5A96BA4] = "WEAPON_COMBATSHOTGUN",
        [-618237638] = "WEAPON_EMPLAUNCHER",
        [-22923932] = "WEAPON_RAILGUNXM3",
        [-135142818] = "WEAPON_ACIDPACKAGE",
        [350597077] = "WEAPON_TECPISTOL"
    }

local function checkPlayerWeapons()
    local ped = PlayerPedId()
    local aceGroups = playerAceGroups
end

local function removeDisallowedWeapons()
    local ped = PlayerPedId()

    for weaponHash, weaponName in pairs(knownWeapons) do
        if HasPedGotWeapon(ped, weaponHash, false) then
            if not isWeaponAllowed(weaponName, playerAceGroups) then
                RemoveWeaponFromPed(ped, weaponHash)
                print(("^1[WeaponLogger] Removed disallowed weapon: %s (%s)^7"):format(weaponName, weaponHash))
            end
        end
    end

    -- Handle weapons not in knownWeapons table
    local currentWeaponHash = GetSelectedPedWeapon(ped)
    if not knownWeapons[currentWeaponHash] then
        RemoveWeaponFromPed(ped, currentWeaponHash)
        print(("^1[WeaponLogger] Removed unknown weapon: %s^7"):format(currentWeaponHash))
    end
end

CreateThread(function()
    while true do
        Wait(Config.CheckInterval * 1000)
        removeDisallowedWeapons()
    end
end)