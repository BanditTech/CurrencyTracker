local CT = LibStub("AceAddon-3.0"):GetAddon("CurrencyTracker")

function CT:OnEnable()
	CT.PlayerName = UnitName("player")
	CT:MakeIcons()
	CT:updateMarks()
	CT:updateOrbs()
	CT:updateRunes()
	CT:updateCurrency()
end

function CT:OnInitialize()
	CT:SetupDatabase()
	CT:RegisterBucketEvent({"CURRENCY_DISPLAY_UPDATE"},.1,function()
		CT:updateMarks()
		CT:updateOrbs()
		CT:updateRunes()
		CT:updateCurrency()
	end)
	CT:RegisterBucketEvent({"MYSTIC_ENCHANT_REFORGE_RESULT"},.1,function()
		CT:updateOrbs()
		CT:updateRunes()
		CT:updateCurrency()
	end)
end