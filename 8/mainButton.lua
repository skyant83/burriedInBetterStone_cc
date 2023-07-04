-- Loads the Touchpoint API
if fs.exists("buttonAPI") == false then -- load darkAPI
	print("Missing DarkAPI")
	print("Attempting to download...")
	if not http then
	  error("Enable the HTTP API to download DarkAPI")
	end
	
end

os.loadAPI("buttonAPI.lua")
os.loadAPI("bigfont.lua")

-- Searches for attached monitors and initializes two pages of buttons for each
findMon = peripheral.getNames()

for _,side in pairs(findMon) do
	local wrap = peripheral.wrap(side)
	wrap.setTextScale(0.5)

	page1 = buttonAPI.new(side)
	page2 = buttonAPI.new(side)
	print("Mon".._..": "..side)
	print(wrap.getTextScale())
end

--[[ if table.maxn(findMon) > 1 then
    error("There are too many monitors connected. Maximum of 1 monitor is allowed", 2)
    exit()
end
mon = findMon[1]
print(mon)
peripheral.wrap(mon).setTextScale(0.5)

-- Initializes two pages of buttons set on attached monitor
local page1 = buttonAPI.new(mon)
local page2 = buttonAPI.new(mon) ]]

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
function mainMenu()
	t = page1
end

-- Page2
function nextPage()
	t = page2
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
do
	page1:add("Test 1", function() toggler("Test 1", 1) end, 5, 12, 7, 13)	
	page1:add("Exit", nil, 15, 22, 7, 13)	
	page1:add("Page 2", nextPage, 25, 32, 7, 13)	
	page1:add("Test 2", function() toggler("Test 2", 1) end, 10, 17, 15, 21)	
	page1:add("Test 3", function() toggler("Test 3", 1) end, 20, 27, 15, 21)

	page2:add(newlabel, function() toggler("p2Test2", 2) end,  6, 12, 7, 13)
	page2:add("Page1", mainMenu, 15, 22, 7, 13)
	page2:add("Exit" , function() exit() end, 25, 31, 7, 13)
end

-- Draws the buttons
mainMenu()
while true do
	t:draw()
	local event, p1 = t:handleEvents(os.pullEvent())
	if event == "button_click" then
		t.buttonList[p1].func()
	end
end