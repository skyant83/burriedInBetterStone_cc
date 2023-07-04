os.loadAPI("buttonAPI.lua")
-- os.LoadAPI("bigfont.lua")

buttonAPI.bigFontSize(1)

monitors = {peripheral.find("monitor")}
local mon = {}
for funcName,_ in pairs(monitors[1]) do
    mon[funcName] = function(...)
        for i=1, #monitors-1 do monitor[i][funcName](unpack(arg)) end
        return monitors[#monitors][funcName](unpack(arg))
        end
    end

mon.clear()

-- buttonAPI.setSize(0.5)

local texttest = {
	"123456789",
	"123456789",
	label = "abutton"
}

function itemSelector()
	print("page1")
	buttonAPI.clearTable()
	mon.clear()
	buttonAPI.heading("Select Item:", 10)
    buttonAPI.setTable("Test 1", test1, " ", 5, 12, 7, 13)
	buttonAPI.setTable("Exit", stop, " ", 15, 22, 7, 13)
	buttonAPI.setTable("Page 2", nextP, " ", 25, 32, 7, 13)
	buttonAPI.setTable("Test 2", test2, " ", 10, 17, 15, 21)
	buttonAPI.setTable(texttest, test2, " ", 20, 27, 15, 21)
    buttonAPI.screen()
end

function nextP()
	print("page2")
	buttonAPI.clearTable()
	mon.clear()
	buttonAPI.setTable("Test2", test2, " ", 6, 12, 7, 13)
	buttonAPI.setTable("Page1", itemSelector, " ", 15, 22, 7, 13)
	buttonAPI.setTable("Exit", stop, " ", 25, 31, 7, 13)
	buttonAPI.screen()
end

function getClick()
    event, side, x, y = os.pullEvent("monitor_touch")
    buttonAPI.checkxy(x, y)
end

function test1()
    buttonAPI.toggleButton("Test1")
	print("1 clicked")
    end
	
function test2()
    buttonAPI.toggleButton("Test2")
	print("2 clicked")
    end
	
function stop()
	mon.clear()
	exit()
end
    
itemSelector()
while true do
    getClick()
end