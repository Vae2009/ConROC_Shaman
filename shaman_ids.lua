local ConROC_Shaman, ids = ...;

--General
ids.Racial = {
	Berserking = 20554,
}
ids.Spec = {
	Elemental = 1,
	Enhancement = 2,
	Restoration = 3,
}
ids.Ability = {
--Elemental
	ChainLightning = 421,
	EarthShock = 8042,
	EarthbindTotem = 2484,
	ElementalMastery = 16166,
	FireNovaTotem = 1535,
	FlameShock = 8050,
	FrostShock = 8056,
	LightningBolt = 403,
	MagmaTotem = 8190,
	Purge = 370,
	SearingTotem = 3599,
	StoneclawTotem = 5730,
--Enhancement
	AstralRecall = 556,
	GhostWolf = 2645,
	FarSight = 6196,
	FireResistanceTotem = 8184,
	FlametongueTotem = 8227,
	FlametongueWeapon = 8024,
	FlametongueWeaponDR = 8024,
	FrostResistanceTotem = 8181,
	FrostbrandWeapon = 8033,
	GraceofAirTotem = 8835,
	GroundingTotem = 8177,
	LightningShield = 324,
	NatureResistanceTotem = 10595,
	RockbiterWeapon = 8017,
	SentryTotem = 6495,
	StoneskinTotem = 8071,
	Stormstrike = 17364,
	StrengthofEarthTotem = 8075,
	WaterBreathing = 131,
	WaterWalking = 546,
	WindfuryTotem = 8512,
	WindfuryWeapon = 8232,
	WindwallTotem = 15107,
--Restoration
	AncestralSpirit = 2008,
	ChainHeal = 1064,
	CureDisease = 2870,
	CurePoison = 526,
	DiseaseCleansingTotem = 8170,
	HealingStreamTotem = 5394,
	HealingWave = 331,
	LesserHealingWave = 8004,
	ManaSpringTotem = 5675,
	ManaTideTotem = 16190,
	NaturesSwiftness = 16188,
	PoisonCleansingTotem = 8166,
	Reincarnation = 20608,
	TranquilAirTotem = 25908,
	TremorTotem = 8143,
}
ids.Rank = {
--Elemental
	ChainLightningRank2 = 930,
	ChainLightningRank3 = 2860,
	ChainLightningRank4 = 10605,
	EarthShockRank1 = 8042,
	EarthShockRank2 = 8044,
	EarthShockRank3 = 8045,
	EarthShockRank4 = 8046,
	EarthShockRank5 = 10412,
	EarthShockRank6 = 10413,
	EarthShockRank7 = 10414,
	FireNovaTotemRank2 = 8498,
	FireNovaTotemRank3 = 8499,
	FireNovaTotemRank4 = 11314,
	FireNovaTotemRank5 = 11315,
	FlameShockRank2 = 8052,
	FlameShockRank3 = 8053,
	FlameShockRank4 = 10447,
	FlameShockRank5 = 10448,
	FlameShockRank6 = 29228,
	FrostShockRank2 = 8058,
	FrostShockRank3 = 10472,
	FrostShockRank4 = 10473,
	LightningBoltRank2 = 529,
	LightningBoltRank3 = 548,
	LightningBoltRank4 = 915,
	LightningBoltRank5 = 943,
	LightningBoltRank6 = 6041,
	LightningBoltRank7 = 10391,
	LightningBoltRank8 = 10392,
	LightningBoltRank9 = 15207,
	LightningBoltRank10 = 15208,
	MagmaTotemRank2 = 10585,
	MagmaTotemRank3 = 10586,
	MagmaTotemRank4 = 10587,
	MagmaTotemRank5 = 25552,
	PurgeRank2 = 8012,
	SearingTotemRank2 = 6363,
	SearingTotemRank3 = 6364,
	SearingTotemRank4 = 6365,
	SearingTotemRank5 = 10437,
	SearingTotemRank6 = 10438,
	StoneclawTotemRank2 = 6390,
	StoneclawTotemRank3 = 6391,
	StoneclawTotemRank4 = 6392,
	StoneclawTotemRank5 = 10427,
	StoneclawTotemRank6 = 10428,
--Enhancement
	FireResistanceTotemRank2 = 10537,
	FireResistanceTotemRank3 = 10538,
	FlametongueTotemRank2 = 8249,
	FlametongueTotemRank3 = 10526,
	FlametongueTotemRank4 = 16387,
	FlametongueWeaponRank1 = 8024,
	FlametongueWeaponRank2 = 8027,
	FlametongueWeaponRank3 = 8030,
	FlametongueWeaponRank4 = 16339,
	FlametongueWeaponRank5 = 16341,
	FlametongueWeaponRank6 = 16342,
	FrostResistanceTotemRank2 = 10478,
	FrostResistanceTotemRank3 = 10479,
	FrostbrandWeaponRank2 = 8038,
	FrostbrandWeaponRank3 = 10456,
	FrostbrandWeaponRank4 = 16355,
	FrostbrandWeaponRank5 = 16356,
	GraceofAirTotemRank2 = 10627,
	LightningShieldRank2 = 325,
	LightningShieldRank3 = 905,
	LightningShieldRank4 = 945,
	LightningShieldRank5 = 8134,
	LightningShieldRank6 = 10431,
	LightningShieldRank7 = 10432,
	NatureResistanceTotemRank2 = 10600,
	NatureResistanceTotemRank3 = 10601,
	RockbiterWeaponRank2 = 8018,
	RockbiterWeaponRank3 = 8019,
	RockbiterWeaponRank4 = 10399,
	RockbiterWeaponRank5 = 16314,
	RockbiterWeaponRank6 = 16315,
	RockbiterWeaponRank7 = 16316,
	StoneskinTotemRank2 = 8154,
	StoneskinTotemRank3 = 8155,
	StoneskinTotemRank4 = 10406,
	StoneskinTotemRank5 = 10407,
	StoneskinTotemRank6 = 10408,
	StrengthofEarthTotemRank2 = 8160,
	StrengthofEarthTotemRank3 = 8161,
	StrengthofEarthTotemRank4 = 10442,
	StrengthofEarthTotemRank5 = 25361,
	WindfuryTotemRank2 = 10613,
	WindfuryTotemRank3 = 10614,
	WindfuryWeaponRank2 = 8235,
	WindfuryWeaponRank3 = 10486,
	WindfuryWeaponRank4 = 16362,
	WindwallTotemRank2 = 15111,
	WindwallTotemRank3 = 15112,
--Restoration
	AncestralSpiritRank2 = 20609,
	AncestralSpiritRank3 = 20610,
	AncestralSpiritRank4 = 20776,
	AncestralSpiritRank5 = 20777,
	ChainHealRank2 = 10622,
	ChainHealRank3 = 10623,
	HealingStreamTotemRank2 = 6375,
	HealingStreamTotemRank3 = 6377,
	HealingStreamTotemRank4 = 10462,
	HealingStreamTotemRank5 = 10463,
	HealingWaveRank2 = 332,
	HealingWaveRank3 = 547,
	HealingWaveRank4 = 913,
	HealingWaveRank5 = 939,
	HealingWaveRank6 = 959,
	HealingWaveRank7 = 8005,
	HealingWaveRank8 = 10395,
	HealingWaveRank9 = 10396,
	HealingWaveRank10 = 25357,
	LesserHealingWaveRank2 = 8008,
	LesserHealingWaveRank3 = 8010,
	LesserHealingWaveRank4 = 10466,
	LesserHealingWaveRank5 = 10467,
	LesserHealingWaveRank6 = 10468,
	ManaSpringTotemRank2 = 10495,
	ManaSpringTotemRank3 = 10496,
	ManaSpringTotemRank4 = 10497,
	ManaTideTotemRank2 = 17354,
	ManaTideTotemRank3 = 17359,
}
ids.Elemental_Talent = { 
	CallofFlame =  1, 
	CallofThunder =  2, 
	Concussion =  3, 
	Convection =  4, 
	ElementalFury =  5, 
	ImprovedFireTotems =  6, 
	EarthsGrasp =  7, 
	ElementalMastery =  8, 
	ElementalFocus =  9, 
	Reverberation =  10, 
	LightningMastery =  11, 
	ElementalWarding =  12, 
	StormReach =  13, 
	EyeoftheStorm =  14, 
	ElementalDevastation =  15, 
}
ids.Enhancement_Talent = { 
	Anticipation =  1, 
	Flurry =  2, 
	ImprovedGhostWolf =  3, 
	ImprovedLightningShield =  4, 
	GuardianTotems =  5, 
	EnhancingTotems =  6, 
	ElementalWeapons =  7, 
	ShieldSpecialization =  8, 
	ThunderingStrikes =  9, 
	AncestralKnowledge =  10, 
	Toughness =  11, 
	Parry =  12, 
	TwoHandedAxesandMaces =  13, 
	Stormstrike =  14, 
	WeaponMastery =  15, 
	ImprovedWeaponTotems =  16, 
}
ids.Restoration_Talent = { 
	AncestralHealing =  1, 
	TotemicMastery =  2, 
	NaturesGuidance =  3, 
	ImprovedHealingWave =  4, 
	HealingFocus =  5, 
	RestorativeTotems =  6, 
	ImprovedReincarnation =  7, 
	ManaTideTotem =  8, 
	NaturesSwiftness =  9, 
	Purification =  10, 
	TidalFocus =  11, 
	TidalMastery =  12, 
	TotemicFocus =  13, 
	HealingGrace =  14, 
	HealingWay =  15, 
}
ids.Runes = {
	LavaBurst = 408490,
	LavaLash = 408507,
	MoltenBlast = 425339,
	ShamanisticRage = 425336,
	WaterShield = 408510,
	TwoHandedMastery = 436365, --Phase 2 -passive -buff 10sec 30% inc atk speed
	MaelstromWeapon = 408505, --Phase 2 -passive -buff reduce casttime and mana by 20% stacks up to 5
	SpiritoftheAlpha = 408696, --Phase 2 -buff 30min Increases threat generated by 45%.
}
-- Auras
ids.Buff = {
	Clearcasting = 16246,
}
ids.Debuff = {

}
ids.Totems = {
	{"Disease Cleansing Totem", "dcTotemEXP"},
	{"Fire Nova Totem", "fnovaTotemEXP"},
	{"Graceof Air Totem", "goaTotemEXP"},
	{"Poison Cleansing Totem", "pcTotemEXP"},
	{"Tranquil Air Totem", "taTotemEXP"},
	{"Windwall Totem", "wwTotemEXP"},
	{"Cleansing Totem", "cTotemEXP"},
	{"Earthbind Totem", "ebTotemEXP"},
	{"Fire Resistance Totem", "fResistTotemEXP"},
	{"Fire Nova Totem", "fnTotemEXP"},
	{"Flametongue Totem", "ftTotemEXP"},
	{"Frost Resistance Totem", "frResistTotemEXP"},
	{"Grounding Totem", "grTotemEXP"},
	{"Healing Stream Totem", "hStreamEXP"},
	{"Magma Totem", "mTotemEXP"},
	{"Mana Spring Totem", "mSpringTotemEXP"},
	{"Mana Tide Totem", "mTideTotemEXP"},
	{"Nature Resistance Totem", "nResistTotemEXP"},
	{"Searing Totem", "searTotemEXP"},
	{"Sentry Totem", "senTotemEXP"},
	{"Stoneclaw Totem", "scTotemEXP"},
	{"Stoneskin Totem", "sSkinTotemEXP"},
	{"Strength of Earth Totem", "soeTotemEXP"},
	{"Tremor Totem", "tTotemEXP"},
	{"Windfury Totem", "wfTotemEXP"},
}
ids.wpnEnchantments = {
	["Flametongue Weapon"] = {5,4,3,523,1665,1666,2634,3779,3780,3781},
	["Frostbrand Weapon"] = {2,12,524,1667,1668,2635,3782,3783,3784},
	["Rockbiter Weapon"] = {29,6,3029,3032},
--		["Earthliving Weapon"] = {3345,3346,3347,3348,3349,3350},
	["Windfury Weapon"] = {283,284,525,1669,2636,3785,3786,3787},
}

function ConROC:UpdateSpellID()
--Ranks
	--Elemental
	if IsSpellKnown(ids.Rank.ChainLightningRank4) then ids.Ability.ChainLightning = ids.Rank.ChainLightningRank4;
	elseif IsSpellKnown(ids.Rank.ChainLightningRank3) then ids.Ability.ChainLightning = ids.Rank.ChainLightningRank3;
	elseif IsSpellKnown(ids.Rank.ChainLightningRank2) then ids.Ability.ChainLightning = ids.Rank.ChainLightningRank2; end

	if IsSpellKnown(ids.Rank.EarthShockRank7) then ids.Ability.EarthShock = ids.Rank.EarthShockRank7;
	elseif IsSpellKnown(ids.Rank.EarthShockRank6) then ids.Ability.EarthShock = ids.Rank.EarthShockRank6;
	elseif IsSpellKnown(ids.Rank.EarthShockRank5) then ids.Ability.EarthShock = ids.Rank.EarthShockRank5;
	elseif IsSpellKnown(ids.Rank.EarthShockRank4) then ids.Ability.EarthShock = ids.Rank.EarthShockRank4;
	elseif IsSpellKnown(ids.Rank.EarthShockRank3) then ids.Ability.EarthShock = ids.Rank.EarthShockRank3;
	elseif IsSpellKnown(ids.Rank.EarthShockRank2) then ids.Ability.EarthShock = ids.Rank.EarthShockRank2; end

	if IsSpellKnown(ids.Rank.FireNovaTotemRank5) then ids.Ability.FireNovaTotem = ids.Rank.FireNovaTotemRank5;
	elseif IsSpellKnown(ids.Rank.FireNovaTotemRank4) then ids.Ability.FireNovaTotem = ids.Rank.FireNovaTotemRank4;
	elseif IsSpellKnown(ids.Rank.FireNovaTotemRank3) then ids.Ability.FireNovaTotem = ids.Rank.FireNovaTotemRank3;
	elseif IsSpellKnown(ids.Rank.FireNovaTotemRank2) then ids.Ability.FireNovaTotem = ids.Rank.FireNovaTotemRank2; end

	if IsSpellKnown(ids.Rank.FlameShockRank6) then ids.Ability.FlameShock = ids.Rank.FlameShockRank6;
	elseif IsSpellKnown(ids.Rank.FlameShockRank5) then ids.Ability.FlameShock = ids.Rank.FlameShockRank5;
	elseif IsSpellKnown(ids.Rank.FlameShockRank4) then ids.Ability.FlameShock = ids.Rank.FlameShockRank4;
	elseif IsSpellKnown(ids.Rank.FlameShockRank3) then ids.Ability.FlameShock = ids.Rank.FlameShockRank3;
	elseif IsSpellKnown(ids.Rank.FlameShockRank2) then ids.Ability.FlameShock = ids.Rank.FlameShockRank2; end

	if IsSpellKnown(ids.Rank.FrostShockRank4) then ids.Ability.FrostShock = ids.Rank.FrostShockRank4;
	elseif IsSpellKnown(ids.Rank.FrostShockRank3) then ids.Ability.FrostShock = ids.Rank.FrostShockRank3;
	elseif IsSpellKnown(ids.Rank.FrostShockRank2) then ids.Ability.FrostShock = ids.Rank.FrostShockRank2; end

	if IsSpellKnown(ids.Rank.LightningBoltRank10) then ids.Ability.LightningBolt = ids.Rank.LightningBoltRank10;
	elseif IsSpellKnown(ids.Rank.LightningBoltRank9) then ids.Ability.LightningBolt = ids.Rank.LightningBoltRank9;
	elseif IsSpellKnown(ids.Rank.LightningBoltRank8) then ids.Ability.LightningBolt = ids.Rank.LightningBoltRank8;
	elseif IsSpellKnown(ids.Rank.LightningBoltRank7) then ids.Ability.LightningBolt = ids.Rank.LightningBoltRank7;
	elseif IsSpellKnown(ids.Rank.LightningBoltRank6) then ids.Ability.LightningBolt = ids.Rank.LightningBoltRank6;
	elseif IsSpellKnown(ids.Rank.LightningBoltRank5) then ids.Ability.LightningBolt = ids.Rank.LightningBoltRank5;
	elseif IsSpellKnown(ids.Rank.LightningBoltRank4) then ids.Ability.LightningBolt = ids.Rank.LightningBoltRank4;
	elseif IsSpellKnown(ids.Rank.LightningBoltRank3) then ids.Ability.LightningBolt = ids.Rank.LightningBoltRank3;
	elseif IsSpellKnown(ids.Rank.LightningBoltRank2) then ids.Ability.LightningBolt = ids.Rank.LightningBoltRank2; end

	if IsSpellKnown(ids.Rank.MagmaTotemRank5) then ids.Ability.MagmaTotem = ids.Rank.MagmaTotemRank5;
	elseif IsSpellKnown(ids.Rank.MagmaTotemRank4) then ids.Ability.MagmaTotem = ids.Rank.MagmaTotemRank4;
	elseif IsSpellKnown(ids.Rank.MagmaTotemRank3) then ids.Ability.MagmaTotem = ids.Rank.MagmaTotemRank3;
	elseif IsSpellKnown(ids.Rank.MagmaTotemRank2) then ids.Ability.MagmaTotem = ids.Rank.MagmaTotemRank2; end

	if IsSpellKnown(ids.Rank.PurgeRank2) then ids.Ability.Purge = ids.Rank.PurgeRank2; end

	if IsSpellKnown(ids.Rank.SearingTotemRank6) then ids.Ability.SearingTotem = ids.Rank.SearingTotemRank6;
	elseif IsSpellKnown(ids.Rank.SearingTotemRank5) then ids.Ability.SearingTotem = ids.Rank.SearingTotemRank5;
	elseif IsSpellKnown(ids.Rank.SearingTotemRank4) then ids.Ability.SearingTotem = ids.Rank.SearingTotemRank4;
	elseif IsSpellKnown(ids.Rank.SearingTotemRank3) then ids.Ability.SearingTotem = ids.Rank.SearingTotemRank3;
	elseif IsSpellKnown(ids.Rank.SearingTotemRank2) then ids.Ability.SearingTotem = ids.Rank.SearingTotemRank2; end

	if IsSpellKnown(ids.Rank.StoneclawTotemRank6) then ids.Ability.StoneclawTotem = ids.Rank.StoneclawTotemRank6;
	elseif IsSpellKnown(ids.Rank.StoneclawTotemRank5) then ids.Ability.StoneclawTotem = ids.Rank.StoneclawTotemRank5;
	elseif IsSpellKnown(ids.Rank.StoneclawTotemRank4) then ids.Ability.StoneclawTotem = ids.Rank.StoneclawTotemRank4;
	elseif IsSpellKnown(ids.Rank.StoneclawTotemRank3) then ids.Ability.StoneclawTotem = ids.Rank.StoneclawTotemRank3;
	elseif IsSpellKnown(ids.Rank.StoneclawTotemRank2) then ids.Ability.StoneclawTotem = ids.Rank.StoneclawTotemRank2; end

	--Enhancement
	if IsSpellKnown(ids.Rank.FireResistanceTotemRank3) then ids.Ability.FireResistanceTotem = ids.Rank.FireResistanceTotemRank3;
	elseif IsSpellKnown(ids.Rank.FireResistanceTotemRank2) then ids.Ability.FireResistanceTotem = ids.Rank.FireResistanceTotemRank2; end

	if IsSpellKnown(ids.Rank.FlametongueTotemRank4) then ids.Ability.FlametongueTotem = ids.Rank.FlametongueTotemRank4;
	elseif IsSpellKnown(ids.Rank.FlametongueTotemRank3) then ids.Ability.FlametongueTotem = ids.Rank.FlametongueTotemRank3;
	elseif IsSpellKnown(ids.Rank.FlametongueTotemRank2) then ids.Ability.FlametongueTotem = ids.Rank.FlametongueTotemRank2; end

	if IsSpellKnown(ids.Rank.FlametongueWeaponRank6) then ids.Ability.FlametongueWeapon = ids.Rank.FlametongueWeaponRank6;
	elseif IsSpellKnown(ids.Rank.FlametongueWeaponRank5) then ids.Ability.FlametongueWeapon = ids.Rank.FlametongueWeaponRank5;
	elseif IsSpellKnown(ids.Rank.FlametongueWeaponRank4) then ids.Ability.FlametongueWeapon = ids.Rank.FlametongueWeaponRank4;
	elseif IsSpellKnown(ids.Rank.FlametongueWeaponRank3) then ids.Ability.FlametongueWeapon = ids.Rank.FlametongueWeaponRank3;
	elseif IsSpellKnown(ids.Rank.FlametongueWeaponRank2) then ids.Ability.FlametongueWeapon = ids.Rank.FlametongueWeaponRank2; end

	if IsSpellKnown(ids.Rank.FlametongueWeaponRank6) then ids.Ability.FlametongueWeaponDR = ids.Rank.FlametongueWeaponRank5;
	elseif IsSpellKnown(ids.Rank.FlametongueWeaponRank5) then ids.Ability.FlametongueWeaponDR = ids.Rank.FlametongueWeaponRank4;
	elseif IsSpellKnown(ids.Rank.FlametongueWeaponRank4) then ids.Ability.FlametongueWeaponDR = ids.Rank.FlametongueWeaponRank3;
	elseif IsSpellKnown(ids.Rank.FlametongueWeaponRank3) then ids.Ability.FlametongueWeaponDR = ids.Rank.FlametongueWeaponRank2;
	elseif IsSpellKnown(ids.Rank.FlametongueWeaponRank2) then ids.Ability.FlametongueWeaponDR = ids.Rank.FlametongueWeaponRank1; end

	if IsSpellKnown(ids.Rank.FrostResistanceTotemRank3) then ids.Ability.FrostResistanceTotem = ids.Rank.FrostResistanceTotemRank3;
	elseif IsSpellKnown(ids.Rank.FrostResistanceTotemRank2) then ids.Ability.FrostResistanceTotem = ids.Rank.FrostResistanceTotemRank2; end	

	if IsSpellKnown(ids.Rank.FrostbrandWeaponRank5) then ids.Ability.FrostbrandWeapon = ids.Rank.FrostbrandWeaponRank5;
	elseif IsSpellKnown(ids.Rank.FrostbrandWeaponRank4) then ids.Ability.FrostbrandWeapon = ids.Rank.FrostbrandWeaponRank4;
	elseif IsSpellKnown(ids.Rank.FrostbrandWeaponRank3) then ids.Ability.FrostbrandWeapon = ids.Rank.FrostbrandWeaponRank3;
	elseif IsSpellKnown(ids.Rank.FrostbrandWeaponRank2) then ids.Ability.FrostbrandWeapon = ids.Rank.FrostbrandWeaponRank2; end

	if IsSpellKnown(ids.Rank.GraceofAirTotemRank2) then ids.Ability.GraceofAirTotem = ids.Rank.GraceofAirTotemRank2; end

	if IsSpellKnown(ids.Rank.LightningShieldRank7) then ids.Ability.LightningShield = ids.Rank.LightningShieldRank7;
	elseif IsSpellKnown(ids.Rank.LightningShieldRank6) then ids.Ability.LightningShield = ids.Rank.LightningShieldRank6;
	elseif IsSpellKnown(ids.Rank.LightningShieldRank5) then ids.Ability.LightningShield = ids.Rank.LightningShieldRank5;
	elseif IsSpellKnown(ids.Rank.LightningShieldRank4) then ids.Ability.LightningShield = ids.Rank.LightningShieldRank4;
	elseif IsSpellKnown(ids.Rank.LightningShieldRank3) then ids.Ability.LightningShield = ids.Rank.LightningShieldRank3;
	elseif IsSpellKnown(ids.Rank.LightningShieldRank2) then ids.Ability.LightningShield = ids.Rank.LightningShieldRank2; end

	if IsSpellKnown(ids.Rank.NatureResistanceTotemRank3) then ids.Ability.NatureResistanceTotem = ids.Rank.NatureResistanceTotemRank3;
	elseif IsSpellKnown(ids.Rank.NatureResistanceTotemRank2) then ids.Ability.NatureResistanceTotem = ids.Rank.NatureResistanceTotemRank2; end

	if IsSpellKnown(ids.Rank.RockbiterWeaponRank7) then ids.Ability.RockbiterWeapon = ids.Rank.RockbiterWeaponRank7;
	elseif IsSpellKnown(ids.Rank.RockbiterWeaponRank6) then ids.Ability.RockbiterWeapon = ids.Rank.RockbiterWeaponRank6;
	elseif IsSpellKnown(ids.Rank.RockbiterWeaponRank5) then ids.Ability.RockbiterWeapon = ids.Rank.RockbiterWeaponRank5;
	elseif IsSpellKnown(ids.Rank.RockbiterWeaponRank4) then ids.Ability.RockbiterWeapon = ids.Rank.RockbiterWeaponRank4;
	elseif IsSpellKnown(ids.Rank.RockbiterWeaponRank3) then ids.Ability.RockbiterWeapon = ids.Rank.RockbiterWeaponRank3;
	elseif IsSpellKnown(ids.Rank.RockbiterWeaponRank2) then ids.Ability.RockbiterWeapon = ids.Rank.RockbiterWeaponRank2; end

	if IsSpellKnown(ids.Rank.StoneskinTotemRank6) then ids.Ability.StoneskinTotem = ids.Rank.StoneskinTotemRank6;
	elseif IsSpellKnown(ids.Rank.StoneskinTotemRank5) then ids.Ability.StoneskinTotem = ids.Rank.StoneskinTotemRank5;
	elseif IsSpellKnown(ids.Rank.StoneskinTotemRank4) then ids.Ability.StoneskinTotem = ids.Rank.StoneskinTotemRank4;
	elseif IsSpellKnown(ids.Rank.StoneskinTotemRank3) then ids.Ability.StoneskinTotem = ids.Rank.StoneskinTotemRank3;
	elseif IsSpellKnown(ids.Rank.StoneskinTotemRank2) then ids.Ability.StoneskinTotem = ids.Rank.StoneskinTotemRank2; end

	if IsSpellKnown(ids.Rank.StrengthofEarthTotemRank5) then ids.Ability.StrengthofEarthTotem = ids.Rank.StrengthofEarthTotemRank5;
	elseif IsSpellKnown(ids.Rank.StrengthofEarthTotemRank4) then ids.Ability.StrengthofEarthTotem = ids.Rank.StrengthofEarthTotemRank4;
	elseif IsSpellKnown(ids.Rank.StrengthofEarthTotemRank3) then ids.Ability.StrengthofEarthTotem = ids.Rank.StrengthofEarthTotemRank3;
	elseif IsSpellKnown(ids.Rank.StrengthofEarthTotemRank2) then ids.Ability.StrengthofEarthTotem = ids.Rank.StrengthofEarthTotemRank2; end

	if IsSpellKnown(ids.Rank.WindfuryTotemRank3) then ids.Ability.WindfuryTotem = ids.Rank.WindfuryTotemRank3;
	elseif IsSpellKnown(ids.Rank.WindfuryTotemRank2) then ids.Ability.WindfuryTotem = ids.Rank.WindfuryTotemRank2; end

	if IsSpellKnown(ids.Rank.WindfuryWeaponRank4) then ids.Ability.WindfuryWeapon = ids.Rank.WindfuryWeaponRank4;
	elseif IsSpellKnown(ids.Rank.WindfuryWeaponRank3) then ids.Ability.WindfuryWeapon = ids.Rank.WindfuryWeaponRank3;
	elseif IsSpellKnown(ids.Rank.WindfuryWeaponRank2) then ids.Ability.WindfuryWeapon = ids.Rank.WindfuryWeaponRank2; end

	if IsSpellKnown(ids.Rank.WindwallTotemRank3) then ids.Ability.WindwallTotem = ids.Rank.WindwallTotemRank3;
	elseif IsSpellKnown(ids.Rank.WindwallTotemRank2) then ids.Ability.WindwallTotem = ids.Rank.WindwallTotemRank2; end

	--Restoration
	if IsSpellKnown(ids.Rank.AncestralSpiritRank5) then ids.Ability.AncestralSpirit = ids.Rank.AncestralSpiritRank5;
	elseif IsSpellKnown(ids.Rank.AncestralSpiritRank4) then ids.Ability.AncestralSpirit = ids.Rank.AncestralSpiritRank4;
	elseif IsSpellKnown(ids.Rank.AncestralSpiritRank3) then ids.Ability.AncestralSpirit = ids.Rank.AncestralSpiritRank3;
	elseif IsSpellKnown(ids.Rank.AncestralSpiritRank2) then ids.Ability.AncestralSpirit = ids.Rank.AncestralSpiritRank2; end

	if IsSpellKnown(ids.Rank.ChainHealRank3) then ids.Ability.ChainHeal = ids.Rank.ChainHealRank3;
	elseif IsSpellKnown(ids.Rank.ChainHealRank2) then ids.Ability.ChainHeal = ids.Rank.ChainHealRank2; end

	if IsSpellKnown(ids.Rank.LesserHealingWaveRank6) then ids.Ability.LesserHealingWave = ids.Rank.LesserHealingWaveRank6;
	elseif IsSpellKnown(ids.Rank.LesserHealingWaveRank5) then ids.Ability.LesserHealingWave = ids.Rank.LesserHealingWaveRank5;
	elseif IsSpellKnown(ids.Rank.LesserHealingWaveRank4) then ids.Ability.LesserHealingWave = ids.Rank.LesserHealingWaveRank4;
	elseif IsSpellKnown(ids.Rank.LesserHealingWaveRank3) then ids.Ability.LesserHealingWave = ids.Rank.LesserHealingWaveRank3;
	elseif IsSpellKnown(ids.Rank.LesserHealingWaveRank2) then ids.Ability.LesserHealingWave = ids.Rank.LesserHealingWaveRank2; end

	if IsSpellKnown(ids.Rank.HealingStreamTotemRank5) then ids.Ability.HealingStreamTotem = ids.Rank.HealingStreamTotemRank5;
	elseif IsSpellKnown(ids.Rank.HealingStreamTotemRank4) then ids.Ability.HealingStreamTotem = ids.Rank.HealingStreamTotemRank4;
	elseif IsSpellKnown(ids.Rank.HealingStreamTotemRank3) then ids.Ability.HealingStreamTotem = ids.Rank.HealingStreamTotemRank3;
	elseif IsSpellKnown(ids.Rank.HealingStreamTotemRank2) then ids.Ability.HealingStreamTotem = ids.Rank.HealingStreamTotemRank2; end

	if IsSpellKnown(ids.Rank.HealingWaveRank10) then ids.Ability.HealingWave = ids.Rank.HealingWaveRank10;
	elseif IsSpellKnown(ids.Rank.HealingWaveRank9) then ids.Ability.HealingWave = ids.Rank.HealingWaveRank9;
	elseif IsSpellKnown(ids.Rank.HealingWaveRank8) then ids.Ability.HealingWave = ids.Rank.HealingWaveRank8;
	elseif IsSpellKnown(ids.Rank.HealingWaveRank7) then ids.Ability.HealingWave = ids.Rank.HealingWaveRank7;
	elseif IsSpellKnown(ids.Rank.HealingWaveRank6) then ids.Ability.HealingWave = ids.Rank.HealingWaveRank6;
	elseif IsSpellKnown(ids.Rank.HealingWaveRank5) then ids.Ability.HealingWave = ids.Rank.HealingWaveRank5;
	elseif IsSpellKnown(ids.Rank.HealingWaveRank4) then ids.Ability.HealingWave = ids.Rank.HealingWaveRank4;
	elseif IsSpellKnown(ids.Rank.HealingWaveRank3) then ids.Ability.HealingWave = ids.Rank.HealingWaveRank3;
	elseif IsSpellKnown(ids.Rank.HealingWaveRank2) then ids.Ability.HealingWave = ids.Rank.HealingWaveRank2; end

	if IsSpellKnown(ids.Rank.ManaSpringTotemRank4) then ids.Ability.ManaSpringTotem = ids.Rank.ManaSpringTotemRank4;
	elseif IsSpellKnown(ids.Rank.ManaSpringTotemRank3) then ids.Ability.ManaSpringTotem = ids.Rank.ManaSpringTotemRank3;
	elseif IsSpellKnown(ids.Rank.ManaSpringTotemRank2) then ids.Ability.ManaSpringTotem = ids.Rank.ManaSpringTotemRank2; end

	if IsSpellKnown(ids.Rank.ManaTideTotemRank3) then ids.Ability.ManaTideTotem = ids.Rank.ManaTideTotemRank3;
	elseif IsSpellKnown(ids.Rank.ManaTideTotemRank2) then ids.Ability.ManaTideTotem = ids.Rank.ManaTideTotemRank2; end

	if IsSpellKnown(ids.Rank.LightningShieldRank7) then ids.Ability.LightningShield = ids.Rank.LightningShieldRank7;
	elseif IsSpellKnown(ids.Rank.LightningShieldRank6) then ids.Ability.LightningShield = ids.Rank.LightningShieldRank6;
	elseif IsSpellKnown(ids.Rank.LightningShieldRank5) then ids.Ability.LightningShield = ids.Rank.LightningShieldRank5;
	elseif IsSpellKnown(ids.Rank.LightningShieldRank4) then ids.Ability.LightningShield = ids.Rank.LightningShieldRank4;
	elseif IsSpellKnown(ids.Rank.LightningShieldRank3) then ids.Ability.LightningShield = ids.Rank.LightningShieldRank3;
	elseif IsSpellKnown(ids.Rank.LightningShieldRank2) then ids.Ability.LightningShield = ids.Rank.LightningShieldRank2; end
end