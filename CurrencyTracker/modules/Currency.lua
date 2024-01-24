local CT = LibStub("AceAddon-3.0"):GetAddon("CurrencyTracker")
local LibDB = LibStub:GetLibrary("LibDataBroker-1.1")
local ldbData = LibDB:NewDataObject("Ascension Currency", {
	type = "data source",
	text = "Currency",
	icon = ""
})

function CT:updateCurrency()
	local currency = CT.db.global.displayCurrency or "MOA"
	local icon = CT:ReturnIcon(currency)
	ldbData.text = icon .. "  " .. CT.db.realm[currency][CT.PlayerName]
end

local function fillTooltip()
	local tt = GameTooltip
	tt:ClearLines()
	tt:AddLine("     Ascension Currency: Runes, Orbs, Marks")
	local sorted = CT:MakeSortedCharacterTable(CT.db.realm.MOA)
	for _, obj in pairs(sorted) do
		tt:AddDoubleLine(obj.character, CT.runesIcon .. CT.db.realm.MR[obj.character] .. "     " .. CT.orbsIcon .. CT.db.realm.MO[obj.character] .. "     " .. CT.marksIcon .. obj.count, 1, 1, 1)
	end

	tt:AddLine(" ")
	tt:AddLine("Open Currency Panel: Left Click")
	tt:AddLine("Change Datatext Currency: Right Click")
	tt:AddLine("Reset Data: Hold Shift + Right Click")
end

function ldbData.OnEnter(self)
	local tt = GameTooltip
	tt:SetOwner(self, 'ANCHOR_NONE')
	tt:SetPoint(CT:GetTipAnchor(self))
	fillTooltip()
	tt:Show()
end

function ldbData.OnLeave(self)
	GameTooltip:Hide()
end

local menuFrame
local function CurrencySelectorDropdown(self)
	if not menuFrame then
		menuFrame = CreateFrame("Frame", "CurrencySelectionFrame", self, "UIDropDownMenuTemplate")
		menuFrame:ClearAllPoints()
		menuFrame:SetPoint(CT:GetTipAnchor(self))
	end
	local menu = {
		{text = "Select a currency:", notCheckable = true, isTitle = true},
		{text = "Marks of Ascension", notCheckable = true, func = function() CT:SetSelectedCurrency("MOA") menuFrame:Hide() end},
		{text = "Mystic Orbs", notCheckable = true, func = function() CT:SetSelectedCurrency("MO") menuFrame:Hide() end},
		{text = "Mystic Runes", notCheckable = true, func = function() CT:SetSelectedCurrency("MR") menuFrame:Hide() end},
	}
	EasyMenu(menu,menuFrame,menuFrame, 0, 0, "MENU")
end

function ldbData.OnClick(self, button)
	if IsShiftKeyDown() and button == "RightButton" then
		CT.db.realm.MOA = {}
		CT.db.realm.MO = {}
		CT.db.realm.MR = {}
		CT:updateMarks()
		CT:updateOrbs()
		CT:updateRunes()
		CT:updateCurrency()
		fillTooltip()
	elseif button == "RightButton" then
		GameTooltip:Hide()
		CurrencySelectorDropdown(self)
	elseif button == "LeftButton" then
		ToggleCharacter("TokenFrame")
	end
end
