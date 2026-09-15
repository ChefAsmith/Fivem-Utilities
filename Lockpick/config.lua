Config = Config or {}

Config.LockpickVehicles = {
    -- modelHash = difficulty
    [GetHashKey("sultan")] = 4,
    [GetHashKey("adder")] = 5,
    default = 3
}

Config.LockpickPins = {
    [GetHashKey("sultan")] = 5,
    [GetHashKey("adder")] = 7,
    default = 4 -- Default number of pins
}
