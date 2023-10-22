local CT = LibStub("AceAddon-3.0"):GetAddon("CurrencyTracker")

function CT:SetupDatabase()
	CT.db = LibStub("AceDB-3.0"):New("CurrencyTrackerDB")
	CT.db.realm.MOA = CT.db.realm.MOA or {}
	CT.db.realm.MO = CT.db.realm.MO or {}
	CT.db.realm.MR = CT.db.realm.MR or {}
end