local CT = LibStub("AceAddon-3.0"):GetAddon("CurrencyTracker")

-- All credit for this func goes to Tekkub and his picoGuild!
function CT:GetTipAnchor(frame)
	local x, y = frame:GetCenter()
	if not x or not y then return 'TOP', 'BOTTOM' end
	local vhalf = (y > UIParent:GetHeight() / 2) and 'TOP' or 'BOTTOM'
	return vhalf, frame, (vhalf == 'TOP' and 'BOTTOM' or 'TOP')
end

function CT:MakeSortedCharacterTable(list)
	sorted = {}
	for character, count in pairs(list) do
		table.insert(sorted, {character=character,count=count})
	end
	table.sort(sorted,function(a,b) return a.character < b.character end)
	return sorted
end

function CT:MakeIcons()
	CT.marksIcon = IconClass("Interface\\Icons\\Mail_GMIcon"):GetIconString()
	CT.orbsIcon = IconClass("Interface\\Icons\\inv_custom_CollectionRCurrency"):GetIconString()
	CT.runesIcon = IconClass("Interface\\Icons\\inv_custom_ReforgeToken"):GetIconString()
end

function CT:ReturnIcon(selected)
	if selected == "MOA" then
		return CT.marksIcon
	elseif selected == "MO" then
		return CT.orbsIcon
	elseif selected == "MR" then
		return CT.runesIcon
	end
end

function CT:SetSelectedCurrency(value)
  CT.db.global.displayCurrency = value
	CT:updateCurrency()
end
