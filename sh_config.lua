/*---------------------------------------------------------------------------
HUD Config
Edit these settings to your liking it will be limited though but I will try and make it flexible.
---------------------------------------------------------------------------*/


-- Colour configs
DankConfig = {}

DankConfig.FirstColor = Color( 0, 0, 0, 220 )
DankConfig.SecondColor = Color( 255, 255, 255, 255 )
DankConfig.TertiaryColor = Color( 0, 0, 0, 255 )

DankConfig.TextColor = Color( 255, 255, 255, 255 )
DankConfig.MoneyColor = Color( 50, 200, 50, 255 )
DankConfig.MoneyColor2 = Color( 150, 225, 150, 255 )

DankConfig.HealthColor = Color( 200, 50, 50, 255 )
DankConfig.ArmorColor = Color( 50, 50, 200, 255 )
DankConfig.HealthColor2 = Color( 150, 25, 25, 255 )
DankConfig.ArmorColor2 = Color( 25, 25, 150, 255 )

DankConfig.AgendaTitleColor = Color( 255, 0, 0, 240 )
DankConfig.AmmoColor = Color( 50, 50, 50, 255 )
DankConfig.WantedColor = Color( 255, 100, 100, 255 )
DankConfig.LockdownColor = Color( 200, 50, 50, 255 )


-- Localplayers left side HUD

DankConfig.HealthPanel = true -- Should the health bar appear?
DankConfig.ArmorPanel = true -- Should the armor bar appear?
DankConfig.AdaptiveArmorPanel = false -- Should the armor automatically, dependant on whether the player has any armor.
DankConfig.JobPanel = true -- Should the job panel appear?
DankConfig.Compass = true -- Should the HUD have a compass?

DankConfig.WantedLicensePanel = true -- Should there be a display for licenses and if the player is wanted.
DankConfig.AdaptiveLicensePanel = false -- Should it dissappear if there is no license?
DankConfig.WantedAlert = true -- Should there be a place telling a player if they're wanted or not?
DankConfig.AdaptiveWantedAlert = true -- Should the wanted panel only appear when the player is wanted?
DankConfig.LockdownAlert = true -- Should there be a displayed msg if there is a lockdown?

DankConfig.Warranted = true -- Should you see a warning when you're warranted?


-- Localplayers right side HUD

DankConfig.AmmoPanel = true -- Should the ammo panel appear?
DankConfig.WeaponNamePanel = true -- Should you see the name of the held weapon?
DankConfig.AdaptiveAmmoPanel = false -- Should the ammo dissappear if there is an invalid gun?
DankConfig.MoneyPanel = true -- Should the money be displayed?
DankConfig.ServerPanel = true -- Should the server info panel appear?


-- Info about other players

DankConfig.OthersNames = true -- Should you see the names of other players?
DankConfig.OthersJob = true -- Should you see the job of other players?
DankConfig.OthersHealth = true -- Should you see the health of other players?
DankConfig.OthersArmor = true -- Should you see the armor of other players?
DankConfig.AdaptiveOthersArmor = false -- Should you hide the armor of other players if they have none?
DankConfig.OthersWanted = true -- Should you see if another player is wanted?
DankConfig.OthersArrested = true -- Should you see another player in jails time remaining?
DankConfig.OthersLicense = true -- Should you see another players gun license status?


-- Miscellaneous

DankConfig.MaxArmor = 1000 -- Whats the highest amount of armor any job is able to have?
DankConfig.FontThick = 250 -- How thick should the text be on the hud? Default is 250


-- Money Display

DankConfig.UseSWCreds = false -- Should the money be in Star Wars credits?
DankConfig.moneySymbol = "£" -- Symbol before money count, only works if the above is false


-- Blur Config

DankConfig.Blur = true -- Should the hud have a blur?
DankConfig.BlurLayers = 2 -- How many layers of the blur are there?( The more there is the more blur. )
DankConfig.BlurDensity = 2 -- How blury is it? ( I recommend 2 - 10 )
DankConfig.BlurAlpha = 240 -- How visible is the blur?( 0 - 255 )


-- MSG Configs

DankConfig.LockdownMSG = "Lockdown!" -- What msg should be above the lockdown line?
DankConfig.LockdownMSGRequest = "A lockdown has been initialised please return to your homes!" -- The msg that appears below the line on the screen and requests players to go somewhere or do something.

DankConfig.ArrestedTopMSG = "Arrested!" -- The msg above the line when a player is arrested and what is seen when another player is arrested.
DankConfig.JailedMSG = "You have been arrested and detained" -- The msg presented on the players screen whilst in jail.