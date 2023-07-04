-- Loads Basalt API into basalt variable
local basalt = require("basalt")

-- Searches for connected monitors
monitors = {peripheral.find("monitor")}
local mon = {}
for funcName,_ in pairs(monitors[1]) do
	mon[funcName] = function(...)
		for i=1,#monitors-1 do monitors[i][funcName](unpack(arg)) end
		return monitors[#monitors][funcName](unpack(arg))
	end
end

-- Sets Text Scale
-- mon.setTextScale(0.5)

-- Adds basalt onto the monitor
local monitorFrame = basalt.addMonitor()
monitorFrame:setMonitor(mon)
-- monitorFrame:setOffset(-1, 0)

local header = monitorFrame
	:addLabel()
	:setText("Select Item:")
	-- :setPosition(2, 1)
	:setTextAlign("right")
	-- :setFontSize(1)

-- local button = monitorFrame
	-- :addButton()
	-- :setPosition(4, 4)
	-- :setSize(16, 3)
	-- :setText("Click me!")
	-- :onClick(
		-- function()
			-- basalt.debug("I got clicked!")
		-- end)
	
basalt.autoUpdate()
