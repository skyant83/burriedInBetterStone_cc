--* Checks for the existance of the required API files
if fs.exists("buttonAPI.lua") == false then -- Downloads buttonAPI
	print("Missing buttonAPI")
	print("Attempting to download...")
	if not http then
		error("Enable the HTTP API to download buttonAPI")
	end
	getGit = http.get("https://raw.github.com/skyant83/burriedInBetterStone_cc/main/8/buttonAPI.lua")
	getGit = getGit.readAll()
	file = fs.open("buttonAPI.lua", "w")
	file.write(getGit)
	file.close()
end
if fs.exists("bigfont.lua") == false then -- Downloads bigfont
	print("Missing bigfont")
	print("Attempting to download...")
	if not http then
		error("Enable the HTTP API to download bigfont")
	end
	getGit = http.get("https://raw.github.com/skyant83/burriedInBetterStone_cc/main/8/bigfont.lua")
	getGit = getGit.readAll()
	file = fs.open("bigfont.lua", "w")
	file.write(getGit)
	file.close()
end
if fs.exists("logger.lua") == false then -- Downloads logger
	print("Missing logger")
	print("Attempting to download...")
	if not http then
		error("Enable the HTTP API to download logger")
	end
	getGit = http.get("https://raw.github.com/skyant83/burriedInBetterStone_cc/main/8/logger.lua")
	getGit = getGit.readAll()
	file = fs.open("logger.lua", "w")
	file.write(getGit)
	file.close()
end
if fs.exists("debugCommands.lua") == false then -- Downloads debugCommands
	print("Missing debugCommands")
	print("Attempting to download...")
	if not http then
		error("Enable the HTTP API to download debugCommands")
	end
	getGit = http.get("https://raw.github.com/skyant83/burriedInBetterStone_cc/main/8/debugCommands.lua")
	getGit = getGit.readAll()
	file = fs.open("debugCommands.lua", "w")
	file.write(getGit)
	file.close()
end

local fontSize = 1
local headText = nil
local headAdjustment = 0
local textColor = colors.white
local textBGColor = colors.black

--* Loads the All APIs
buttonAPI = require("buttonAPI")
bigfont = require("bigfont")
logger = require("logger")
debugger = require("debugCommands")
if buttonAPI ~= nil and bigfont ~= nil and logger ~= nil then
	logger.log("APIs have been loaded")
else
	error("Failed to load APIs", 0)
end

--* Searches for attached monitors and initializes two pages of buttons for each
log("Searching for attached monitors")
findPeripheral = peripheral.getNames()
isEmptyVar:log(findPeripheral)

function makePages(side)
	--* Initializes two pages of buttons set on attached Monitor
	mainPage = buttonAPI.new(side)
	item1 = buttonAPI.new(side)
	item2 = buttonAPI.new(side)
	item3 = buttonAPI.new(side)
	item4 = buttonAPI.new(side)
	item5 = buttonAPI.new(side)
	log("Main Menu initialized: " .. tostring(isEmptyVar:check(mainPage)))
	log("Item 1 initialized: " .. tostring(isEmptyVar:check(item1)))
	log("Item 2 initialized: " .. tostring(isEmptyVar:check(item2)))
	log("Item 3 initialized: " .. tostring(isEmptyVar:check(item3)))
	log("Item 4 initialized: " .. tostring(isEmptyVar:check(item4)))
	log("Item 5 initialized: " .. tostring(isEmptyVar:check(item5)))
end

if table.maxn(findPeripheral) > 1 and notContainValue(findPeripheral, "modem") then
	logger.log("error", "There are too many monitors connected. Maximum of 1 monitor is allowed")
	logger.log("error", "Support for multiple montiros have yet to be implenented")
	error("There are too many monitors connected. Maximum of 1 monitor is allowed", 2)
	error("Support for multiple montiros have yet to be implenented", 0)
	error()
elseif table.maxn(findPeripheral) > 2 and containsValue(findPeripheral, "modem") then
	logger.log("error", "Too many peripherals are connected. Please check all sides of the device.")
	logger.log("error", "Support for multiple montiros have yet to be implenented")
	error("Support for multiple montiros have yet to be implenented", 0)
end

for i, side in pairs(findPeripheral) do
	wrap = peripheral.wrap(side)
	if isEmptyVar:check(wrap) == true then
		error("error in wrapping peripherals", 0)
	else
		if peripheral.getType(side) == "monitor" then
			logger.log("Monitor " .. i .. ": (" .. side .. ") wrapped")
			logger.log("Starting Scale: " .. wrap.getTextScale())
			wrap.setTextScale(0.5)
			logger.log("Set Scale: " .. wrap.getTextScale())
			makePages(side)
		elseif side == "modem" then
			rednet.open(wrap)
			log("RedNet for modem: " .. side .. " has is now able to send and receive messages over rednet.")
		end
	end
end

--* Page number variable
local t

function sendRednet(message, protocol)

end

function toggler(name, refPage)
	local pages = {
		menuPage = function()
			t = mainPage
			
			mainPage:toggleButton(name)
		end,
		firstPage = function()
			t = item1
		end,
		secondPage = function()
			t = item2
		end,
		thirdPage = function()
			t = item3
		end,
		fourthPage = function()
			t = item4
		end,
		fifthPage = function()
			t = item5
		end,
	}
	local action = pages[refPage]
	if type(action) == "function" then
		action()
	else
		print("Selected fruit: " .. refPage)
	end

	--// if page == 1 then
		--// mainPage:toggleButton(name)
	--// elseif page == 2 then
		--// item3:toggleButton(name)
	--// else
		--// error("page non-existant", 2)
	--// end
end

function heading(text, align)
	w, h = wrap.getSize()
	--// print(align, w, h)
	--// print(wrap, fontSize, text, (w - string.len(text)) / 2 - align, 2 )
	--// wrap.setCursorPos((w-string.len(text))/2+1, 1)
	--// wrap.write(text)
	bigfont.writeOn(wrap, fontSize, text, (w - string.len(text)) / 2 - align, 2)
end

--* Main Menu
function mainMenu()
	t = mainPage
	headText = "Pick your item:"
	headAdjustment = 14
end

--// function pItem1()
--//	   t = item1
--// end
--// function pItem2()
--//	   t = item2
--// end
--// function pItem3()
--//	   t = item3
--// end
--// function pItem4()
--//	   t = item4
--// end
--// function pItem5()
--//	   t = item5
--// end

--* Incase of long button text
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

--* Clears the monitor and
function endProg()
	local computerTerminal = term.redirect(wrap)
	term.setBackgroundColor(colors.black)
	wrap.setTextScale(1)
	term.clear()
	term.redirect(computerTerminal)
	error()
end

--* Initialize pages and their buttons
do
	--* Main Menu
	mainPage:add("Item 1", function() toggler("Item 1", "menuPage") end, 5, 12, 7, 13)
	mainPage:add("Item 2", function() toggler("Item 2", "menuPage") end, 15, 22, 7, 13)
	mainPage:add("Item 3", function() toggler("Item 3", "menuPage") end, 25, 32, 7, 13)
	mainPage:add("Item 4", function() toggler("Item 4", "menuPage") end, 10, 17, 15, 21)
	mainPage:add("Item 5", function() toggler("Item 5", "menuPage") end, 20, 27, 15, 21)
	
	--* 3rd Item Page
	item3:add(newlabel, function() toggler("testlabel", "thirdPage") end, 6, 12, 7, 13)
	item3:add("Page1", mainMenu, 15, 22, 7, 13)
	item3:add("Exit", function() endProg() end, 25, 31, 7, 13)
end


--* Draws the buttons
mainMenu()
while true do
	t:draw()
	heading(headText, headAdjustment)
	local event, p1 = t:handleEvents(os.pullEvent())
	if event == "button_click" then
		t.buttonList[p1].func()
	end
end
