-- Loads the Touchpoint API
buttonAPI = require("buttonAPI.lua")
bigfont = require("bigfont.lua")

-- Searches for attached monitors and initializes two pages of buttons for each
findMon = peripheral.getNames()

local screen = {}
local fontSize = 0

--[[ function paging(mon, page)
	-- screen[mon] = buttonAPI.new(side)
	-- screenNumber[mon] = {}
	screen[mon][page] = page
end ]]

for i, side in ipairs(findMon) do
	local wrap = peripheral.wrap(side)
	wrap.setTextScale(0.5)
	
	print("Mon"..i..": "..side)
	print(wrap.getSize())

	screen[i]["page1"] = buttonAPI.new(side)
	screen[i]["page2"] = buttonAPI.new(side)
--[[ 	paging(i, "page1")
	paging(i, "page2") ]]
	
	-- page[i] = buttonAPI.new(side)

	-- Debug information about monitor number, location & size
end

--[[ if table.maxn(findMon) > 1 then
    error("There are too many monitors connected. Maximum of 1 monitor is allowed", 2)
    exit()
end
mon = findMon[1]
print(mon)
peripheral.wrap(mon).setTextScale(0.5) ]]

-- Initializes two pages of buttons set on attached monitor
local page1 = buttonAPI.new(mon)
local page2 = buttonAPI.new(mon)

-- Page number variable
local t

function toggler(name, page)
	if page == 1 then
		page1:toggleButton(name)
	elseif page == 2 then
		page2:toggleButton(name)
	else
		error("page non-existant", 2)
	end
end

function heading(text, align)
	w, h = mon.getSize()
	-- mon.setCursorPos((w-string.len(text))/2+1, 1)
	-- mon.write(text)
	bigfont.writeOn(mon, fontSize, text, (w-string.len(text))/2-align, 2)
end

-- Main Menu
function mainMenu(i) -- the i is temprorary to stop warnings
	t = screen[i]["page1"]
end

-- Page2
function nextPage(i)
	t = screen[i]["page2"]
end

-- Incase of long button text
local newlabel = {
	"       ",
	"       ",
	"  p 2  ",
	" Test2 ",
	"       ",
	"       ",
	"       ",
	label = "testlabel"
}

-- Initialize two pages and their buttons
for i = 1, #screen do
	screen[i]["page1"]:add("Test 1", function() toggler("Test 1", 1) end, 5, 12, 7, 13)	
	screen[i]["page1"]:add("Exit", nil, 15, 22, 7, 13)	
	screen[i]["page1"]:add("Page 2", nextPage, 25, 32, 7, 13)	
	screen[i]["page1"]:add("Test 2", function() toggler("Test 2", 1) end, 10, 17, 15, 21)	
	screen[i]["page1"]:add("Test 3", function() toggler("Test 3", 1) end, 20, 27, 15, 21)

	screen[i]["page2"]:add(newlabel, function() toggler("p2Test2", 2) end,  6, 12, 7, 13)
	screen[i]["page2"]:add("Page1", mainMenu, 15, 22, 7, 13)
	screen[i]["page2"]:add("Exit" , function() error() end, 25, 31, 7, 13)
end

-- Draws the buttons
mainMenu()
while true do
	t:draw()
	local event = os.pullEvent()
	for i = 1, #screen do
		event = {screen[i]:handleEvents(unpack(event))}
	end
	if event[1] == "button_click" then
		screen[1].buttonList[event[2]].func()
	end
end