-- Looks for Monitor - Returns Location in Table format
monLocate = peripheral.getNames()

-- Checks if more than one monitor is connectate
if table.maxn(monLocate) > 1
    then error("more than one monitor is found", 2) 
    exit()
else
	monitor = peripheral.wrap(monLocate[1])
end
    

-- Connects to Monitor
-- monitor = peripheral.wrap(monLocate[1])

-- Gets Monitor Size
w, h = monitor.getSize()
monitor.clear()

function iterate(iteratorMaxCount, currentNumber)
    if currentNumber < iteratorMaxCount then
        currentNumber = currentNumber + 1
        return currentNumber
    end
end

function draw()
	coordTable = {1, 1, 1, 1}
	for i in iterate,1,2 do
		event, side, xPos, yPos = os.pullEvent("monitor_touch")
		table.insert(coordTable, xPos)
		table.insert(coordTable, yPos)
		monitor.clear()
	end
	term.redirect(monitor)
	paintutils.drawFilledBox(coordTable[1],coordTable[2], coordTable[3], coordTable[4], colors.white)

end

while true do
    -- Wait for player to touch/interact with screen
    -- Returns the name of the event, side monitor was on, xPos and yPos of where event occured
    -- event, side, xPos, yPos = os.pullEvent("monitor_touch")
    
    -- monitor.clear()
    
    -- -- Displays coordinates
    -- info = "x:"..xPos..", y:"..yPos
    -- monitor.setCursorPos(w/2-#info/2, h/2)
    -- monitor.write(info)
	
	draw()
end
    
