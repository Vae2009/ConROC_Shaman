local printTalentsMode = false

-- Slash command for printing talent tree with talent names and ID numbers
SLASH_CONROCPRINTTALENTS1 = "/ConROCPT"
SlashCmdList["CONROCPRINTTALENTS"] = function()
    printTalentsMode = not printTalentsMode
    ConROC:PopulateTalentIDs()
end

ConROC.Shaman = {};

local ConROC_Shaman, ids = ...;
local optionMaxIds = ...;
local currentSpecName;
local currentSpecID;
local _tickerVar = 10;
local _mhP = nil;
local _ohP = nil;
local _mhEnchID, _mhTexture;
local _ohEnchID, _ohTexture;
local _mhAlpha = 1;
local _ohAlpha = 1;

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

function ConROC:EnableDefenseModule()
	self.NextDef = ConROC.Shaman.Defense;
end

function ConROC:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConROC:PopulateTalentIDs()
    local numTabs = GetNumTalentTabs()
    
    for tabIndex = 1, numTabs do
        local tabName = GetTalentTabInfo(tabIndex)
        tabName = string.gsub(tabName, "[^%w]", "") .. "_Talent" -- Remove spaces from tab name
        print("ids."..tabName.." = {")
        local numTalents = GetNumTalents(tabIndex)

        for talentIndex = 1, numTalents do
            local name, _, _, _, _ = GetTalentInfo(tabIndex, talentIndex)

            if name then
                local talentID = string.gsub(name, "[^%w]", "") -- Remove spaces from talent name
                    print(talentID .." = ", talentIndex ..",")
            end
        end
        print("}")
    end
end

local Racial, Spec, Ele_Ability, Ele_Talent, Enh_Ability, Enh_Talent, Resto_Ability, Resto_Talent, Player_Buff, Player_Debuff, Target_Debuff = ids.Racial, ids.Spec, ids.Ele_Ability, ids.Elemental_Talent, ids.Enh_Ability, ids.Enhancement_Talent, ids.Resto_Ability, ids.Restoration_Talent, ids.Player_Buff, ids.Player_Debuff, ids.Target_Debuff;

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

--Ranks
--Elemental
local _ChainLightning = Ele_Ability.ChainLightningRank1;
local _EarthShock = Ele_Ability.EarthShockRank1;
local _ElementalMastery = Ele_Ability.ElementalMastery;
local _FireNovaTotem = Ele_Ability.FireNovaTotemRank1;
local _FlameShock = Ele_Ability.FlameShockRank1;
local _FrostShock = Ele_Ability.FrostShockRank1;
local _LightningBolt = Ele_Ability.LightningBoltRank1;
local _MagmaTotem = Ele_Ability.MagmaTotemRank1;
local _Purge = Ele_Ability.PurgeRank1;
local _SearingTotem = Ele_Ability.SearingTotemRank1;	
local _StoneclawTotem = Ele_Ability.StoneclawTotemRank1;

--Enhancement
local _FireResistanceTotem = Enh_Ability.FireResistanceTotemRank1;
local _FlametongueTotem = Enh_Ability.FlametongueTotemRank1;
local _FlametongueWeapon = Enh_Ability.FlametongueWeaponRank1;
local _FlametongueWeaponDR = Enh_Ability.FlametongueWeaponRank1;
local _FrostResistanceTotem = Enh_Ability.FrostResistanceTotemRank1;
local _FrostbrandWeapon = Enh_Ability.FrostbrandWeaponRank1;
local _GraceofAirTotem = Enh_Ability.GraceofAirTotemRank1;
local _LightningShield = Enh_Ability.LightningShieldRank1;
local _NatureResistanceTotem = Enh_Ability.NatureResistanceTotemRank1;
local _RockbiterWeapon = Enh_Ability.RockbiterWeaponRank1;
local _StoneskinTotem = Enh_Ability.StoneskinTotemRank1;
local _StrengthofEarthTotem = Enh_Ability.StrengthofEarthTotemRank1;
local _WindfuryTotem = Enh_Ability.WindfuryTotemRank1;
local _WindfuryWeapon = Enh_Ability.WindfuryWeaponRank1;
local _WindwallTotem = Enh_Ability.WindwallTotemRank1;

--Restoration
local _AncestralSpirit = Resto_Ability.AncestralSpiritRank1;
local _ChainHeal = Resto_Ability.ChainHealRank1;
local _LesserHealingWave = Resto_Ability.LesserHealingWaveRank1;
local _HealingStreamTotem = Resto_Ability.HealingStreamTotemRank1;
local _HealingWave = Resto_Ability.HealingWaveRank1;
local _ManaSpringTotem = Resto_Ability.ManaSpringTotemRank1;
local _ManaTideTotem = Resto_Ability.ManaTideTotemRank1;

--Runes
local _LavaBurst = ids.Runes.LavaBurst;
local _LavaLash = ids.Runes.LavaLash;
local _MoltenBlast = ids.Runes.MoltenBlast;
local _ShamanisticRage = ids.Runes.ShamanisticRage;
local _WaterShield = ids.Runes.WaterShield;

function ConROC:UpdateSpellID()
--Ranks
--Elemental
if IsSpellKnown(Ele_Ability.ChainLightningRank4) then _ChainLightning = Ele_Ability.ChainLightningRank4;
elseif IsSpellKnown(Ele_Ability.ChainLightningRank3) then _ChainLightning = Ele_Ability.ChainLightningRank3;
elseif IsSpellKnown(Ele_Ability.ChainLightningRank2) then _ChainLightning = Ele_Ability.ChainLightningRank2; end	

if IsSpellKnown(Ele_Ability.EarthShockRank7) then _EarthShock = Ele_Ability.EarthShockRank7;
elseif IsSpellKnown(Ele_Ability.EarthShockRank6) then _EarthShock = Ele_Ability.EarthShockRank6;
elseif IsSpellKnown(Ele_Ability.EarthShockRank5) then _EarthShock = Ele_Ability.EarthShockRank5;
elseif IsSpellKnown(Ele_Ability.EarthShockRank4) then _EarthShock = Ele_Ability.EarthShockRank4;
elseif IsSpellKnown(Ele_Ability.EarthShockRank3) then _EarthShock = Ele_Ability.EarthShockRank3;
elseif IsSpellKnown(Ele_Ability.EarthShockRank2) then _EarthShock = Ele_Ability.EarthShockRank2; end	

if IsSpellKnown(Ele_Ability.FireNovaTotemRank5) then _FireNovaTotem = Ele_Ability.FireNovaTotemRank5;
elseif IsSpellKnown(Ele_Ability.FireNovaTotemRank4) then _FireNovaTotem = Ele_Ability.FireNovaTotemRank4;
elseif IsSpellKnown(Ele_Ability.FireNovaTotemRank3) then _FireNovaTotem = Ele_Ability.FireNovaTotemRank3;
elseif IsSpellKnown(Ele_Ability.FireNovaTotemRank2) then _FireNovaTotem = Ele_Ability.FireNovaTotemRank2; end   

if IsSpellKnown(Ele_Ability.FlameShockRank6) then _FlameShock = Ele_Ability.FlameShockRank6;
elseif IsSpellKnown(Ele_Ability.FlameShockRank5) then _FlameShock = Ele_Ability.FlameShockRank5;
elseif IsSpellKnown(Ele_Ability.FlameShockRank4) then _FlameShock = Ele_Ability.FlameShockRank4;
elseif IsSpellKnown(Ele_Ability.FlameShockRank3) then _FlameShock = Ele_Ability.FlameShockRank3;
elseif IsSpellKnown(Ele_Ability.FlameShockRank2) then _FlameShock = Ele_Ability.FlameShockRank2; end	

if IsSpellKnown(Ele_Ability.FrostShockRank4) then _FrostShock = Ele_Ability.FrostShockRank4;
elseif IsSpellKnown(Ele_Ability.FrostShockRank3) then _FrostShock = Ele_Ability.FrostShockRank3;
elseif IsSpellKnown(Ele_Ability.FrostShockRank2) then _FrostShock = Ele_Ability.FrostShockRank2; end
	
if IsSpellKnown(Ele_Ability.LightningBoltRank10) then _LightningBolt = Ele_Ability.LightningBoltRank10;
elseif IsSpellKnown(Ele_Ability.LightningBoltRank9) then _LightningBolt = Ele_Ability.LightningBoltRank9;
elseif IsSpellKnown(Ele_Ability.LightningBoltRank8) then _LightningBolt = Ele_Ability.LightningBoltRank8;
elseif IsSpellKnown(Ele_Ability.LightningBoltRank7) then _LightningBolt = Ele_Ability.LightningBoltRank7;
elseif IsSpellKnown(Ele_Ability.LightningBoltRank6) then _LightningBolt = Ele_Ability.LightningBoltRank6;
elseif IsSpellKnown(Ele_Ability.LightningBoltRank5) then _LightningBolt = Ele_Ability.LightningBoltRank5;
elseif IsSpellKnown(Ele_Ability.LightningBoltRank4) then _LightningBolt = Ele_Ability.LightningBoltRank4;
elseif IsSpellKnown(Ele_Ability.LightningBoltRank3) then _LightningBolt = Ele_Ability.LightningBoltRank3;
elseif IsSpellKnown(Ele_Ability.LightningBoltRank2) then _LightningBolt = Ele_Ability.LightningBoltRank2; end

if IsSpellKnown(Ele_Ability.MagmaTotemRank5) then _MagmaTotem = Ele_Ability.MagmaTotemRank5;
elseif IsSpellKnown(Ele_Ability.MagmaTotemRank4) then _MagmaTotem = Ele_Ability.MagmaTotemRank4;
elseif IsSpellKnown(Ele_Ability.MagmaTotemRank3) then _MagmaTotem = Ele_Ability.MagmaTotemRank3;
elseif IsSpellKnown(Ele_Ability.MagmaTotemRank2) then _MagmaTotem = Ele_Ability.MagmaTotemRank2; end

if IsSpellKnown(Ele_Ability.PurgeRank2) then _Purge = Ele_Ability.PurgeRank2; end

if IsSpellKnown(Ele_Ability.SearingTotemRank6) then _SearingTotem = Ele_Ability.SearingTotemRank6;
elseif IsSpellKnown(Ele_Ability.SearingTotemRank5) then _SearingTotem = Ele_Ability.SearingTotemRank5;
elseif IsSpellKnown(Ele_Ability.SearingTotemRank4) then _SearingTotem = Ele_Ability.SearingTotemRank4;
elseif IsSpellKnown(Ele_Ability.SearingTotemRank3) then _SearingTotem = Ele_Ability.SearingTotemRank3;
elseif IsSpellKnown(Ele_Ability.SearingTotemRank2) then _SearingTotem = Ele_Ability.SearingTotemRank2; end

if IsSpellKnown(Ele_Ability.StoneclawTotemRank6) then _StoneclawTotem = Ele_Ability.StoneclawTotemRank6;
elseif IsSpellKnown(Ele_Ability.StoneclawTotemRank5) then _StoneclawTotem = Ele_Ability.StoneclawTotemRank5;
elseif IsSpellKnown(Ele_Ability.StoneclawTotemRank4) then _StoneclawTotem = Ele_Ability.StoneclawTotemRank4;
elseif IsSpellKnown(Ele_Ability.StoneclawTotemRank3) then _StoneclawTotem = Ele_Ability.StoneclawTotemRank3;
elseif IsSpellKnown(Ele_Ability.StoneclawTotemRank2) then _StoneclawTotem = Ele_Ability.StoneclawTotemRank2; end

--Enhancement
if IsSpellKnown(Enh_Ability.FireResistanceTotemRank3) then _FireResistanceTotem = Enh_Ability.FireResistanceTotemRank3;
elseif IsSpellKnown(Enh_Ability.FireResistanceTotemRank2) then _FireResistanceTotem = Enh_Ability.FireResistanceTotemRank2; end

if IsSpellKnown(Enh_Ability.FlametongueTotemRank4) then _FlametongueTotem = Enh_Ability.FlametongueTotemRank4;
elseif IsSpellKnown(Enh_Ability.FlametongueTotemRank3) then _FlametongueTotem = Enh_Ability.FlametongueTotemRank3;
elseif IsSpellKnown(Enh_Ability.FlametongueTotemRank2) then _FlametongueTotem = Enh_Ability.FlametongueTotemRank2; end

if IsSpellKnown(Enh_Ability.FlametongueWeaponRank6) then _FlametongueWeapon = Enh_Ability.FlametongueWeaponRank6;
elseif IsSpellKnown(Enh_Ability.FlametongueWeaponRank5) then _FlametongueWeapon = Enh_Ability.FlametongueWeaponRank5;
elseif IsSpellKnown(Enh_Ability.FlametongueWeaponRank4) then _FlametongueWeapon = Enh_Ability.FlametongueWeaponRank4;
elseif IsSpellKnown(Enh_Ability.FlametongueWeaponRank3) then _FlametongueWeapon = Enh_Ability.FlametongueWeaponRank3;
elseif IsSpellKnown(Enh_Ability.FlametongueWeaponRank2) then _FlametongueWeapon = Enh_Ability.FlametongueWeaponRank2; end

if IsSpellKnown(Enh_Ability.FlametongueWeaponRank6) then _FlametongueWeaponDR = Enh_Ability.FlametongueWeaponRank5;
elseif IsSpellKnown(Enh_Ability.FlametongueWeaponRank5) then _FlametongueWeaponDR = Enh_Ability.FlametongueWeaponRank4;
elseif IsSpellKnown(Enh_Ability.FlametongueWeaponRank4) then _FlametongueWeaponDR = Enh_Ability.FlametongueWeaponRank3;
elseif IsSpellKnown(Enh_Ability.FlametongueWeaponRank3) then _FlametongueWeaponDR = Enh_Ability.FlametongueWeaponRank2;
elseif IsSpellKnown(Enh_Ability.FlametongueWeaponRank2) then _FlametongueWeaponDR = Enh_Ability.FlametongueWeaponRank1; end

if IsSpellKnown(Enh_Ability.FrostResistanceTotemRank3) then _FrostResistanceTotem = Enh_Ability.FrostResistanceTotemRank3;
elseif IsSpellKnown(Enh_Ability.FrostResistanceTotemRank2) then _FrostResistanceTotem = Enh_Ability.FrostResistanceTotemRank2; end	

if IsSpellKnown(Enh_Ability.FrostbrandWeaponRank5) then _FrostbrandWeapon = Enh_Ability.FrostbrandWeaponRank5;
elseif IsSpellKnown(Enh_Ability.FrostbrandWeaponRank4) then _FrostbrandWeapon = Enh_Ability.FrostbrandWeaponRank4;
elseif IsSpellKnown(Enh_Ability.FrostbrandWeaponRank3) then _FrostbrandWeapon = Enh_Ability.FrostbrandWeaponRank3;
elseif IsSpellKnown(Enh_Ability.FrostbrandWeaponRank2) then _FrostbrandWeapon = Enh_Ability.FrostbrandWeaponRank2; end

if IsSpellKnown(Enh_Ability.GraceofAirTotemRank2) then _GraceofAirTotem = Enh_Ability.GraceofAirTotemRank2; end

if IsSpellKnown(Enh_Ability.LightningShieldRank7) then _LightningShield = Enh_Ability.LightningShieldRank7;
elseif IsSpellKnown(Enh_Ability.LightningShieldRank6) then _LightningShield = Enh_Ability.LightningShieldRank6;
elseif IsSpellKnown(Enh_Ability.LightningShieldRank5) then _LightningShield = Enh_Ability.LightningShieldRank5;
elseif IsSpellKnown(Enh_Ability.LightningShieldRank4) then _LightningShield = Enh_Ability.LightningShieldRank4;
elseif IsSpellKnown(Enh_Ability.LightningShieldRank3) then _LightningShield = Enh_Ability.LightningShieldRank3;
elseif IsSpellKnown(Enh_Ability.LightningShieldRank2) then _LightningShield = Enh_Ability.LightningShieldRank2; end

if IsSpellKnown(Enh_Ability.NatureResistanceTotemRank3) then _NatureResistanceTotem = Enh_Ability.NatureResistanceTotemRank3;
elseif IsSpellKnown(Enh_Ability.NatureResistanceTotemRank2) then _NatureResistanceTotem = Enh_Ability.NatureResistanceTotemRank2; end

if IsSpellKnown(Enh_Ability.RockbiterWeaponRank7) then _RockbiterWeapon = Enh_Ability.RockbiterWeaponRank7;
elseif IsSpellKnown(Enh_Ability.RockbiterWeaponRank6) then _RockbiterWeapon = Enh_Ability.RockbiterWeaponRank6;
elseif IsSpellKnown(Enh_Ability.RockbiterWeaponRank5) then _RockbiterWeapon = Enh_Ability.RockbiterWeaponRank5;
elseif IsSpellKnown(Enh_Ability.RockbiterWeaponRank4) then _RockbiterWeapon = Enh_Ability.RockbiterWeaponRank4;
elseif IsSpellKnown(Enh_Ability.RockbiterWeaponRank3) then _RockbiterWeapon = Enh_Ability.RockbiterWeaponRank3;
elseif IsSpellKnown(Enh_Ability.RockbiterWeaponRank2) then _RockbiterWeapon = Enh_Ability.RockbiterWeaponRank2; end

if IsSpellKnown(Enh_Ability.StoneskinTotemRank6) then _StoneskinTotem = Enh_Ability.StoneskinTotemRank6;
elseif IsSpellKnown(Enh_Ability.StoneskinTotemRank5) then _StoneskinTotem = Enh_Ability.StoneskinTotemRank5;
elseif IsSpellKnown(Enh_Ability.StoneskinTotemRank4) then _StoneskinTotem = Enh_Ability.StoneskinTotemRank4;
elseif IsSpellKnown(Enh_Ability.StoneskinTotemRank3) then _StoneskinTotem = Enh_Ability.StoneskinTotemRank3;
elseif IsSpellKnown(Enh_Ability.StoneskinTotemRank2) then _StoneskinTotem = Enh_Ability.StoneskinTotemRank2; end

if IsSpellKnown(Enh_Ability.StrengthofEarthTotemRank5) then _StrengthofEarthTotem = Enh_Ability.StrengthofEarthTotemRank5;
elseif IsSpellKnown(Enh_Ability.StrengthofEarthTotemRank4) then _StrengthofEarthTotem = Enh_Ability.StrengthofEarthTotemRank4;
elseif IsSpellKnown(Enh_Ability.StrengthofEarthTotemRank3) then _StrengthofEarthTotem = Enh_Ability.StrengthofEarthTotemRank3;
elseif IsSpellKnown(Enh_Ability.StrengthofEarthTotemRank2) then _StrengthofEarthTotem = Enh_Ability.StrengthofEarthTotemRank2; end

if IsSpellKnown(Enh_Ability.WindfuryTotemRank3) then _WindfuryTotem = Enh_Ability.WindfuryTotemRank3;
elseif IsSpellKnown(Enh_Ability.WindfuryTotemRank2) then _WindfuryTotem = Enh_Ability.WindfuryTotemRank2; end

if IsSpellKnown(Enh_Ability.WindfuryWeaponRank4) then _WindfuryWeapon = Enh_Ability.WindfuryWeaponRank4;
elseif IsSpellKnown(Enh_Ability.WindfuryWeaponRank3) then _WindfuryWeapon = Enh_Ability.WindfuryWeaponRank3;
elseif IsSpellKnown(Enh_Ability.WindfuryWeaponRank2) then _WindfuryWeapon = Enh_Ability.WindfuryWeaponRank2; end

if IsSpellKnown(Enh_Ability.WindwallTotemRank3) then _WindwallTotem = Enh_Ability.WindwallTotemRank3;
elseif IsSpellKnown(Enh_Ability.WindwallTotemRank2) then _WindwallTotem = Enh_Ability.WindwallTotemRank2; end

--Restoration
if IsSpellKnown(Resto_Ability.AncestralSpiritRank5) then _AncestralSpirit = Resto_Ability.AncestralSpiritRank5;
elseif IsSpellKnown(Resto_Ability.AncestralSpiritRank4) then _AncestralSpirit = Resto_Ability.AncestralSpiritRank4;
elseif IsSpellKnown(Resto_Ability.AncestralSpiritRank3) then _AncestralSpirit = Resto_Ability.AncestralSpiritRank3;
elseif IsSpellKnown(Resto_Ability.AncestralSpiritRank2) then _AncestralSpirit = Resto_Ability.AncestralSpiritRank2; end

if IsSpellKnown(Resto_Ability.ChainHealRank3) then _ChainHeal = Resto_Ability.ChainHealRank3;
elseif IsSpellKnown(Resto_Ability.ChainHealRank2) then _ChainHeal = Resto_Ability.ChainHealRank2; end
--[[
if IsSpellKnown(Resto_Ability.EarthlivingWeaponRank6) then _EarthlivingWeapon = Resto_Ability.EarthlivingWeaponRank6;
elseif IsSpellKnown(Resto_Ability.EarthlivingWeaponRank5) then _EarthlivingWeapon = Resto_Ability.EarthlivingWeaponRank5;
elseif IsSpellKnown(Resto_Ability.EarthlivingWeaponRank4) then _EarthlivingWeapon = Resto_Ability.EarthlivingWeaponRank4;
elseif IsSpellKnown(Resto_Ability.EarthlivingWeaponRank3) then _EarthlivingWeapon = Resto_Ability.EarthlivingWeaponRank3;
elseif IsSpellKnown(Resto_Ability.EarthlivingWeaponRank2) then _EarthlivingWeapon = Resto_Ability.EarthlivingWeaponRank2; end
--]]
if IsSpellKnown(Resto_Ability.LesserHealingWaveRank6) then _LesserHealingWave = Resto_Ability.LesserHealingWaveRank6;
elseif IsSpellKnown(Resto_Ability.LesserHealingWaveRank5) then _LesserHealingWave = Resto_Ability.LesserHealingWaveRank5;
elseif IsSpellKnown(Resto_Ability.LesserHealingWaveRank4) then _LesserHealingWave = Resto_Ability.LesserHealingWaveRank4;
elseif IsSpellKnown(Resto_Ability.LesserHealingWaveRank3) then _LesserHealingWave = Resto_Ability.LesserHealingWaveRank3;
elseif IsSpellKnown(Resto_Ability.LesserHealingWaveRank2) then _LesserHealingWave = Resto_Ability.LesserHealingWaveRank2; end

if IsSpellKnown(Resto_Ability.HealingStreamTotemRank5) then _HealingStreamTotem = Resto_Ability.HealingStreamTotemRank5;
elseif IsSpellKnown(Resto_Ability.HealingStreamTotemRank4) then _HealingStreamTotem = Resto_Ability.HealingStreamTotemRank4;
elseif IsSpellKnown(Resto_Ability.HealingStreamTotemRank3) then _HealingStreamTotem = Resto_Ability.HealingStreamTotemRank3;
elseif IsSpellKnown(Resto_Ability.HealingStreamTotemRank2) then _HealingStreamTotem = Resto_Ability.HealingStreamTotemRank2; end

if IsSpellKnown(Resto_Ability.HealingWaveRank10) then _HealingWave = Resto_Ability.HealingWaveRank10;
elseif IsSpellKnown(Resto_Ability.HealingWaveRank9) then _HealingWave = Resto_Ability.HealingWaveRank9;
elseif IsSpellKnown(Resto_Ability.HealingWaveRank8) then _HealingWave = Resto_Ability.HealingWaveRank8;
elseif IsSpellKnown(Resto_Ability.HealingWaveRank7) then _HealingWave = Resto_Ability.HealingWaveRank7;
elseif IsSpellKnown(Resto_Ability.HealingWaveRank6) then _HealingWave = Resto_Ability.HealingWaveRank6;
elseif IsSpellKnown(Resto_Ability.HealingWaveRank5) then _HealingWave = Resto_Ability.HealingWaveRank5;
elseif IsSpellKnown(Resto_Ability.HealingWaveRank4) then _HealingWave = Resto_Ability.HealingWaveRank4;
elseif IsSpellKnown(Resto_Ability.HealingWaveRank3) then _HealingWave = Resto_Ability.HealingWaveRank3;
elseif IsSpellKnown(Resto_Ability.HealingWaveRank2) then _HealingWave = Resto_Ability.HealingWaveRank2; end

if IsSpellKnown(Resto_Ability.ManaSpringTotemRank4) then _ManaSpringTotem = Resto_Ability.ManaSpringTotemRank4;
elseif IsSpellKnown(Resto_Ability.ManaSpringTotemRank3) then _ManaSpringTotem = Resto_Ability.ManaSpringTotemRank3;
elseif IsSpellKnown(Resto_Ability.ManaSpringTotemRank2) then _ManaSpringTotem = Resto_Ability.ManaSpringTotemRank2; end

if IsSpellKnown(Resto_Ability.ManaTideTotemRank3) then _ManaTideTotem = Resto_Ability.ManaTideTotemRank3;
elseif IsSpellKnown(Resto_Ability.ManaTideTotemRank2) then _ManaTideTotem = Resto_Ability.ManaTideTotemRank2; end

ids.optionMaxIds = {
	--Elemental
	ChainLightning = _ChainLightning,
	EarthShock = _EarthShock,
	ElementalMastery = _ElementalMastery,
	FireNovaTotem = _FireNovaTotem,
	FlameShock = _FlameShock,
	FrostShock = _FrostShock,
	LightningBolt = _LightningBolt,
	MagmaTotem = _MagmaTotem,
	Purge = _Purge,
	SearingTotem = _SearingTotem,
	StoneclawTotem = _StoneclawTotem,
	Thunderstorm = _Thunderstorm,
	WindShear = _WindShear,
	--Enhancement
	BloodLust = _BloodLust,
	EarthElementalTotem = _EarthElementalTotem,
	FeralSpirit = _FeralSpirit,
	FireResistanceTotem = _FireResistanceTotem,
	FlametongueTotem = _FlametongueTotem,
	FlametongueWeapon = _FlametongueWeapon,
	FlametongueWeaponDR = _FlametongueWeaponDR,
	FrostResistanceTotem = _FrostResistanceTotem,
	FrostbrandWeapon = _FrostbrandWeapon,
	GraceofAirTotem = _GraceofAirTotem,
	Heroism = _Heroism,
	LightningShield = _LightningShield,
	NatureResistanceTotem = _NatureResistanceTotem,
	RockbiterWeapon = _RockbiterWeapon,
	StoneskinTotem = _StoneskinTotem,
	Stormstrike = _Stormstrike,
	StrengthofEarthTotem = _StrengthofEarthTotem,
	WindfuryTotem = _WindfuryTotem,
	WindfuryWeapon = _WindfuryWeapon,
	WindwallTotem = _WindwallTotem,
	WrathofAirTotem = _WrathofAirTotem,
	--Restoration
	AncestralSpirit = _AncestralSpirit,
	ChainHeal = _ChainHeal,
	--EarthlivingWeapon = _EarthlivingWeapon,
	LesserHealingWave = _LesserHealingWave,
	HealingStreamTotem = _HealingStreamTotem,
	HealingWave = _HealingWave,
	ManaSpringTotem = _ManaSpringTotem,
	ManaTideTotem = _ManaTideTotem,
    --Runes
    LavaBurst = _LavaBurst,
    LavaLash = _LavaLash,
    MoltenBlast = _MoltenBlast,
    WaterShield = _WaterShield,

}
end
ConROC:UpdateSpellID()
function ConROC:EnableRotationModule()
	self.Description = 'Shaman';
	self.NextSpell = ConROC.Shaman.Damage;
	
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self:RegisterEvent('PLAYER_TOTEM_UPDATE');
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self.lastSpellId = 0;
	
	ConROC:SpellmenuClass();	
end
function ConROC:PLAYER_TALENT_UPDATE()
	ConROC:SpecUpdate();
    ConROC:closeSpellmenu();
end

function ConROC.Shaman.Damage(_, timeShift, currentSpell, gcd)
ConROC:UpdateSpellID()

--Character
	local plvl 												= UnitLevel('player');
	
--Racials

--Resources
	local mana 												= UnitPower('player', Enum.PowerType.Mana);
	local manaMax 											= UnitPowerMax('player', Enum.PowerType.Mana);
	local manaPercent 										= math.max(0, mana) / math.max(1, manaMax) * 100;
	
--Abilities	
	local lBoltRDY											= ConROC:AbilityReady(_LightningBolt, timeShift);
	local chainLRDY											= ConROC:AbilityReady(_ChainLightning, timeShift);
	local eShockRDY											= ConROC:AbilityReady(_EarthShock, timeShift);
        local eShockDEBUFF, _, eShockDUR                        = ConROC:TargetDebuff(_EarthShock, timeShift);
		local eShockR1RDY										= ConROC:AbilityReady(Ele_Ability.EarthShockRank1, timeShift);	
        local eShockR1DEBUFF, _, eShockR1DUR                        = ConROC:TargetDebuff(Ele_Ability.EarthShockRank1, timeShift);
	local fShockRDY											= ConROC:AbilityReady(_FlameShock, timeShift);
		local fShockDEBUFF, _, fShockDUR						= ConROC:TargetDebuff(_FlameShock, timeShift);
	local frShockRDY										= ConROC:AbilityReady(_FrostShock, timeShift);
        local frShockDEBUFF, _, frShockDUR                        = ConROC:TargetDebuff(_FrostShock, timeShift);
	local eMastRDY											= ConROC:AbilityReady(_ElementalMastery, timeShift);
	local purgeRDY											= ConROC:AbilityReady(_Purge, timeShift);
    if ConROC:TalentChosen(Spec.Enhancement, Enh_Talent.Stormstrike) then
       local sStrikeRDY                                        = ConROC:AbilityReady(_Stormstrike, timeShift);
	       local sStrikeDEBUFF										= ConROC:TargetDebuff(_Stormstrike, timeShift);
	end
    local ftWepRDY											= ConROC:AbilityReady(_FlametongueWeapon, timeShift);
	local ftWepDRRDY										= ConROC:AbilityReady(_FlametongueWeaponDR, timeShift);
	local fbWepRDY											= ConROC:AbilityReady(_FrostbrandWeapon, timeShift);
	local rbWepRDY											= ConROC:AbilityReady(_RockbiterWeapon, timeShift);
	local wfWepRDY											= ConROC:AbilityReady(_WindfuryWeapon, timeShift);
	--local frNovaRDY											= ConROC:AbilityReady(_FireNova, timeShift);
	
	--totems
	local mTotemRDY											= ConROC:AbilityReady(_MagmaTotem, timeShift);	
	local searTotemRDY										= ConROC:AbilityReady(_SearingTotem, timeShift);
	local fnTotemRDY                                        = ConROC:AbilityReady(_FireNovaTotem, timeShift);
    local ftTotemRDY										= ConROC:AbilityReady(_FlametongueTotem, timeShift);
	local grTotemRDY										= ConROC:AbilityReady(Enh_Ability.GroundingTotem, timeShift);
	local senTotemRDY										= ConROC:AbilityReady(Enh_Ability.SentryTotem, timeShift);
	local sClawTotemRDY										= ConROC:AbilityReady(_StoneclawTotem, timeShift);
	local sSkinTotemRDY										= ConROC:AbilityReady(_StoneskinTotem, timeShift);
	local soeTotemRDY										= ConROC:AbilityReady(_StrengthofEarthTotem, timeShift);
	local goaTotemRDY										= ConROC:AbilityReady(_GraceofAirTotem, timeShift);
	local wfTotemRDY										= ConROC:AbilityReady(_WindfuryTotem, timeShift);
	local wwTotemRDY										= ConROC:AbilityReady(_WindwallTotem, timeShift);
	local fResistTotemRDY									= ConROC:AbilityReady(_FireResistanceTotem, timeShift);
	local frResistTotemRDY									= ConROC:AbilityReady(_FrostResistanceTotem, timeShift);
	local nResistTotemRDY									= ConROC:AbilityReady(_NatureResistanceTotem, timeShift);
--Totems durations
	local eeTotemDUR										= ConROC.totemVariables.eeTotemEXP - GetTime();
	local feTotemDUR										= ConROC.totemVariables.feTotemEXP - GetTime();
	local fnTotemDUR                                        = ConROC.totemVariables.fnTotemEXP - GetTime();
    local cTotemDUR											= ConROC.totemVariables.cTotemEXP - GetTime();
	local ebTotemDUR										= ConROC.totemVariables.ebTotemEXP - GetTime();
	local fResistTotemDUR									= ConROC.totemVariables.fResistTotemEXP - GetTime();
	local ftTotemDUR										= ConROC.totemVariables.ftTotemEXP - GetTime();
	local frResistTotemDUR									= ConROC.totemVariables.frResistTotemEXP - GetTime();
	local grTotemDUR										= ConROC.totemVariables.grTotemEXP - GetTime();
	local hStreamDUR										= ConROC.totemVariables.hStreamEXP - GetTime();
	local mTotemDUR											= ConROC.totemVariables.mTotemEXP - GetTime();
    local mSpringTotemDUR                                   = ConROC.totemVariables.mSpringTotemEXP - GetTime();
	local mTideTotemDUR									    = ConROC.totemVariables.mTideTotemEXP - GetTime();
	local nResistTotemDUR									= ConROC.totemVariables.nResistTotemEXP - GetTime();
	local searTotemDUR										= ConROC.totemVariables.searTotemEXP - GetTime();
	local senTotemDUR										= ConROC.totemVariables.senTotemEXP - GetTime();
	local scTotemDUR										= ConROC.totemVariables.scTotemEXP - GetTime();
	local sSkinTotemDUR										= ConROC.totemVariables.sSkinTotemEXP - GetTime();
	local soeTotemDUR										= ConROC.totemVariables.soeTotemEXP - GetTime();
	local tTotemDUR											= ConROC.totemVariables.tTotemEXP - GetTime();
	local wfTotemDUR										= ConROC.totemVariables.wfTotemEXP - GetTime();
	local woaTotemDUR										= ConROC.totemVariables.woaTotemEXP - GetTime();

	local cCastingBuff										= ConROC:Buff(Player_Buff.Clearcasting, timeShift);
--	local MStromWpn, MStromWpnCount							= ConROC:Buff(Player_Buff.MaelstromWpn, timeShift);	

--Runes
    local lBurstRDY                                         = ConROC:AbilityReady(_LavaBurst, timeShift);
    local lLashRDY                                          = ConROC:AbilityReady(_LavaLash, timeShift);
    local mBlastRDY                                         = ConROC:AbilityReady(_MoltenBlast, timeShift);
    local sRageRDY                                          = ConROC:AbilityReady(_ShamanisticRage, timeShift);
    
--Conditions
	local incombat 											= UnitAffectingCombat('player');
    local resting = IsResting()
    local mounted = IsMounted()
    local onVehicle = UnitHasVehicleUI("player")
	local inMelee											= CheckInteractDistance('target', 3);
	local targetPh 											= ConROC:PercentHealth('target');
	local moving 											= ConROC:PlayerSpeed();
	local hasMHEnch, _, mhCharges, mhEnchID, hasOHEnch, _, ohCharges, ohEnchId = GetWeaponEnchantInfo();
	local tarInMelee										= 0;
	local tarInAoe											= 0;
	
	if IsSpellKnown(6603) then -- auto attack
		tarInMelee = ConROC:Targets(6603);
	end
	if ConROC_AoEButton:IsVisible() and IsSpellKnown(_ChainLightning) then
		tarInAoe = ConROC:Targets(_ChainLightning);
	end
	--print(offHandType())
--Indicators
    ConROC:AbilityInterrupt(_EarthShock, ConROC:Interrupt() and _EarthShock)

--Warnings
    if not (mounted or onVehicle or resting) and not incombat then
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
            if ConROC:CheckBox(ConROC_SM_Option_Imbue) then --and not (resting or incombat or mounted or onVehicle) then
                ConROC:ApplyImbue(_mhP, _mhTexture, _ohP, _ohTexture)
                if not ConROCApplyImbueFrame:IsShown() then
                    ConROCApplyImbueFrame:Show()
                end
            end
        end
        if ConROCApplyImbueFrame:IsShown() then
            if not ConROC:CheckBox(ConROC_SM_Option_Imbue) or
                --(resting or mounted or onVehicle and not incombat) or 
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

    if ConROC.Seasons.IsSoD then
        if plvl < 10 or ConROC:CheckBox(ConROC_SM_Role_Caster) then
            if eShockRDY and (cCastingBuff or ((targetPh <= 5 and ConROC:Raidmob()) or (targetPh <= 20 and not ConROC:Raidmob())) or not IsSpellKnown(_FlameShock) ) then
                return _EarthShock;
            end
            if fShockRDY and not fShockDEBUFF then
                return _FlameShock;
            end
            if lBurstRDY and fShockDEBUFF then
                return _LavaBurst;
            end
            if ConROC_AoEButton:IsVisible() then
                if chainLRDY then
                    return _ChainLightning
                end
            end
            if lBoltRDY then
                return _LightningBolt;
            end
        end
        if plvl < 10 or ConROC:CheckBox(ConROC_SM_Role_Melee) then
            if eShockRDY and (cCastingBuff or ((targetPh <= 5 and ConROC:Raidmob()) or (targetPh <= 20 and not ConROC:Raidmob())) or not IsSpellKnown(_FlameShock) ) then
                return _EarthShock;
            end
            if fShockRDY and not fShockDEBUFF then
                return _FlameShock;
            end
            if lLashRDY then
                return _LavaLash
            end
            if mBlastRDY then
                return _MoltenBlast
            end
        end
        if plvl < 10 or ConROC:CheckBox(ConROC_SM_Role_Tank) then            
            if fShockRDY and not fShockDEBUFF then
                return _FlameShock;
            end
            if mBlastRDY then
                return _MoltenBlast
            end
            if frShockRDY and fShockDEBUFF and not frShockDEBUFF then
                return _FlameShock;
            end           
        end
        return nil
    end
    --not SoD
	if currentSpecID == ids.Spec.Enhancement then
		if lBoltRDY and not inMelee then
			return _LightningBolt;
		end
		if sStrikeRDY and inMelee then
				return _Stormstrike;
		end
		if eShockRDY and (cCastingBuff or ((targetPh <= 5 and ConROC:Raidmob()) or (targetPh <= 20 and not ConROC:Raidmob()))) then
            return _EarthShock;
        end
        if fShockRDY and not fShockDEBUFF then
            return _FlameShock;
        end        
        if eShockR1RDY and (ConROC:TalentChosen(Spec.Elemental, Ele_Talent.ElementalFocus) or ConROC:TalentChosen(Spec.Elemental, Ele_Talent.ElementalDevastation)) then
            return Ele_Ability.EarthShockRank1;
        end
        if not IsAddOnLoaded("TotemTimers") or ConROC:CheckBox(ConROC_SM_Option_Totems) then --only if not the addon TotemTimers is loaded
            if searTotemRDY and searTotemDUR < 0.1 then
                return _SearingTotem;
            end
            --[[
            if (searTotemRDY or mTotemRDY) and (searTotemDUR < 0.1 or mTotemDUR < 0.1) then
                if searTotemRDY and searTotemDUR < 0.1 then
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
            if (not ConROC_AoEButton:IsVisible() or (not inMelee or tarInMelee < 2)) and searTotemRDY and searTotemDUR < 0.1 then
                return _SearingTotem;
            end
            if (ConROC_AoEButton:IsVisible() or tarInMelee > 2) and fnTotemRDY and fnTotemDUR < 0.1 then
                return _FireNovaTotem;
            end
        end
		if eMastRDY  and incombat then
			return _ElementalMastery;
		end
		if eShockRDY and (cCastingBuff or ((targetPh <= 5 and ConROC:Raidmob()) or (targetPh <= 20 and not ConROC:Raidmob()))) then
            return _EarthShock;
        end
        if fShockRDY and not fShockDEBUFF then
            return _FlameShock;
        end        
        if eShockR1RDY and (ConROC:TalentChosen(Spec.Elemental, Ele_Talent.ElementalFocus) or ConROC:TalentChosen(Spec.Elemental, Ele_Talent.ElementalDevastation)) then
            return Ele_Ability.EarthShockRank1;
        end
		if ConROC_AoEButton:IsVisible() and chainLRDY and not moving then
			return _ChainLightning;
		end
		if lBoltRDY and not moving then
			return _LightningBolt;
		end
		if frShockRDY and fShockDEBUFF and moving then
			return _FrostShock;
		end
		if frShockRDY and fShockDEBUFF then
			return _FrostShock;
		end
		return nil
	else
		if chainLRDY and cCastingBuff then
			return _ChainLightning;
		end

		if lBoltRDY and not inMelee then
			return _LightningBolt;
		end

		if inMelee then
			if sStrikeRDY then
				return _Stormstrike;
			end

			if eShockRDY and (cCastingBuff or ((targetPh <= 5 and ConROC:Raidmob()) or (targetPh <= 20 and not ConROC:Raidmob()))) then
				return _EarthShock;
			end
			
			if eShockR1RDY and (ConROC:TalentChosen(Spec.Elemental, Ele_Talent.ElementalFocus) or ConROC:TalentChosen(Spec.Elemental, Ele_Talent.ElementalDevastation)) then
				return Ele_Ability.EarthShockRank1;
			end		
		end
		return nil;
	end
end

function ConROC.Shaman.Defense(_, timeShift, currentSpell, gcd)
--Character
	local plvl 												= UnitLevel('player');
	
--Racials

--Resources
	local mana 												= UnitPower('player', Enum.PowerType.Mana);
	local manaMax 											= UnitPowerMax('player', Enum.PowerType.Mana);
	
--Ranks
	if IsSpellKnown(Enh_Ability.LightningShieldRank7) then _LightningShield = Enh_Ability.LightningShieldRank7;
	elseif IsSpellKnown(Enh_Ability.LightningShieldRank6) then _LightningShield = Enh_Ability.LightningShieldRank6;
	elseif IsSpellKnown(Enh_Ability.LightningShieldRank5) then _LightningShield = Enh_Ability.LightningShieldRank5;
	elseif IsSpellKnown(Enh_Ability.LightningShieldRank4) then _LightningShield = Enh_Ability.LightningShieldRank4;
	elseif IsSpellKnown(Enh_Ability.LightningShieldRank3) then _LightningShield = Enh_Ability.LightningShieldRank3;
	elseif IsSpellKnown(Enh_Ability.LightningShieldRank2) then _LightningShield = Enh_Ability.LightningShieldRank2; end

--Abilities	
	local lShieldRDY										= ConROC:AbilityReady(_LightningShield, timeShift);
		local lShieldBUFF										= ConROC:Buff(_LightningShield, timeShift);
	local wShieldRDY                                        = ConROC:AbilityReady(_WaterShield, timeShift);

--Conditions
	local incombat 											= UnitAffectingCombat('player');
	local moving 											= ConROC:PlayerSpeed();

--Indicators	

--Warnings
	
--Rotations	
	if lShieldRDY and not lShieldBUFF and (not IsAddOnLoaded("TotemTimers") or ConROC:CheckBox(ConROC_SM_Option_Shields)) then
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
                    frame:StartMoving()
                end
            end
        end
    )
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
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
                frame:StartMoving()
        end
    end)

    dragFrame:SetScript("OnMouseUp", function (self, otbutton, up)
        if ConROC.db.profile.unlockWindow then
            frame:StopMovingOrSizing();
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
