local ped = PlayerPedId()

local function HotwireVehicle(veh)
    lib.notify({ type = 'info', description = 'Hotwiring vehicle...' })

    RequestAnimDict("veh@low@front_ds@base")
    while not HasAnimDictLoaded("veh@low@front_ds@base") do
        Citizen.Wait(0)
    end

    TaskPlayAnim(ped, "veh@low@front_ds@base", "hotwire", 1.0, -1.0, 8000, 0, 1, true, true, true)

    FreezeEntityPosition(ped, true)
    Citizen.Wait(8000)
    FreezeEntityPosition(ped, false)

    SetVehicleEngineOn(veh, true, true, false)
    SetVehicleUndriveable(veh, false)

    lib.notify({ type = 'success', description = 'Vehicle hotwired successfully!' })
end

local function LockPick()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local veh = GetClosestVehicle(pos.x, pos.y, pos.z, 3.0, 0, 71)

    if not veh or veh == 0 then
        lib.notify({ type = 'error', description = 'No vehicle nearby.' })
        return
    end

    local model = GetEntityModel(veh)
    local difficulty = Config.LockpickVehicles[model] or Config.LockpickVehicles.default or 3
    local pins = Config.LockpickPins[model] or Config.LockpickPins.default or 4

    local success = exports.t3_lockpick:startLockpick("lockpick", difficulty, pins)

    if success then
        RequestAnimDict("mp_arresting")
        while not HasAnimDictLoaded("mp_arresting") do
            Citizen.Wait(0)
        end

        TaskPlayAnim(ped, "mp_arresting", "a_uncuff", 1.0, -1.0, 5500, 0, 1, true, true, true)

        -- Request control
        NetworkRequestControlOfEntity(veh)
        local timeout = 1000
        while not NetworkHasControlOfEntity(veh) and timeout > 0 do
            Citizen.Wait(10)
            NetworkRequestControlOfEntity(veh)
            timeout = timeout - 10
        end

        -- Unlock doors
        SetVehicleDoorsLocked(veh, 1)
        SetVehicleDoorsLockedForAllPlayers(veh, false)

        -- Alarm
        SetVehicleAlarm(veh, true)
        SetVehicleAlarmTimeLeft(veh, 30000)

        FreezeEntityPosition(ped, true)
        Citizen.Wait(5500)
        FreezeEntityPosition(ped, false)

        -- Prevent engine use until hotwired
        SetVehicleEngineOn(veh, false, true, false)
        SetVehicleUndriveable(veh, true)

        lib.notify({ type = 'success', description = 'Vehicle lockpicked. Now hotwire it.' })

        HotwireVehicle(veh)
    else
        lib.notify({ type = 'error', description = 'Lockpicking failed.' })
    end
end

RegisterCommand('lockpick', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local veh = GetClosestVehicle(pos.x, pos.y, pos.z, 3.0, 0, 71)

    if not veh or veh == 0 then
        lib.notify({ type = 'error', description = 'No vehicle nearby to lockpick.' })
        return
    end

    local vehpos = GetEntityCoords(veh)
    local distance = #(vehpos - pos)
    local locked = GetVehicleDoorLockStatus(veh)
    local driver = GetPedInVehicleSeat(veh, -1)
    local seatFree = IsVehicleSeatFree(veh, -1)

    local isLocked = locked ~= 0 and locked ~= 1 or driver ~= 0 or not seatFree

    if distance < 3 then
        if isLocked or locked == 1 or locked == 0 then
            LockPick()
        else
            lib.notify({ type = 'info', description = 'Vehicle is already unlocked.' })
        end
    else
        lib.notify({ type = 'error', description = 'No vehicle nearby to lockpick.' })
    end
end)
