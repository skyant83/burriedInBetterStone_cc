--# Load the Touchpoint API
os.loadAPI("api.lua")

--# Find Connected Monitors
findMon = peripheral.getNames()
if table.maxn(findMon) > 1 then
    error("There are too many monitors connected. Maximum of 1 monitor is allowed", 2)
    exit()
end
mon = findMon[1]
print(mon)
peripheral.wrap(mon).setTextScale(0.5)
-- peripheral.wrap(mon).write("test")

--# Establish Two Pagesbutton
local page1 = api.new(mon)
local page2 = api.new(mon)

--# Page Number Variable
local t 

function pg2()
	t = page2
end

function pg1()
	page1:toggleButton("p1Button1")
end

function mainTable()
	t = page1
end

do
	page1:add("p1Button1", pg1, 2,2,12,9)
	page1:add("p1Button2_NextPage", pg2, 16,2,28,11)
	
	page2:add("p2Button1", nil , 2,2,12,9)
	page2:add("p2Button2_BackPage", mainTable, 16,2,28,11)
end


--# Main Menu

mainTable()
while true do
	t:draw()
	local event, p1 = t:handleEvents(os.pullEvent())
	if event == "button_click" then
		t.buttonList[p1].func()
	end
end


-- Add two Buttons
-- t:add("left", nil, 2,2,14,11, colors.red, colors.lime)
-- t:add("right", nil, 16,2,28,11, colors.red, colors.lime)

-- Draw the Buttons
-- t:draw()
