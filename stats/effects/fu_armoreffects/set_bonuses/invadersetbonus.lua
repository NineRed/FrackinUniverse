require "/stats/effects/fu_armoreffects/setbonuses_common.lua"

setName="fu_invaderset"
setEffects={"slowfall"}

weaponList={"magnorb", "magnorbs", "energy"}
weaponBonus={
	{stat = "critChance", amount = 5},
	{stat = "powerMultiplier", effectiveMultiplier = 1.20}
}

armorBonus={
	{stat = "protoImmunity", amount = 1.0},
	{stat = "fallDamageMultiplier", effectiveMultiplier = 0.75}
}


function init()
	setSEBonusInit(setName,setEffects)
	effectHandlerList.armorBonusHandle=effect.addStatModifierGroup({})
	effectHandlerList.weaponBonusHandle=effect.addStatModifierGroup({})
	
	handleBonuses(0,checkSetWorn(self.setBonusCheck))
end

function update(dt)
	handleBonuses(dt,checkSetWorn(self.setBonusCheck))
end

function handleBonuses(dt,on)
	if on then
		effect.setStatModifierGroup(effectHandlerList.armorBonusHandle,armorBonus)
		applySetEffects()
	else
		effect.setStatModifierGroup(effectHandlerList.armorBonusHandle,{})
	end
	checkWeapons(not on)
end

function checkWeapons(autofail)
	if autofail then effect.setStatModifierGroup(effectHandlerList.weaponBonusHandle,{}) return end
	
	local weapons=weaponCheck(weaponList)
	if weapons["either"] then
		effect.setStatModifierGroup(effectHandlerList.weaponBonusHandle,weaponBonus)
	else
		effect.setStatModifierGroup(effectHandlerList.weaponBonusHandle,{})
	end
end