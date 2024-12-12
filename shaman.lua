ConROC.Shaman = {};

local ConROC_Shaman, ids = ...;
local currentSpecName;
local currentSpecID;

function ConROC:EnableRotationModule()
	self.Description = 'Shaman';
	self.NextSpell = ConROC.Shaman.Damage;

	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self:RegisterEvent('PLAYER_TOTEM_UPDATE');
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self.lastSpellId = 0;
end

function ConROC:EnableDefenseModule()
	self.NextDef = ConROC.Shaman.Defense;
end

function ConROC:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConROC:SpecUpdate()
	currentSpecName = ConROC:currentSpec()
    currentSpecID = ConROC:currentSpec("ID")

	if currentSpecName then
	   ConROC:Print(self.Colors.Info .. "Current spec:", self.Colors.Success ..  currentSpecName)
	else
	   ConROC:Print(self.Colors.Error .. "You do not currently have a spec.")
	end
end

ConROC:SpecUpdate()

ConROC.totemVariables = {
    eeTotemEXP = 0,
    feTotemEXP = 0,
    cTotemEXP = 0,
    ebTotemEXP = 0,
    fResistTotemEXP = 0,
    fnTotemEXP = 0,
    ftTotemEXP = 0,
    frResistTotemEXP = 0,
    grTotemEXP = 0,
    hStreamEXP = 0,
    mTotemEXP = 0,
    mSpringTotemEXP = 0,
    mTideTotemEXP = 0,
    nResistTotemEXP = 0,
    searTotemEXP = 0,
    senTotemEXP = 0,
    scTotemEXP = 0,
    sSkinTotemEXP = 0,
    soeTotemEXP = 0,
    tTotemEXP = 0,
    wfTotemEXP = 0,
    woaTotemEXP = 0,
    -- Add more variables as needed
}
function ConROC:PLAYER_TOTEM_UPDATE()
    if ConROC:CheckBox(ConROC_SM_Option_Totems) then
    	local totems = ids.Player_Totems;
        for i = 1, 4 do
            local haveTotem, totemName, startTime, duration, icon = GetTotemInfo(i)
            if haveTotem and totemName ~= nil then
                for _, totem in ipairs(totems) do
                    if string.find(totemName, totem[1]) then
                        ConROC.totemVariables[totem[2]] = startTime + duration
                        break  -- No need to continue checking other totems
                    end
                end
            end
        end
    end
end

local Racial, Spec, Ability, Rank, Ele_Talent, Enh_Talent, Resto_Talent, Runes, Buff, Debuff = ids.Racial, ids.Spec, ids.Ability, ids.Rank, ids.Elemental_Talent, ids.Enhancement_Talent, ids.Restoration_Talent, ids.Runes, ids.Buff, ids.Debuff;
local _tickerVar = 10;
local _mhP = nil;
local _ohP = nil;
local _mhEnchID, _mhTexture;
local _ohEnchID, _ohTexture;
local _mhAlpha = 1;
local _ohAlpha = 1;

--Info
local _Player_Level = UnitLevel("player");
local _Player_Percent_Health = ConROC:PercentHealth('player');
local _is_PvP = ConROC:IsPvP();
local _in_combat = UnitAffectingCombat('player');
local _party_size = GetNumGroupMembers();
local _is_PC = UnitPlayerControlled("target");
local _is_Enemy = ConROC:TarHostile();
local _Target_Health = UnitHealth('target');
local _Target_Percent_Health = ConROC:PercentHealth('target');

--Resources
local _Mana, _Mana_Max = ConROC:PlayerPower('Mana');

--Conditions
local _Queue = 0;
local _is__is_moving = ConROC:PlayerSpeed();
--local _enemies_in_melee, _target_in_melee = ConROC:Targets("Melee");
--local _enemies_in_10yrds, _target_in_10yrds = ConROC:Targets("10");
--local _enemies_in_25yrds, _target_in_25yrds = ConROC:Targets("25");
--local _enemies_in_40yrds, _target_in_40yrds = ConROC:Targets("40");
local _can_Execute = _Target_Percent_Health < 20;

--Racials
local _Berserking, _Berserking_RDY = _, _;

function ConROC:Stats()
	_Player_Level = UnitLevel("player");
	_Player_Percent_Health = ConROC:PercentHealth('player');
	_is_PvP = ConROC:IsPvP();
	_in_combat = UnitAffectingCombat('player');
	_party_size = GetNumGroupMembers();
	_is_PC = UnitPlayerControlled("target");
	_is_Enemy = ConROC:TarHostile();
	_Target_Health = UnitHealth('target');
	_Target_Percent_Health = ConROC:PercentHealth('target');

	_Mana, _Mana_Max = ConROC:PlayerPower('Mana');

	_Queue = 0;
	_is_moving = ConROC:PlayerSpeed();
--	_enemies_in_melee, _target_in_melee = ConRO:Targets("Melee");
--	_enemies_in_10yrds, _target_in_10yrds = ConRO:Targets("10");
--	_enemies_in_25yrds, _target_in_25yrds = ConRO:Targets("25");
--	_enemies_in_40yrds, _target_in_40yrds = ConRO:Targets("40");
	_can_Execute = _Target_Percent_Health < 20;

	_Berserking, _Berserking_RDY = ConROC:AbilityReady(Racial.Berserking, timeShift);
end

function ConROC:PLAYER_TALENT_UPDATE()
	ConROC:SpecUpdate();
    ConROC:closeSpellmenu();
end

function ConROC.Shaman.Damage(_, timeShift, currentSpell, gcd)
	ConROC:UpdateSpellID();
	ConROC:Stats();

--Abilities	
	local _LightningBolt, _LightningBolt_RDY = ConROC:AbilityReady(Ability.LightningBolt, timeShift);
	local _ChainLightning, _ChainLightning_RDY = ConROC:AbilityReady(Ability.ChainLightning, timeShift);
	local _EarthShock, _EarthShock_RDY = ConROC:AbilityReady(Ability.EarthShock, timeShift);
	local _EarthShockR1, _EarthShockR1_RDY = ConROC:AbilityReady(Rank.EarthShockRank1, timeShift)
	local _FlameShock, _FlameShock_RDY = ConROC:AbilityReady(Ability.FlameShock, timeShift);
		local _FlameShock_DEBUFF = ConROC:TargetAura(_FlameShock, timeShift);
	local _FrostShock, _FrostShock_RDY = ConROC:AbilityReady(Ability.FrostShock, timeShift);
        local _FrostShock_DEBUFF = ConROC:TargetAura(_FrostShock, timeShift);
	local _ElementalMastery, _ElementalMastery_RDY = ConROC:AbilityReady(Ability.ElementalMastery, timeShift);
	local _Purge, _Purge_RDY = ConROC:AbilityReady(Ability.Purge, timeShift);
    local _Stormstrike, _Stormstrike_RDY = ConROC:AbilityReady(Ability.Stormstrike, timeShift);

    local _FlametongueWeapon, _FlametongueWeapon_RDY = ConROC:AbilityReady(Ability.FlametongueWeapon, timeShift);
    local _FlametongueWeaponDR, _FlametongueWeaponDR_RDY = ConROC:AbilityReady(Ability.FlametongueWeaponDR, timeShift);
    local _FrostbrandWeapon, _FrostbrandWeapon_RDY = ConROC:AbilityReady(Ability.FrostbrandWeapon, timeShift);
    local _RockbiterWeapon, _RockbiterWeapon_RDY = ConROC:AbilityReady(Ability.RockbiterWeapon, timeShift);
    local _WindfuryWeapon, _WindfuryWeapon_RDY = ConROC:AbilityReady(Ability.WindfuryWeapon, timeShift);

--Totems
	local _SearingTotem, _SearingTotem_RDY = ConROC:AbilityReady(Ability.SearingTotem, timeShift);
	local _FireNovaTotem, _FireNovaTotem_RDY = ConROC:AbilityReady(Ability.FireNovaTotem, timeShift);

--Totems durations
	local _FireNovaTotem_DUR = ConROC.totemVariables.fnTotemEXP - GetTime();
	local _SearingTotem_DUR = ConROC.totemVariables.searTotemEXP - GetTime();

	local _Clearcasting_BUFF = ConROC:Aura(Buff.Clearcasting, timeShift);

--Runes
    local _LavaBurst, _LavaBurst_RDY = ConROC:AbilityReady(Runes.LavaBurst, timeShift);
    local _LavaLash, _LavaLash_RDY = ConROC:AbilityReady(Runes.LavaLash, timeShift);
    local _MoltenBlast, _MoltenBlast_RDY = ConROC:AbilityReady(Runes.MoltenBlast, timeShift);
    local _ShamanisticRage, _ShamanisticRage_RDY = ConROC:AbilityReady(Runes.ShamanisticRage, timeShift);

--Conditions
    local resting = IsResting()
    local mounted = IsMounted()
    local onVehicle = UnitHasVehicleUI("player")
	local hasMHEnch, _, mhCharges, mhEnchID, hasOHEnch, _, ohCharges, ohEnchId = GetWeaponEnchantInfo();
	local tarInMelee, inMelee = ConROC:Targets("Melee");
	local tarInAoe = 0;

	if ConROC_AoEButton:IsVisible() and IsSpellKnown(_ChainLightning) then
		tarInAoe = ConROC:Targets(_ChainLightning);
	end

--Indicators
    ConROC:AbilityInterrupt(_EarthShockR1, ConROC:Interrupt() and _EarthShockR1)

--Warnings
    if not (mounted or onVehicle or resting) and not _in_combat then
    	_tickerVar = _tickerVar + 1
        local hasMainHandEnchant,
            mainHandExpiration,
            mainHandCharges,
            mainHandEnchantID,
            hasOffHandEnchant,
            offHandExpiration,
            offHandCharges,
            offHandEnchantId = GetWeaponEnchantInfo()
        if mainHandExpiration then
        	mhExp = mainHandExpiration / 1000
        else
            mhExp = 0
        end
        if offHandExpiration then
            ohExp = offHandExpiration / 1000
        else
            ohExp = 0
        end

        if _tickerVar >= 1 then
            if ConROC:CheckBox(ConROC_SM_Option_Imbue) then

                if ConROC:CheckBox(ConROC_SM_MH_FlametongueWeapon) and IsSpellKnown(_FlametongueWeapon) then
                	ConROC:ChooseImbue(_FlametongueWeapon, true, mainHandEnchantID); -- spellID, isMainhand, enchantID
                end

                if ConROC:CheckBox(ConROC_SM_MH_FrostbrandWeapon) and IsSpellKnown(_FrostbrandWeapon) then
                    ConROC:ChooseImbue(_FrostbrandWeapon, true, mainHandEnchantID); -- spellID, isMainhand, enchantID
                end

                if ConROC:CheckBox(ConROC_SM_MH_RockbiterWeapon) and IsSpellKnown(_RockbiterWeapon) then
                	ConROC:ChooseImbue(_RockbiterWeapon, true, mainHandEnchantID); -- spellID, isMainhand, enchantID
                end
                if ConROC:CheckBox(ConROC_SM_MH_WindfuryWeapon) and IsSpellKnown(_WindfuryWeapon) then
                    ConROC:ChooseImbue(_WindfuryWeapon, true, mainHandEnchantID); -- spellID, isMainhand, enchantID
                end
                if offHandType() then
                	if ConROC:CheckBox(ConROC_SM_OH_FlametongueWeapon) and IsSpellKnown(_FlametongueWeapon) then
    	                if ConROC:CheckBox(ConROC_SM_MH_FlametongueWeapon) then
    	                	ConROC:ChooseImbue(_FlametongueWeaponDR, false, offHandEnchantId); -- spellID, isMainhand, enchantID
    	                else
    	                	ConROC:ChooseImbue(_FlametongueWeapon, false, offHandEnchantId); -- spellID, isMainhand, enchantID
    	                end
    	            end

    	            if ConROC:CheckBox(ConROC_SM_OH_FrostbrandWeapon) and IsSpellKnown(_FrostbrandWeapon) then
    	                ConROC:ChooseImbue(_FrostbrandWeapon, false, offHandEnchantId); -- spellID, isMainhand, enchantID
    	            end

    	            if ConROC:CheckBox(ConROC_SM_OH_RockbiterWeapon) and IsSpellKnown(_RockbiterWeapon) then
    	                ConROC:ChooseImbue(_RockbiterWeapon, false, offHandEnchantId); -- spellID, isMainhand, enchantID
    	            end
    	            if ConROC:CheckBox(ConROC_SM_OH_WindfuryWeapon) and IsSpellKnown(_WindfuryWeapon) then
    	                ConROC:ChooseImbue(_WindfuryWeapon, false, offHandEnchantId); -- spellID, isMainhand, enchantID
    	            end
    			else
    				_ohP = "none"
                    _ohEnchID = false
    				_ohTexture = "0,0,0,0";	
    	        end
                if ConROC:CheckBox(ConROC_SM_MH_None) then
                    _mhP = "none"
                    _mhEnchID = false
    				_mhTexture = "0,0,0,0";	
                end
                if ConROC:CheckBox(ConROC_SM_OH_None) then
                    _ohP = "none"
                    _ohEnchID = false
    				_ohTexture = "0,0,0,0";	
                end
            end
            _tickerVar = 0

            if _mhP == nil then
                _mhP = "none"
                _mhEnchID = false
    			_mhTexture = "0,0,0,0";	
            end
            if _ohP == nil then
                _ohp = "none"
                _ohEnchID = false
    			_ohTexture = "0,0,0,0";	
            end

            if (mainHandEnchantID ~= _mhEnchID or offHandEnchantId ~= _ohEnchID) and (_mhP ~= "none" or _ohP ~= "none") then
            if ConROC:CheckBox(ConROC_SM_Option_Imbue) then --and not (resting or _in_combat or mounted or onVehicle) then
                ConROC:ApplyImbue(_mhP, _mhTexture, _ohP, _ohTexture)
                if not ConROCApplyImbueFrame:IsShown() then
                    ConROCApplyImbueFrame:Show()
                end
            end
        end
        if ConROCApplyImbueFrame:IsShown() then
            if not ConROC:CheckBox(ConROC_SM_Option_Imbue) or
                --(resting or mounted or onVehicle and not _in_combat) or 
                (_mhP == "none" and _ohP == "none") or
                    (mainHandEnchantID == _mhEnchID and
                        offHandEnchantId == _ohEnchID) or
                    (mainHandEnchantID == _mhEnchID and _ohP == "none") or
                    (offHandEnchantId == _ohEnchID and _mhP == "none")
             then
                ConROCApplyImbueFrame:Hide()
            end
        end
        end
    else
        if ConROCApplyImbueFrame:IsShown() then ConROCApplyImbueFrame:Hide() end
    end
--]]
	--Rotations

    --[[if ConROC.Seasons.IsSoD then
        if _Player_Level < 10 or ConROC:CheckBox(ConROC_SM_Role_Caster) then
            if _EarthShock_RDY and (_Clearcasting_BUFF or ((_Target_Percent_Health <= 5 and ConROC:Raidmob()) or (_Target_Percent_Health <= 20 and not ConROC:Raidmob())) or not IsSpellKnown(_FlameShock) ) then
                return _EarthShock;
            end
            if _FlameShock_RDY and not _FlameShock_DEBUFF then
                return _FlameShock;
            end
            if _LavaBurst_RDY and _FlameShock_DEBUFF then
                return _LavaBurst;
            end
            if ConROC_AoEButton:IsVisible() then
                if _ChainLightning_RDY then
                    return _ChainLightning
                end
            end
            if _LightningBolt_RDY then
                return _LightningBolt;
            end
        end
        if _Player_Level < 10 or ConROC:CheckBox(ConROC_SM_Role_Melee) then
            if _EarthShock_RDY and (_Clearcasting_BUFF or ((_Target_Percent_Health <= 5 and ConROC:Raidmob()) or (_Target_Percent_Health <= 20 and not ConROC:Raidmob())) or not IsSpellKnown(_FlameShock) ) then
                return _EarthShock;
            end
            if _FlameShock_RDY and not _FlameShock_DEBUFF then
                return _FlameShock;
            end
            if _LavaLash_RDY then
                return _LavaLash
            end
            if _MoltenBlast_RDY then
                return _MoltenBlast
            end
        end
        if _Player_Level < 10 or ConROC:CheckBox(ConROC_SM_Role_Tank) then            
            if _FlameShock_RDY and not _FlameShock_DEBUFF then
                return _FlameShock;
            end
            if _MoltenBlast_RDY then
                return _MoltenBlast
            end
            if _FrostShock_RDY and _FlameShock_DEBUFF and not _FrostShock_DEBUFF then
                return _FlameShock;
            end           
        end
        return nil
    end
    --not SoD]]
	if currentSpecID == ids.Spec.Enhancement then
		if _LightningBolt_RDY and not inMelee then
			return _LightningBolt;
		end
		if _Stormstrike_RDY and inMelee then
				return _Stormstrike;
		end
		if _EarthShock_RDY and (_Clearcasting_BUFF or ((_Target_Percent_Health <= 5 and ConROC:Raidmob()) or (_Target_Percent_Health <= 20 and not ConROC:Raidmob()))) then
            return _EarthShock;
        end
        if _FlameShock_RDY and not _FlameShock_DEBUFF then
            return _FlameShock;
        end        
        if _EarthShockR1_RDY and (ConROC:TalentChosen(Spec.Elemental, Ele_Talent.ElementalFocus) or ConROC:TalentChosen(Spec.Elemental, Ele_Talent.ElementalDevastation)) then
            return _EarthShockR1;
        end
        if not IsAddOnLoaded("TotemTimers") or ConROC:CheckBox(ConROC_SM_Option_Totems) then --only if not the addon TotemTimers is loaded
            if _SearingTotem_RDY and _SearingTotem_DUR < 0.1 then
                return _SearingTotem;
            end
            --[[
            if (_SearingTotem_RDY or mTotemRDY) and (_SearingTotem_DUR < 0.1 or mTotemDUR < 0.1) then
                if _SearingTotem_RDY and _SearingTotem_DUR < 0.1 then
                    return _SearingTotem;
                elseif mTotemRDY and mTotemDUR < 0.1 and tarInMelee > 2 then
                    return _MagmaTotem;
                end
            end
            --]]
        end
		return nil
	elseif currentSpecID == ids.Spec.Elemental then
        if not IsAddOnLoaded("TotemTimers") or ConROC:CheckBox(ConROC_SM_Option_Totems) then --only if not the addon TotemTimers is loaded
            if (not ConROC_AoEButton:IsVisible() or (not inMelee or tarInMelee < 2)) and _SearingTotem_RDY and _SearingTotem_DUR < 0.1 then
                return _SearingTotem;
            end
            if (ConROC_AoEButton:IsVisible() or tarInMelee > 2) and _FireNovaTotem_RDY and _FireNovaTotem_DUR < 0.1 then
                return _FireNovaTotem;
            end
        end
		if _ElementalMastery_RDY  and _in_combat then
			return _ElementalMastery;
		end
		if _EarthShock_RDY and (_Clearcasting_BUFF or ((_Target_Percent_Health <= 5 and ConROC:Raidmob()) or (_Target_Percent_Health <= 20 and not ConROC:Raidmob()))) then
            return _EarthShock;
        end
        if _FlameShock_RDY and not _FlameShock_DEBUFF then
            return _FlameShock;
        end        
        if _EarthShockR1_RDY and (ConROC:TalentChosen(Spec.Elemental, Ele_Talent.ElementalFocus) or ConROC:TalentChosen(Spec.Elemental, Ele_Talent.ElementalDevastation)) then
            return _EarthShockR1;
        end
		if ConROC_AoEButton:IsVisible() and _ChainLightning_RDY and not _is_moving then
			return _ChainLightning;
		end
		if _LightningBolt_RDY and not _is_moving then
			return _LightningBolt;
		end
		if _FrostShock_RDY and _FlameShock_DEBUFF and _is_moving then
			return _FrostShock;
		end
		if _FrostShock_RDY and _FlameShock_DEBUFF then
			return _FrostShock;
		end
		return nil
	else
		if _ChainLightning_RDY and _Clearcasting_BUFF then
			return _ChainLightning;
		end

		if _LightningBolt_RDY and not inMelee then
			return _LightningBolt;
		end

		if inMelee then
			if _Stormstrike_RDY then
				return _Stormstrike;
			end

			if _EarthShock_RDY and (_Clearcasting_BUFF or ((_Target_Percent_Health <= 5 and ConROC:Raidmob()) or (_Target_Percent_Health <= 20 and not ConROC:Raidmob()))) then
				return _EarthShock;
			end

			if _EarthShockR1_RDY and (ConROC:TalentChosen(Spec.Elemental, Ele_Talent.ElementalFocus) or ConROC:TalentChosen(Spec.Elemental, Ele_Talent.ElementalDevastation)) then
				return _EarthShockR1;
			end
		end
		return nil;
	end
end

function ConROC.Shaman.Defense(_, timeShift, currentSpell, gcd)
	ConROC:UpdateSpellID();
	ConROC:Stats();

--Abilities	
	local _LightningShield, _LightningShield_RDY = ConROC:AbilityReady(Ability.LightningShield, timeShift);
		local _LightningShield_BUFF = ConROC:Aura(_LightningShield, timeShift);

	local _, wShieldRDY = ConROC:AbilityReady(Runes.WaterShield, timeShift);

--Indicators	

--Warnings

--Rotations	
	if _LightningShield_RDY and not _LightningShield_BUFF and (not IsAddOnLoaded("TotemTimers") or ConROC:CheckBox(ConROC_SM_Option_Shields)) then
		return _LightningShield;
	end
return nil;
end

local function getEnchantmentID(spellID)
    local spellName = GetSpellInfo(spellID)
    local subtext = GetSpellSubtext(spellID)
    print(spellName);
    print(spellName.."("..subtext..")");
    -- Check if spellName is in the table
    local enchantmentRow = ids.wpnEnchantments[spellName]

    if enchantmentRow then
        -- Extract rank as a number
        local rank = tonumber(subtext and subtext:match("(%d+)"))

        -- Check if rank is in the row
        if rank and enchantmentRow[rank] then
            return enchantmentRow[rank]
        else
            print("Invalid rank or rank not found in the row.")
        end
    else
        print("Spell not found in the enchantments table.")
    end
end

-- Test the function with your spell ID
--[[local enchantmentID = getEnchantmentID(Enh_Ability.FlametongueWeaponRank9)

if enchantmentID then
    print("Enchantment ID:", enchantmentID)
end--]]

function ConROC:ChooseImbue(spellID, isMainhand, enchantID)
	if isMainhand then
		local spellName = GetSpellInfo(spellID);
        local subtext = GetSpellSubtext(spellID);
        local rank = tonumber(subtext and subtext:match("(%d+)"));
        _mhEnchID = ids.wpnEnchantments[spellName][rank];
        _mhTexture = GetSpellTexture(spellID);
        if enchantID == _mhEnchID then
            _mhAlpha = .5;
        end
        _mhP = (spellName.."("..subtext..")");
        if enchantID ~= _mhEnchID then
            _mhAlpha = 1;
            ImbueErrorMessage(spellName, "mainhand");
        end
	else
		local spellName = GetSpellInfo(spellID);
        local subtext = GetSpellSubtext(spellID);
        local rank = tonumber(subtext and subtext:match("(%d+)"));
        _ohEnchID = ids.wpnEnchantments[spellName][rank];
        _ohTexture = GetSpellTexture(spellID);
        if enchantID == _ohEnchID then
            _ohAlpha = .5;
        end
    	_ohP = (spellName.."("..subtext..")");
        if enchantID ~= _ohEnchID then
            _ohAlpha = 1;
            ImbueErrorMessage(spellName, "offhand");
        end
	end
end

function ConROC:ApplyImbue(mhImbue, mhTexture, ohImbue, ohTexture)
    local _, Class, classId = UnitClass("player")
    local Color = RAID_CLASS_COLORS[Class]
    if mhImbue ~= ("none" or nil) then
        local mhName = mhImbue;
       	local mhCast = "/cast [@none]"
       	if string.find(mhName, "Rockbiter") then
       		mhCast = "/cast"
       	end
        ConROCMainHandBGFrame:Show();
        --ConROCMainHandFrame:Show();
        if _mhAlpha == 1 then
		    ConROCMainHandFrame:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square","ADD");
		    ConROCMainHandFrame:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress","ADD");
            ConROCMainHandFrame:SetAttribute("macrotext", mhCast .. " " .. mhName .. ";\n/use 16;\n/click StaticPopup1Button1;")
        else
            ConROCMainHandFrame:SetAttribute("macrotext", "")
        end
        ConROCMainHandBGFrame:SetNormalTexture(mhTexture);
    else
        ConROCMainHandBGFrame:Hide();
        ConROCMainHandBGFrame:SetNormalTexture("");
    	ConROCMainHandFrame:SetHighlightTexture("", "MOD");
    	ConROCMainHandFrame:SetPushedTexture("", "MOD");
        ConROCMainHandFrame:SetAttribute("macrotext", "")
    end
    ConROCMainHandBGFrame:SetAlpha(_mhAlpha);
    ConROCMainHandFrame:SetAlpha(_mhAlpha);

    if ohImbue ~= "none" then
    	local ohName = ohImbue;
       	local ohCast = "/cast [@none]"
       	if string.find(ohName, "Rockbiter") then
       		ohCast = "/cast"
       	end
    	ConROCOffHandBGFrame:Show();
        --ConROCOffHandFrame:Show();
        if _ohAlpha == 1 and _ohImbue ~= "empty" then
            ConROCOffHandFrame:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square","ADD");
		    ConROCOffHandFrame:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress","ADD");
            ConROCOffHandFrame:SetAttribute("macrotext", ohCast .. " " .. ohName .. ";\n/use 17;\n/click StaticPopup1Button1;")
        else
        	ConROCOffHandFrame:SetAttribute("macrotext", "")
        end
        ConROCOffHandBGFrame:SetNormalTexture(ohTexture);
    else
        ConROCOffHandBGFrame:Hide();
        ConROCOffHandBGFrame:SetNormalTexture("");
    	ConROCOffHandFrame:SetHighlightTexture("", "MOD");
    	ConROCOffHandFrame:SetPushedTexture("", "MOD");
        ConROCOffHandFrame:SetAttribute("macrotext", "")
    end
    ConROCOffHandBGFrame:SetAlpha(_ohAlpha);
    ConROCOffHandFrame:SetAlpha(_ohAlpha);
end

function ConROC:CreateImbueFrame()
    local _, Class, classId = UnitClass("player")
    local Color = RAID_CLASS_COLORS[Class]
    local mhName = ""
    --change to get texture from spell
    local mhTexture = nil --select(5, GetItemInfoInstant(_InstantPoison.id))
    local ohName = ""
    local ohTexture = nil --select(5, GetItemInfoInstant(_DeadlyPoison.id))
    local frame = CreateFrame("Frame", "ConROCApplyImbueFrame", UIParent, "BackdropTemplate")
    RegisterStateDriver(frame, "visibility", "[combat] hide; nil")
    frame:SetFrameStrata("MEDIUM")
    frame:SetFrameLevel("4")
    frame:SetSize(128 + 8, 64 + 8)

    frame:SetBackdrop(
        {
            bgFile = "Interface\\CHATFRAME\\CHATFRAMEBACKGROUND",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 8,
            edgeSize = 20,
            insets = {left = 4, right = 4, top = 4, bottom = 4}
        }
    )
    frame:SetBackdropColor(0, 0, 0, .75)
    frame:SetBackdropBorderColor(Color.r, Color.g, Color.b, .75)
    frame:SetPoint("TOP", UIErrorsFrame, "BOTTOM", 0, -20)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetClampedToScreen(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetClipsChildren(false)
    frame:SetScript(
        "OnDragStart",
        function(self)
            if ConROC.db.profile.unlockWindow then
                if (IsAltKeyDown()) then
                    frame:Start_is_moving()
                end
            end
        end
    )
    frame:SetScript("OnDragStop", frame.Stop_is_movingOrSizing)
    frame:SetScript(
        "OnEnter",
        function(self)
            frame:SetAlpha(1)
        end
    )
    frame:SetScript(
        "OnLeave",
        function(self)
            if not MouseIsOver(frame) then
                if ConROC.db.profile._Hide_Spellmenu then
                    frame:SetAlpha(0)
                else
                    frame:SetAlpha(1)
                end
            end
        end
    )
    local dragFrame = CreateFrame("Frame", "ConROCApplyPoisonFrame_DragFrame", frame)
    dragFrame:SetFrameStrata('MEDIUM')
    dragFrame:SetFrameLevel('8')
    dragFrame:SetSize(26, 26)
    dragFrame:SetAlpha(1)
    dragFrame:SetPoint("BOTTOMLEFT", frame, "TOPRIGHT", -16, -16)

    -- Background texture
    local background = dragFrame:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    background:SetTexture("Interface\\AddOns\\ConROC\\images\\move_icon")
    background:SetDesaturated(true)
    background:SetVertexColor(Color.r, Color.g, Color.b)
    dragFrame.background = background

    if ConROC.db.profile.unlockWindow then
        dragFrame:Show();
    else
        dragFrame:Hide();
    end

    dragFrame:SetScript("OnMouseDown", function (self, otbutton, up)
        if ConROC.db.profile.unlockWindow then
                frame:Start_is_moving()
        end
    end)

    dragFrame:SetScript("OnMouseUp", function (self, otbutton, up)
        if ConROC.db.profile.unlockWindow then
            frame:Stop_is_movingOrSizing();
        end
    end)
    local MhBgFrame = CreateFrame("BUTTON", "ConROCMainHandBGFrame", frame, "SecureActionButtonTemplate");
    local OhBgFrame = CreateFrame("BUTTON", "ConROCOffHandBGFrame", frame, "SecureActionButtonTemplate");
    MhBgFrame:ClearAllPoints();
    MhBgFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -4);
    MhBgFrame:SetFrameStrata("MEDIUM");
    MhBgFrame:SetFrameLevel("5");
    MhBgFrame:SetSize(64, 64);
    MhBgFrame:SetAlpha(1);
    MhBgFrame:Show();
    MhBgFrame:RegisterForClicks();
    OhBgFrame:ClearAllPoints();
    OhBgFrame:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4);
    OhBgFrame:SetFrameStrata("MEDIUM");
    OhBgFrame:SetFrameLevel("5");
    OhBgFrame:SetSize(64, 64);
    OhBgFrame:SetAlpha(1);
    OhBgFrame:Show();
    OhBgFrame:RegisterForClicks();

    local secureMhButton = CreateFrame("BUTTON", "ConROCMainHandFrame", frame, "SecureActionButtonTemplate")
    secureMhButton:ClearAllPoints()
    secureMhButton:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -4)
    secureMhButton:SetFrameStrata("MEDIUM")
    secureMhButton:SetFrameLevel("6")
    secureMhButton:SetSize(64, 64)
    secureMhButton:SetAlpha(1)
    local mhTitleText = secureMhButton:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    mhTitleText:SetParent(secureMhButton)
    mhTitleText:SetText("MH")
    mhTitleText:SetFont("Fonts\\ARIALN.TTF", 20)
    mhTitleText:SetShadowColor(0, 0, 0, 1)
    mhTitleText:SetShadowOffset(2, -2)
    mhTitleText:SetPoint("CENTER", secureMhButton, "CENTER", 0, 0)
    secureMhButton:SetAttribute("type1", "macro")
    secureMhButton:SetAttribute("macrotext", "/s zomg a left click! - Main hand")

    secureMhButton:RegisterForClicks("AnyDown")
    secureMhButton:Show()

    local secureOhButton = CreateFrame("BUTTON", "ConROCOffHandFrame", frame, "SecureActionButtonTemplate")
    secureOhButton:ClearAllPoints()
    secureOhButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4)
    secureOhButton:SetFrameStrata("MEDIUM")
    secureOhButton:SetFrameLevel("6")
    secureOhButton:SetSize(64, 64)
    secureOhButton:SetAlpha(1)
    local ohTitleText = secureOhButton:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    ohTitleText:SetText("OH")
    ohTitleText:SetFont("Fonts\\ARIALN.TTF", 20)
    ohTitleText:SetShadowColor(0, 0, 0, 1)
    ohTitleText:SetShadowOffset(2, -2)
    ohTitleText:SetPoint("CENTER", secureOhButton, "CENTER", 0, 0)
    secureOhButton:SetAttribute("type1", "macro")
    secureOhButton:SetAttribute("macrotext", "/s zomg a left click! - Off hand")

    secureOhButton:RegisterForClicks("AnyDown")
    secureOhButton:Show();

    frame:Hide()
end

ConROC:CreateImbueFrame()

function ImbueErrorMessage(_pName, _hand)
    ConROC:Warnings("Put " .. _pName .. " on your " .. _hand .. " weapon!!!", true);
end

function offHandType()
    if select(2,GetInventoryItemLink("player", 17)) then
	   local itemType = select(6, GetItemInfo(GetInventoryItemLink("player", 17)))
        local isWeapon = itemType == "Weapon"
	   return isWeapon
    else
        return false
    end
end
