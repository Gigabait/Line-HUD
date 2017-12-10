include( "sh_config.lua" )

/*---------------------------------------------------------------------------
HUD Fonts
---------------------------------------------------------------------------*/
surface.CreateFont( "LInfoFont", {
	font = "Roboto",
	size = 40,
	weight = DankConfig.FontThick,
	blursize = 0,
	antialias = true,
	underline = false,
	italis = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = true,
	outline = false
})

surface.CreateFont( "MInfoFont", {
	font = "Roboto",
	size = 28,
	weight = DankConfig.FontThick,
	blursize = 0,
	antialias = true,
	underline = false,
	italis = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false
})

surface.CreateFont( "SMInfoFont", {
	font = "Roboto",
	size = 23,
	weight = DankConfig.FontThick,
	blursize = 0,
	antialias = true,
	underline = false,
	italis = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false
})

surface.CreateFont( "SInfoFont", {
	font = "Roboto",
	size = 20,
	weight = DankConfig.FontThick,
	blursize = 0,
	antialias = true,
	underline = false,
	italis = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = true,
	outline = false
})

surface.CreateFont( "TInfoFont", {
	font = "Roboto",
	size = 13,
	weight = DankConfig.FontThick,
	blursize = 0,
	antialias = true,
	underline = false,
	italis = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = true,
	outline = false
})

/*---------------------------------------------------------------------------
HUD Vars ( Don't Touch )
---------------------------------------------------------------------------*/
if SERVER then
	
	resource.AddFile( "materials/sw_hud/gunlicense.vmt" )
	resource.AddFile( "materials/sw_hud/gunlicense.vtf" )
	resource.AddFile( "materials/sw_hud/creditsymbol.vmt" )
	resource.AddFile( "materials/sw_hud/creditsymbol.vtf" )
	resource.AddFile( "materials/sw_hud/mic.vmt" )
	resource.AddFile( "materials/sw_hud/mic.vtf" )

end


DankVar = {}

function DankVars()

	DankVar.lPlayer = LocalPlayer()

	DankVar.TeamColor = team.GetColor( LocalPlayer():Team() )

	DankVar.MaxHealth = LocalPlayer():GetMaxHealth()



end


local blur = Material( "pp/blurscreen" )
local function drawBlur( x, y, w, h, layers, density, alpha )
	
    surface.SetDrawColor( 0, 0, 0, alpha )
    surface.SetMaterial( blur )
 
    for i = 1, layers do

        blur:SetFloat( "$blur", ( i / layers ) * density )
        blur:Recompute()
 
        render.UpdateScreenEffectTexture()
        render.SetScissorRect( x, y, x + w, y + h, true )
        surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
        render.SetScissorRect( 0, 0, 0, 0, false )

    end
end

function FormatNumber( n )

	if not n then return "" end

	if n >= 1e14 then return tostring(n) end
	n = tostring(n)
	local sep = sep or ","
	local dp = string.find(n, "%.") or #n+1

	for i=dp-4, 1, -3 do

		n = n:sub(1, i) .. sep .. n:sub(i+1)
		
	end

	return n

end


/*---------------------------------------------------------------------------
HUD Drawing
---------------------------------------------------------------------------*/

local function Base()

	if DankConfig.HealthPanel then

		if DankConfig.Blur then
			
			drawBlur( 0, ScrH() - 60 - 10, 400, 60, DankConfig.BlurLayers, DankConfig.BlurDensity, DankConfig.BlurAlpha )

		end

		draw.RoundedBox(0, 0, ScrH() - 60 - 10, 400, 60, DankConfig.FirstColor )
		surface.SetDrawColor( DankConfig.SecondColor )
		surface.DrawOutlinedRect( -1, ScrH() - 60 - 8, 399, 56 )

	end

	if DankConfig.ArmorPanel then

		if DankConfig.AdaptiveArmorPanel then

			if DankVar.lPlayer:Armor() > 0 then

				if DankConfig.Blur then

					drawBlur( 0, ScrH() - 120 - 10, 350, 50, DankConfig.BlurLayers, DankConfig.BlurDensity, DankConfig.BlurAlpha )

				end

				draw.RoundedBox(0, 0, ScrH() - 120 - 10, 350, 50, DankConfig.FirstColor )
				surface.SetDrawColor( DankConfig.SecondColor )
				surface.DrawOutlinedRect( -1, ScrH() - 120 - 7, 348, 44 )

			end

		else

			if DankConfig.Blur then

				drawBlur( 0, ScrH() - 120 - 10, 350, 50, DankConfig.BlurLayers, DankConfig.BlurDensity, DankConfig.BlurAlpha )

			end

			draw.RoundedBox(0, 0, ScrH() - 120 - 10, 350, 50, DankConfig.FirstColor )
			surface.SetDrawColor( DankConfig.SecondColor )
			surface.DrawOutlinedRect( -1, ScrH() - 120 - 8, 349, 46 )

		end

	end

end

local function NameDisplay()

	local yPos = 180

	if DankConfig.ArmorPanel then

		if DankConfig.JobPanel then
			
			if DankConfig.AdaptiveArmorPanel then
				
				if DankVar.lPlayer:Armor() > 0 then

					yPos = 210

				else

					yPos = 150

				end

			else

				yPos = 210

			end

		else

			if DankConfig.AdaptiveArmorPanel then
				
				if DankVar.lPlayer:Armor() > 0 then
					
					yPos = 170

				else

					yPos = 110

				end

			else

				yPos = 170

			end

		end


	else

		if DankConfig.JobPanel then
		
			yPos = 150

		else

			yPos = 110

		end

	end

	surface.SetFont( "SInfoFont" )

	local width, height = surface.GetTextSize( DankVar.lPlayer:Name() )

	if DankConfig.Blur then
			
		drawBlur( 0, ScrH() - yPos, width + 20, 30, DankConfig.BlurLayers, DankConfig.BlurDensity, DankConfig.BlurAlpha )

	end

	draw.RoundedBox(0, 0, ScrH() - yPos, width + 20, 30, DankConfig.FirstColor )

	surface.SetDrawColor( DankConfig.SecondColor )

	surface.DrawOutlinedRect( -1, ScrH() - (yPos - 2), width + 19, 26 )

	draw.SimpleText( DankVar.lPlayer:Name(),"SInfoFont", 10, ScrH() - (yPos - 14), DankConfig.TextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

	draw.RoundedBox(0, 0, ScrH() - yPos, 4, 30, DankVar.TeamColor )

end

local function DankJobBar()

	local yPos = 120

	if DankConfig.ArmorPanel then

		if DankConfig.AdaptiveArmorPanel then
			
			if DankVar.lPlayer:Armor() > 0 then
				
				yPos = 170
				--
			else

				yPos = 110
				--
			end
			--
		else

			yPos = 170
		--
		end
		--
	else
		
		yPos = 110
		--
	end

	local JobName = LocalPlayer():getDarkRPVar("job") or ""

	surface.SetFont( "SInfoFont" )
	local width, height = surface.GetTextSize( JobName )

	if DankConfig.JobPanel then

		if DankConfig.Blur then
			
			drawBlur( 0, ScrH() - yPos, width + 20, 30, DankConfig.BlurLayers, DankConfig.BlurDensity, DankConfig.BlurAlpha )

		end

		local JobName = LocalPlayer():getDarkRPVar("job")

		
		draw.RoundedBox(0, 0, ScrH() - yPos, width + 20, 30, DankConfig.FirstColor )

		surface.SetDrawColor( DankConfig.SecondColor )

		surface.DrawOutlinedRect( 0, ScrH() - ( yPos - 2 ), width + 18, 26 )

		draw.RoundedBox(0, 0, ScrH() - yPos, 4, 30, DankVar.TeamColor )

		draw.SimpleText( JobName, "SInfoFont", 10, ScrH() - yPos + 14, DankConfig.SecondColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

	end

end

local function DankLockdown()

	if DankConfig.LockdownAlert then

		if GetGlobalBool("DarkRP_LockDown") then

			surface.SetFont( "SInfoFont" )
			
			local cin = (math.sin(CurTime()) + 1) / 2
			local width, height = surface.GetTextSize( DankConfig.LockdownMSGRequest )



			draw.RoundedBox( 0, (ScrW() / 2) - (width / 2), ScrH() - 300, width + 10, 3, DankConfig.FirstColor )

			draw.DrawText( DankConfig.LockdownMSGRequest, "SInfoFont", (ScrW() / 2), ScrH()- 280, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

			draw.DrawText( DankConfig.LockdownMSG, "LInfoFont", (ScrW() / 2), ScrH()- 350, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

		end

	end

end

local function HealthArmorBar()

	local yPos = 70

	if DankConfig.JobPanel then
		
		yPos = 150

	else

		yPos = 70

	end

	if DankConfig.JobPanel then
		
		yPos2 = 112
		--
	else

		yPos2 = 32
		--
	end

	if DankConfig.HealthPanel then

		draw.RoundedBox(0, 5, ScrH() - 60 - 5, ( DankVar.lPlayer:Health() / LocalPlayer():GetMaxHealth() ) * 390, 50, DankConfig.HealthColor )
		draw.RoundedBox(0, 0, ScrH() - 60 - 10, 5, 60, DankConfig.HealthColor2 )

		draw.SimpleText( DankVar.lPlayer:Health(),"LInfoFont", 195, ScrH() - (yPos - (yPos2 - 4)), DankConfig.TextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		draw.SimpleText( "/","MInfoFont", 200, ScrH() - (yPos - yPos2), DankConfig.TextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.SimpleText( DankVar.lPlayer:GetMaxHealth(),"MInfoFont", 215, ScrH() - (yPos - yPos2), DankConfig.TextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

	end

	if DankConfig.ArmorPanel then

		if DankConfig.AdaptiveArmorPanel then

			if DankVar.lPlayer:Armor() > 0 then
				
				draw.RoundedBox(0, 5, ScrH() - 120 - 5, ( DankVar.lPlayer:Armor() / DankConfig.MaxArmor ) * 340, 40, DankConfig.ArmorColor )
				draw.RoundedBox(0, 0, ScrH() - 120 - 10, 5, 50, DankConfig.ArmorColor2 )


				draw.SimpleText( DankVar.lPlayer:Armor(),"MInfoFont", 170, ScrH() - yPos + 45, DankConfig.TextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				draw.SimpleText( "/", "MInfoFont", 175, ScrH() - yPos + 45, DankConfig.TextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				draw.SimpleText( DankConfig.MaxArmor,"SInfoFont", 185, ScrH() - yPos + 50, DankConfig.TextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

			else

				-- Blank

			end

		else

			draw.RoundedBox(0, 5, ScrH() - 120 - 5, ( DankVar.lPlayer:Armor() / DankConfig.MaxArmor ) * 340, 40, DankConfig.ArmorColor )
			draw.RoundedBox(0, 0, ScrH() - 120 - 10, 5, 50, DankConfig.ArmorColor2 )

			draw.SimpleText( DankVar.lPlayer:Armor(),"MInfoFont", 170, ScrH() - yPos + 45, DankConfig.TextColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			draw.SimpleText( "/", "MInfoFont", 175, ScrH() - yPos + 45, DankConfig.TextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText( DankConfig.MaxArmor,"SInfoFont", 185, ScrH() - yPos + 50, DankConfig.TextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		end

	end

end



local function DankAgenda()

	local ply = LocalPlayer()

	local agenda = ply:getAgendaTable()
	if not agenda then return end

	surface.SetFont("SInfoFont")

	local width, height = surface.GetTextSize( agenda.Title )

	-- Agenda Title

	if DankConfig.Blur then
			
		drawBlur( 0, 10, width + 20, 30, DankConfig.BlurLayers, DankConfig.BlurDensity, DankConfig.BlurAlpha )

	end

	draw.RoundedBox(0, 0, 10, width + 20, 30, DankConfig.FirstColor)

	surface.SetDrawColor( DankConfig.SecondColor )

	surface.DrawOutlinedRect( -1, 12, width + 19, 26 )

	draw.RoundedBox(0, 0, 10, 4, 30, DankVar.TeamColor)

	-- Agenda Section

	-- Writing

	draw.SimpleText( agenda.Title,"SInfoFont", 9, 24, DankConfig.AgendaTitleColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

	local text = ply:getDarkRPVar("agenda") or ""

	text = text:gsub("//", "\n"):gsub("\\n", "\n")
	text = DarkRP.textWrap(text, "SInfoFont", 375)

	local width, height = surface.GetTextSize( text )

	if DankConfig.Blur then
			
		drawBlur( 0, 50, width + 20, 94, DankConfig.BlurLayers, DankConfig.BlurDensity, DankConfig.BlurAlpha )

	end

	draw.RoundedBox(0, 0, 50, width + 20, 94, DankConfig.FirstColor)

	surface.SetDrawColor( DankConfig.SecondColor )

	surface.DrawOutlinedRect( -1, 52, width + 19, 90 )

	draw.RoundedBox(0, 0, 50, 4, 94, DankVar.TeamColor)



	draw.DrawNonParsedText(text, "SInfoFont", 10, 55, DankConfig.SecondColor, 0)
	--
end

local function DankMoney()

	local yPos = 120

	if DankConfig.AmmoPanel then

		if DankConfig.AdaptiveAmmoPanel then
			
			if IsValid( DankVar.lPlayer:GetActiveWeapon() ) then
				
				if IsValid( DankVar.lPlayer:GetActiveWeapon() ) and ( (DankVar.lPlayer:GetActiveWeapon().GetMaxClip1 and DankVar.lPlayer:GetActiveWeapon():GetMaxClip1() > 0) or (DankVar.lPlayer:GetActiveWeapon().GetMaxClip2 and DankVar.lPlayer:GetActiveWeapon():GetMaxClip2() > 0) ) then
					
					if DankConfig.WeaponNamePanel then
						
						yPos = 165

					else

						yPos = 80

					end

				else

					yPos = 80

				end

			end

		else

			yPos = 165

		end

		if IsValid( DankVar.lPlayer:GetActiveWeapon() ) then
				
			if IsValid( DankVar.lPlayer:GetActiveWeapon() ) and ( (DankVar.lPlayer:GetActiveWeapon().GetMaxClip1 and DankVar.lPlayer:GetActiveWeapon():GetMaxClip1() > 0) or (DankVar.lPlayer:GetActiveWeapon().GetMaxClip2 and DankVar.lPlayer:GetActiveWeapon():GetMaxClip2() > 0) ) then
					
				if DankConfig.WeaponNamePanel then
						
					yPos = 165

				else

					yPos = 95

				end

			else

				yPos = 95

			end

		end

	else

		yPos = 95

	end

	surface.SetFont("MInfoFont")

	local sal = LocalPlayer():getDarkRPVar( "salary" ) or 0
	local wal = LocalPlayer():getDarkRPVar("money") or 0

	local moneyAmount = string.Comma( wal )

	local salaryAmount = string.Comma( sal )

	local width, height = surface.GetTextSize( string.Comma( wal .. " (" .. "£" .. sal .. ")" ) )

	if DankConfig.UseSWCreds then

		width, height = surface.GetTextSize( string.Comma( wal .. " (" .. "£" .. sal .. ")" ) )
		width = width + 5

	end

	local moneyAmount = string.Comma( moneyAmount )

	if DankConfig.MoneyPanel then

		if DankConfig.Blur then
			
			drawBlur( ScrW() - width - 32, ScrH() - yPos, width + 52, 40, DankConfig.BlurLayers, DankConfig.BlurDensity, DankConfig.BlurAlpha )

		end

		draw.RoundedBox( 0, ScrW() - width - 32, ScrH() - yPos, width + 52, 40, DankConfig.FirstColor )

		surface.SetDrawColor( DankConfig.SecondColor )

		surface.DrawOutlinedRect( ScrW() - width - 30, ScrH() - yPos + 2, width + 30, 36 )

		draw.RoundedBox( 0, ScrW() - 5, ScrH() - yPos, 5, 40, DankConfig.MoneyColor )

		local Moneysymbol = {}
		if DankConfig.UseSWCreds then
			
			local credspr = Material("sw_hud/creditsymbol")
			surface.SetDrawColor( DankConfig.MoneyColor2 )
			surface.SetMaterial( credspr )

			surface.DrawTexturedRect( ScrW() - width - 24, ScrH() - yPos + 11, 16, 16 )
			Moneysymbol = ""

		else

			Moneysymbol = DankConfig.moneySymbol

		end

		draw.SimpleText( Moneysymbol .. moneyAmount .. " (" .. "£" .. salaryAmount .. ")","MInfoFont", ScrW() - 10, ScrH() - yPos + 20, DankConfig.MoneyColor2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		--
	end

end


local function DankAmmo()

	if DankConfig.WeaponNamePanel then
		
		if DankConfig.AdaptiveAmmoPanel then
				
			if IsValid( DankVar.lPlayer:GetActiveWeapon() ) and ( (DankVar.lPlayer:GetActiveWeapon().GetMaxClip1 and DankVar.lPlayer:GetActiveWeapon():GetMaxClip1() > 0) or (DankVar.lPlayer:GetActiveWeapon().GetMaxClip2 and DankVar.lPlayer:GetActiveWeapon():GetMaxClip2() > 0) ) then
				
				yPos = 130

			else

				yPos = 50

			end

		else

			yPos = 140

		end

		if IsValid( DankVar.lPlayer:GetActiveWeapon() ) and ( (DankVar.lPlayer:GetActiveWeapon().GetMaxClip1 and DankVar.lPlayer:GetActiveWeapon():GetMaxClip1() > 0) or (DankVar.lPlayer:GetActiveWeapon().GetMaxClip2 and DankVar.lPlayer:GetActiveWeapon():GetMaxClip2() > 0) ) then
				
			yPos = 130

		else

			yPos = 60

		end

	end

	surface.SetFont( "MInfoFont" )

	if IsValid( LocalPlayer():GetActiveWeapon() ) then

		if LocalPlayer():GetActiveWeapon() == "weapon_physcannon" then
			
			weaponName = "Gravity Gun"

		elseif LocalPlayer():GetActiveWeapon() == "weapon_physgun" then

			weaponName = "Physics Gun"

		else

			weaponName = LocalPlayer():GetActiveWeapon():GetPrintName()

		end

	else

		weaponName = "Invalid"

	end

	local weaponNameWidth, weaponNameHeight = surface.GetTextSize( weaponName )

	if DankConfig.Blur then
		
		if DankConfig.AmmoPanel then

			if DankConfig.AdaptiveAmmoPanel then
			
				if IsValid( DankVar.lPlayer:GetActiveWeapon() ) then
				
					if IsValid( DankVar.lPlayer:GetActiveWeapon() ) and ( (DankVar.lPlayer:GetActiveWeapon().GetMaxClip1 and DankVar.lPlayer:GetActiveWeapon():GetMaxClip1() > 0) or (DankVar.lPlayer:GetActiveWeapon().GetMaxClip2 and DankVar.lPlayer:GetActiveWeapon():GetMaxClip2() > 0) ) then
				
						drawBlur( ScrW() - 200, ScrH() - ( yPos - 50 ), 200, 80, DankConfig.BlurLayers, DankConfig.BlurDensity, DankConfig.BlurAlpha )

					end

				end

			end

		end

		if DankConfig.WeaponNamePanel then
				
			drawBlur( ScrW() - ( weaponNameWidth + 20 ), ScrH() - yPos + 10, weaponNameWidth + 20, 40, DankConfig.BlurLayers, DankConfig.BlurDensity, DankConfig.BlurAlpha )

		end
		
	end

	if DankConfig.WeaponNamePanel then

		draw.RoundedBox( 0, ScrW() - ( weaponNameWidth + 20 ), ScrH() - yPos + 10, weaponNameWidth + 20, 40, DankConfig.FirstColor )

		surface.SetDrawColor( DankConfig.SecondColor )

		surface.DrawOutlinedRect( ScrW() - weaponNameWidth - 18, ScrH() - ( yPos - 12 ), weaponNameWidth + 18, 36 )

		draw.RoundedBox( 0, ScrW() - 5, ScrH() - yPos + 10, 5, 40, DankConfig.AmmoColor )


		draw.SimpleText( weaponName,"MInfoFont", ScrW() - 10, ScrH() - ( yPos - 30 ), DankConfig.SecondColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

	end

	if DankConfig.AmmoPanel then

		if DankConfig.AdaptiveAmmoPanel then
			
			if IsValid( DankVar.lPlayer:GetActiveWeapon() ) then
				
				if IsValid( DankVar.lPlayer:GetActiveWeapon() ) and ( (DankVar.lPlayer:GetActiveWeapon().GetMaxClip1 and DankVar.lPlayer:GetActiveWeapon():GetMaxClip1() > 0) or (DankVar.lPlayer:GetActiveWeapon().GetMaxClip2 and DankVar.lPlayer:GetActiveWeapon():GetMaxClip2() > 0) ) then
				

					if DankConfig.Blur then

						drawBlur( ScrW() - 200, ScrH() - 70, 200, 60, DankConfig.BlurLayers, DankConfig.BlurDensity, DankConfig.BlurAlpha )

					end

					draw.RoundedBox( 0, ScrW() - 200, ScrH() - 90, 200, 80, DankConfig.FirstColor )

					surface.SetDrawColor( DankConfig.SecondColor )

					surface.DrawOutlinedRect( ScrW() - 198, ScrH() - 88, 198, 76 )

					draw.RoundedBox( 0, ScrW() - 5, ScrH() - 90, 5, 80, DankConfig.AmmoColor )

					draw.SimpleText( weaponName,"LInfoFont", ScrW() - 10, ScrH() - ( yPos - 20 ), DankConfig.SecondColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

				end

			end

		else

			if IsValid( DankVar.lPlayer:GetActiveWeapon() ) and ( (DankVar.lPlayer:GetActiveWeapon().GetMaxClip1 and DankVar.lPlayer:GetActiveWeapon():GetMaxClip1() > 0) or (DankVar.lPlayer:GetActiveWeapon().GetMaxClip2 and DankVar.lPlayer:GetActiveWeapon():GetMaxClip2() > 0) ) then

				surface.SetFont( "MInfoFont" )
				local ammoCountSize = DankVar.lPlayer:GetAmmoCount( DankVar.lPlayer:GetActiveWeapon():GetPrimaryAmmoType() )

				local width1, height1 = surface.GetTextSize( ammoCountSize .. "/" .. DankVar.lPlayer:GetActiveWeapon():Clip1() )

				surface.SetFont( "MInfoFont" )
				local width2, height2 = surface.GetTextSize( ammoCountSize .. "/" )

				local secondaryAmmoCount = DankVar.lPlayer:GetAmmoCount( DankVar.lPlayer:GetActiveWeapon():GetPrimaryAmmoType() )
				local primaryAmmoCount = DankVar.lPlayer:GetActiveWeapon():Clip1()

				if DankConfig.Blur then

					drawBlur( ScrW() - width1 - 50, ScrH() - 70, width1 + 50, 60, DankConfig.BlurLayers, DankConfig.BlurDensity, DankConfig.BlurAlpha )

				end

				draw.RoundedBox( 0, ScrW() - width1 - 50, ScrH() - 70, width1 + 50, 60, DankConfig.FirstColor )

				surface.SetDrawColor( DankConfig.SecondColor )

				surface.DrawOutlinedRect( ScrW() - width1 - 48, ScrH() - 68, width1 + 48, 56 )

				draw.RoundedBox( 0, ScrW() - 5, ScrH() - 70, 5, 60, DankConfig.AmmoColor )

				draw.SimpleText( secondaryAmmoCount,"MInfoFont", ScrW() - 15, ScrH() - 35, DankConfig.SecondColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				draw.DrawText( "/", "LInfoFont", ScrW() - width2 - 15, ScrH() - 60, DankConfig.SecondColor, TEXT_ALIGN_CENTER)
				draw.SimpleText( primaryAmmoCount,"LInfoFont", ScrW() - 27 - width2, ScrH() - 40, DankConfig.SecondColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

			end

		end

	end

end

local function DankWantedLicense()

	if DankConfig.AdaptiveLicensePanel then
		
		if LocalPlayer():getDarkRPVar( "HasGunlicense" ) then
			draw.RoundedBox( 0, 450, ScrH() - 50, 50, 50, DankConfig.FirstColor )

			if DankConfig.Blur then

				drawBlur( 450, ScrH() - 50, 50, 50, DankConfig.BlurLayers, DankConfig.BlurDensity, DankConfig.BlurAlpha )

			end

			if LocalPlayer():getDarkRPVar( "HasGunlicense" ) then
				
				licenseIndicator = Color( 255, 255, 255, 255 )

			else

				licenseIndicator = Color( 75, 75, 75, 255 )

			end

			local licensespr = Material("sw_hud/gunlicense")
			surface.SetDrawColor( licenseIndicator )
			surface.SetMaterial( licensespr )

			surface.DrawTexturedRect( 458, ScrH() - 41, 32, 32 )

			surface.SetDrawColor( DankConfig.SecondColor )
			surface.DrawOutlinedRect( 452, ScrH() - 48, 46, 56 )

			draw.RoundedBox( 0, 450, ScrH() - 3, 50, 3, DankVar.TeamColor )
		end

	else

		if DankConfig.Blur then

			drawBlur( 450, ScrH() - 50, 50, 50, DankConfig.BlurLayers, DankConfig.BlurDensity, DankConfig.BlurAlpha )

		end

		draw.RoundedBox( 0, 450, ScrH() - 50, 50, 50, DankConfig.FirstColor )

		if LocalPlayer():getDarkRPVar( "HasGunlicense" ) then
				
			licenseIndicator = Color( 255, 255, 255, 255 )

		else

			licenseIndicator = Color( 75, 75, 75, 255 )

		end

		local licensespr = Material("sw_hud/gunlicense")
		surface.SetDrawColor( licenseIndicator )
		surface.SetMaterial( licensespr )

		surface.DrawTexturedRect( 458, ScrH() - 41, 32, 32 )

		surface.SetDrawColor( DankConfig.SecondColor )
		surface.DrawOutlinedRect( 452, ScrH() - 48, 46, 56 )

		draw.RoundedBox( 0, 450, ScrH() - 3, 50, 3, DankVar.TeamColor )

	end

	if DankConfig.WantedAlert then

		surface.SetFont( "MInfoFont" )

		local reasonText = LocalPlayer():getDarkRPVar( "wantedReason" ) or ""

		local reasonwidth, reasonheight = surface.GetTextSize( reasonText )

		if DankConfig.AdaptiveWantedAlert then
			
			if DankVar.lPlayer:getDarkRPVar("wanted") then

				draw.RoundedBox( 0, ScrW() / 2 - 100, 100, 200, 3, DankConfig.WantedColor)

				draw.SimpleText( "You are wanted!","MInfoFont", (ScrW() / 2), 75, DankConfig.WantedColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

				draw.SimpleText( LocalPlayer():getDarkRPVar( "wantedReason" ),"SInfoFont", (ScrW() / 2), 120, DankConfig.WantedColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			end

		else

			surface.SetFont( "SInfoFont" )

			if DankVar.lPlayer:getDarkRPVar("wanted") then

				Dankwidth, Dankheight = surface.GetTextSize( DankConfig.WantedText )
				Danktext = DankConfig.WantedText

			else

				Dankwidth, Dankheight = surface.GetTextSize( DankConfig.UnwantedText )
				Danktext = DankConfig.UnwantedText

			end

			if DankConfig.Blur then

				drawBlur( (ScrW() / 2) - (Dankwidth / 2) - 10, 50, Dankwidth + 20, 50, DankConfig.BlurLayers, DankConfig.BlurDensity, DankConfig.BlurAlpha )

			end

			draw.RoundedBox( 0, (ScrW() / 2) - (Dankwidth / 2) - 10, 50, Dankwidth + 20, 50, DankConfig.FirstColor)

			surface.SetDrawColor( DankConfig.SecondColor )
			surface.DrawOutlinedRect( (ScrW() / 2) - (Dankwidth / 2) - 8, 50, Dankwidth + 16, 48 )

			draw.RoundedBox( 0, (ScrW() / 2) - (Dankwidth / 2) - 10, 50, Dankwidth + 20, 4, DankConfig.WantedColor )

			draw.SimpleText( Danktext,"SInfoFont", (ScrW() / 2), 75, DankConfig.SecondColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)


		end

	end

end

/*---------------------------------------------------------------------------
HUD ConVars
---------------------------------------------------------------------------*/
local ConVars = {}
local HUDWidth
local HUDHeight

local Color = Color
local cvars = cvars
local DarkRP = DarkRP
local CurTime = CurTime
local draw = draw
local GetConVar = GetConVar
local IsValid = IsValid
local Lerp = Lerp
local localplayer
local math = math
local pairs = pairs
local ScrW, ScrH = ScrW, ScrH
local SortedPairs = SortedPairs
local string = string
local surface = surface
local table = table
local timer = timer
local tostring = tostring

CreateClientConVar("weaponhud", 0, true, false)

local function ReloadConVars()
	ConVars = {
		background = {0,0,0,100},
		Healthbackground = {0,0,0,200},
		Healthforeground = {140,0,0,180},
		HealthText = {255,255,255,200},
		Job1 = {0,0,150,200},
		Job2 = {0,0,0,255},
		salary1 = {0,150,0,200},
		salary2 = {0,0,0,255}
	}

	for name, Colour in pairs(ConVars) do
		ConVars[name] = {}
		for num, rgb in SortedPairs(Colour) do
			local CVar = GetConVar(name..num) or CreateClientConVar(name..num, rgb, true, false)
			table.insert(ConVars[name], CVar:GetInt())

			if not cvars.GetConVarCallbacks(name..num, false) then
				cvars.AddChangeCallback(name..num, function() timer.Simple(0,ReloadConVars) end)
			end
		end
		ConVars[name] = Color(unpack(ConVars[name]))
	end


	HUDWidth = (GetConVar("HudW") or  CreateClientConVar("HudW", 240, true, false)):GetInt()
	HUDHeight = (GetConVar("HudH") or CreateClientConVar("HudH", 115, true, false)):GetInt()

	if not cvars.GetConVarCallbacks("HudW", false) and not cvars.GetConVarCallbacks("HudH", false) then
		cvars.AddChangeCallback("HudW", function() timer.Simple(0,ReloadConVars) end)
		cvars.AddChangeCallback("HudH", function() timer.Simple(0,ReloadConVars) end)
	end
end
ReloadConVars()

local Scrw, Scrh, RelativeX, RelativeY


local function DankVoiceChat()

	local VoiceChatTexture = surface.GetTextureID("sw_hud/microphone")

	if localplayer.DRPIsTalking then
		local chbxX, chboxY = chat.GetChatBoxPos()

		surface.SetTexture( VoiceChatTexture )
		surface.SetDrawColor( DankConfig.TertiaryColor )
		surface.DrawTexturedRect( ScrW() - 200, chboxY, 96, 96, backwards )

	end
end

/*---------------------------------------------------------------------------
HUD Seperate Elements
---------------------------------------------------------------------------*/

local function DankCompass(ply)

	if DankConfig.Compass then

		

	end

end

local Arrested = function() end

usermessage.Hook("GotArrested", function(msg)

	local StartArrested = CurTime()
    local ArrestedUntil = msg:ReadFloat()

    surface.SetFont( "MInfoFont" )
    local width, height = surface.GetTextSize( DankConfig.JailedMSG )

    local time = string.FormattedTime( ArrestedUntil - (CurTime() - StartArrested), "%02i:%02i" )

    -- math.ceil((ArrestedUntil - (CurTime() - StartArrested)) * 1 / game.GetTimeScale())
 
    Arrested = function()

        if CurTime() - StartArrested <= ArrestedUntil and localplayer:getDarkRPVar("Arrested") then

	        draw.SimpleText( DankConfig.JailedMSG, "MInfoFont", ScrW() / 2, 185, DankConfig.SecondFloor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	        draw.SimpleText( "Time Remaining: " .. math.ceil((ArrestedUntil - (CurTime() - StartArrested)) * 1 / game.GetTimeScale()) .. " seconds", "SInfoFont", ScrW() / 2, 215, DankConfig.SecondFloor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	        draw.RoundedBox( 0, ScrW() / 2 - ( width / 2 ) - 15, 200, width + 30, 3, DankConfig.FirstColor )
        
        elseif not localplayer:getDarkRPVar("Arrested") then

            Arrested = function() end

        end

    end

end)

local AdminTell = function() end

usermessage.Hook("AdminTell", function(msg)

	timer.Destroy("DarkRP_AdminTell")

	local Message = msg:ReadString()

	AdminTell = function()

		draw.RoundedBox(4, 10, 10, ScrW() - 20, 100, colors.darkblack)

		draw.DrawNonParsedText(DarkRP.getPhrase("listen_up"), "GModToolName", ScrW() / 2 + 10, 10, colors.white, 1)

		draw.DrawNonParsedText(Message, "ChatFont", ScrW() / 2 + 10, 80, colors.brightred, 1)

	end

	timer.Create("DarkRP_AdminTell", 10, 1, function()

		AdminTell = function() end

	end)

end)

/*---------------------------------------------------------------------------
The Entity display: draw HUD information about entities
---------------------------------------------------------------------------*/
local function DrawEntityDisplay()

	local tr = LocalPlayer():GetEyeTrace()

	if IsDarkRP && IsValid(tr.Entity) and tr.Entity:isKeysOwnable() and tr.Entity:GetPos():Distance(LocalPlayer():GetPos()) < 200 then

		tr.Entity:drawOwnableInfo()

	end

end

/*---------------------------------------------------------------------------
Drawing death notices
---------------------------------------------------------------------------*/
function GAMEMODE:DrawDeathNotice(x, y)
	if not GAMEMODE.Config.showdeaths then return end
	self.BaseClass:DrawDeathNotice(x, y)
end

/*---------------------------------------------------------------------------
Display notifications
---------------------------------------------------------------------------*/
local function DisplayNotify(msg)
	local txt = msg:ReadString()
	GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
	surface.PlaySound("buttons/lightswitch2.wav")

	-- Log to client console
	print(txt)
end
usermessage.Hook("_Notify", DisplayNotify)

/*---------------------------------------------------------------------------
Remove some elements from the HUD in favour of the DarkRP HUD
---------------------------------------------------------------------------*/
local hide = {
CHudHealth = true,
CHudBattery = true,
CHudAmmo = true,
CHudSecondaryAmmo = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
if ( hide[ name ] ) then return false end

-- Don't return anything here, it may break other addons that rely on this hook.
end )

/*---------------------------------------------------------------------------
Disable players' names popping up when looking at them
---------------------------------------------------------------------------*/
function GAMEMODE:HUDDrawTargetID()
    return false
end

/*---------------------------------------------------------------------------
Actual HUDPaint hook
---------------------------------------------------------------------------*/
function DrawHUD()
	localplayer = localplayer and IsValid(localplayer) and localplayer or LocalPlayer()
	if not IsValid(localplayer) then return end
	

	if IsValid( LocalPlayer():GetActiveWeapon() ) and IsValid( LocalPlayer() ) then

		-- Custom
		DankVars()
		Base()
		NameDisplay()
		DankAgenda()
		HealthArmorBar()
		DankMoney()
		DankAmmo()
		DankWantedLicense()
		DankJobBar()
		DankLockdown()
		DankVoiceChat()
		DankCompass()

	end

	if LocalPlayer():getDarkRPVar( "Arrested" ) then
		
		Arrested()

	end
	
	-- Default
	AdminTell()
	
end

hook.Add("PostPlayerDraw", "DankPlayerInfoDraw", function( ply )

	local shootPos = LocalPlayer():GetShootPos()
	local aimVec = LocalPlayer():GetAimVector()
	local hisPos = ply:GetShootPos()
	local pos = hisPos - shootPos
	local unitPos = pos:GetNormalized()

	if ( !IsValid( ply ) ) then return end
	if ( ply == LocalPlayer() ) then return end -- Don't draw a name when the player is you
	if ( !ply:Alive() ) then return end -- Check if the player is alive

	local Distance = LocalPlayer():GetPos():Distance( ply:GetPos() ) --Get the distance between you and the player

	if ( Distance < 300 ) and unitPos:Dot(aimVec) > 0.92 then --If the distance is less than 1000 units, it will draw the name

		local offset = Vector( 0, 0, 85 )
		local ang = LocalPlayer():EyeAngles()
		local pos = ply:GetPos() + offset + ang:Up()

		ang:RotateAroundAxis( ang:Forward(), 90 )
		ang:RotateAroundAxis( ang:Right(), 90 )

		local yPos = 330

		surface.SetFont( "MInfoFont" )

		local namewidth, nameheight = surface.GetTextSize( ply:Name() )
		local jobwidth, jobheight = surface.GetTextSize( ply:getDarkRPVar( "job" ) or "" )

		local otherName = ply:Name()
		local otherJob = ply:getDarkRPVar("job") or ""
		local otherHealth = ply:Health()
		local otherArmor = ply:Armor()

		if not ply:getDarkRPVar("wanted") and not ply:getDarkRPVar("Arrested") then

			if DankConfig.OthersNames then

				local yPos = 280

				cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.1 )

					draw.RoundedBox( 0, 150, yPos, namewidth + 20, 40, DankConfig.FirstColor )

					surface.SetDrawColor( DankConfig.SecondColor )
					surface.DrawOutlinedRect( 150, yPos + 2, namewidth + 18, 36 )

					draw.RoundedBox( 0, 150, yPos, 5, 40, team.GetColor( ply:Team() ))

					draw.SimpleText( otherName, "MInfoFont", 160, yPos + 20, DankConfig.SecondColor,TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

				cam.End3D2D()
			end
			
			if DankConfig.OthersJob then

				local yPos = 330

				cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.1 )

					draw.RoundedBox( 0, 150, yPos, jobwidth + 20, 40, DankConfig.FirstColor )

					surface.SetDrawColor( DankConfig.SecondColor )
					surface.DrawOutlinedRect( 150, yPos + 2, jobwidth + 18, 36 )

					draw.RoundedBox( 0, 150, yPos, 5, 40, team.GetColor( ply:Team() ))

					draw.SimpleText( otherJob, "MInfoFont", 160, yPos + 20, DankConfig.SecondColor,TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

				cam.End3D2D()
			end

			if DankConfig.OthersLicense then

				if ply:getDarkRPVar( "HasGunlicense" ) then

					local yPos = 330

					cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.1 )

						draw.RoundedBox( 0, -230, yPos, 64, 64, DankConfig.FirstColor )

						surface.SetDrawColor( DankConfig.SecondColor )
						surface.DrawOutlinedRect( -228, yPos + 2, 60, 60 )

						draw.RoundedBox( 0, -170, yPos, 5, 64, team.GetColor( ply:Team() ))

						local licensespr = Material("sw_hud/gunlicense")
						surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
						surface.SetMaterial( licensespr )

						surface.DrawTexturedRect( -224, yPos + 6, 52, 52 )

					cam.End3D2D()

				end
				
			end

			if DankConfig.OthersHealth then

				local yPos = 380

				if not DankConfig.OthersJob then

					yPos = 330

				end

				if ply:Health() > ply:GetMaxHealth() then
					
					health = 100

				else

					health = ply:GetMaxHealth()

				end

				cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.1 )

					draw.RoundedBox( 0, 150, yPos, 180, 40, DankConfig.FirstColor )
					draw.RoundedBox( 0, 155, yPos + 5, ( ply:Health() / health ) * 170, 30, DankConfig.HealthColor )

					surface.SetDrawColor( DankConfig.SecondColor )
					surface.DrawOutlinedRect( 150, yPos + 2, 178, 36 )

					draw.RoundedBox( 0, 150, yPos, 5, 40, DankConfig.HealthColor2 )

					draw.SimpleText( string.Comma( otherHealth ), "MInfoFont", 240, yPos + 20, DankConfig.SecondColor,TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)


				cam.End3D2D()
			end

			if DankConfig.OthersArmor then

				if DankConfig.AdaptiveOthersArmor then
					
					if ply:Armor() > 0 then

						local yPos = 430

						if not DankConfig.OthersHealth then
							
							if not DankConfig.OthersJob then
								
								yPos = 330

							else

								yPos = 380

							end

						elseif not DankConfig.OthersJob then
							
							yPos = 380

						else

							yPos = 430

						end

						cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.1 )

							draw.RoundedBox( 0, 150, yPos, 150, 40, DankConfig.FirstColor )
							draw.RoundedBox( 0, 155, yPos + 5, ( ply:Armor() / DankConfig.MaxArmor ) * 140, 30, DankConfig.ArmorColor )

							surface.SetDrawColor( DankConfig.SecondColor )
							surface.DrawOutlinedRect( 150, yPos + 2, 148, 36 )

							draw.RoundedBox( 0, 150, yPos, 5, 40, DankConfig.ArmorColor2 )

							draw.SimpleText( string.Comma( otherArmor ), "MInfoFont", 220, yPos + 20, DankConfig.SecondColor,TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

						cam.End3D2D()

					end

				else
				
					local yPos = 430

					if not DankConfig.OthersHealth then
							
						if not DankConfig.OthersJob then
								
							yPos = 330

						else

							yPos = 380

						end

					elseif not DankConfig.OthersJob then
							
						yPos = 380

					else

						yPos = 430

					end

					cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.1 )

						draw.RoundedBox( 0, 150, yPos, 150, 40, DankConfig.FirstColor )
						draw.RoundedBox( 0, 155, yPos + 5, ( ply:Armor() / DankConfig.MaxArmor ) * 140, 30, DankConfig.ArmorColor )

						surface.SetDrawColor( DankConfig.SecondColor )
						surface.DrawOutlinedRect( 150, yPos + 2, 148, 36 )

						draw.RoundedBox( 0, 150, yPos, 5, 40, DankConfig.ArmorColor2 )

						draw.SimpleText( string.Comma( otherArmor ), "MInfoFont", 220, yPos + 20, DankConfig.SecondColor,TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

					cam.End3D2D()

				end

			end

		elseif ply:getDarkRPVar( "wanted" ) then

			if DankConfig.OthersWanted then

				local wantedwidth, wantedheight = surface.GetTextSize( ply:getDarkRPVar( "wantedReason" ) )

				local yPos = 0

				cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.2 )

					draw.RoundedBox( 0, -75, yPos, 150, 2, DankConfig.WantedColor )

					draw.SimpleText( "Wanted!", "LInfoFont", 0, yPos - 20, DankConfig.WantedColor,TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

					draw.SimpleText( ply:getDarkRPVar("wantedReason"), "MInfoFont", 0, yPos + 20, DankConfig.WantedColor,TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				cam.End3D2D()
			end

		else

			if DankConfig.OthersArrested then

				surface.SetFont( "MInfoFont" )

				local width, height = surface.GetTextSize( DankConfig.ArrestedTopMSG )
				local yPos = 0

				cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.2 )

					draw.RoundedBox( 0, 0 - ( width / 2 ) - 5, yPos, width + 10, 2, DankConfig.FirstColor )

					draw.SimpleText( DankConfig.ArrestedTopMSG, "MInfoFont", 0, yPos - 15, DankConfig.SecondColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

					--draw.SimpleText( "Time Remaining: ", "MInfoFont", 0, yPos + 20, DankConfig.WantedColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				cam.End3D2D()

			end
			
		end

	end


end)

hook.Add("HUDPaint", "DrawHUD", DrawHUD)

hook.Add("HUDDrawDoorData","Door_Draw_3D_Data",Draw3DDoor2)