local CT = LibStub("AceAddon-3.0"):GetAddon("CurrencyTracker")
local LibDB = LibStub:GetLibrary("LibDataBroker-1.1")
local ldbData = LibDB:NewDataObject("Mystic Runes", {
	type = "data source",
	text = "",
	icon = ""
})

function CT:updateRunes()
	local count = GetItemCount(98462)
	CT.db.realm.MR[CT.PlayerName] = count
	ldbData.text = CT.runesIcon .. " " .. count
end


local function fillTooltip()
	local tt = GameTooltip
	tt:ClearLines()
	tt:AddLine("               Mystic Runes")
	local sorted = CT:MakeSortedCharacterTable(CT.db.realm.MR)
	for _, obj in pairs(sorted) do
		tt:AddDoubleLine(obj.character, CT.runesIcon .. obj.count)
	end

	tt:AddLine(" ")
	tt:AddLine("Open Currency Panel: Left Click")
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

function ldbData.OnClick(self, button)
	if IsShiftKeyDown() and button == "RightButton" then
		CT.db.realm.MR = {}
		CT:updateRunes()
		fillTooltip()
	elseif button == "LeftButton" then
		ToggleCharacter("TokenFrame")
	end
end
