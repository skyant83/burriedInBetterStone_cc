os.loadAPI("oldAPI.lua")

monitors = {peripheral.find("monitor")}
local mon = {}
for funcName,_ in pairs(monitors[1]) do
    mon[funcName] = function(...)
        for i=1, #monitors-1 do monitor[i][funcName](unpack(arg)) end
        return monitors[#monitors][funcName](unpack(arg))
        end
    end
    
mon.clear()

function fillTable()
    oldAPI.setTable("Test1", test1, 10, 20, 3, 5)
    oldAPI.screen()
end

function getClick()
    event, side, x, y = os.pullEvent("monitor_touch")
    oldAPI.checkxy(x, y)
end

function test1()
    oldAPI.toggleButton("Test1")
    end
    
fillTable()
oldAPI.heading("Test Heading")
while true do
    getClick()
end