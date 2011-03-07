local mod	= DBM:NewMod("Kilnara", "DBM-Party-Cataclysm", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision$"):sub(12, -3))
mod:SetCreatureID(52059)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnTears		= mod:NewSpellAnnounce(96435, 3)
local warnLash		= mod:NewTargetAnnounce(96958, 3)
local warnWail		= mod:NewSpellAnnounce(96948, 2)
local warnWaveAgony	= mod:NewSpellAnnounce(96457, 3)
local warnRavage	= mod:NewTargetAnnounce(96592, 3)
local warnCamouflage	= mod:NewSpellAnnounce(96594, 3)

local timerTears	= mod:NewBuffActiveTimer(6, 96435)
local timerLash		= mod:NewTargetTimer(10, 96958)
local timerWaveAgony	= mod:NewCDTimer(32, 96457)
local timerRavage	= mod:NewTargetTimer(10, 96592)
local timerCamouflage	= mod:NewBuffActiveTimer(24, 96594)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(96435) then	-- Tears of Blood, CD 27-37 secs
		warnTears:Show()
		timerTears:Start()
	elseif args:IsSpellID(96958) then
		warnLash:Show(args.destName)
		timerLash:Start(args.destName)
	elseif args:IsSpellID(96592) then
		warnRavage:Show()
		timerRavage:Start()
	elseif args:IsSpellID(96594) then
		warnCamouflage:Show()
		timerCamouflage:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(96948) then
		warnWail:Show()
	elseif args:IsSpellID(96457) then
		warnWaveAgony:Show()
		timerWaveAgony:Start()
	end
end