os.loadAPI("bigfont.lua")

-- Finds all Connected Monitors
monitors = {peripheral.find("monitor")}
local mon = {}
local fontSize = 0
for funcName,_ in pairs(monitors[1]) do
	mon[funcName] = function(...)
		for i=1,#monitors-1 do monitors[i][funcName](unpack(arg)) end
		return monitors[#monitors][funcName](unpack(arg))
	end
end

-- Sets Default settings
function setSize(size)
	mon.setTextScale(size)
end

function bigFontSize(size)
	fontSize = size
end

-- Creates a modifiable Text Color
function setMonTxtColor(color)
	mon.setTextColor(color)
end

local button={}

-- Creates a modifiable Background Color
function setMonBgColor(color)
	mon.setBackgroundColor(colors.black)
end

function clearTable()
   button = {}
end

function setButton(name, buttonOn)
   print(name)
   print(button[name]["active"])
   button[name]["active"] = buttonOn
   screen()
end

function setTable(name, func, param, xmin, xmax, ymin, ymax)
   button[name] = {}
   button[name]["func"] = func
   button[name]["active"] = false
   button[name]["param"] = param
   button[name]["xmin"] = xmin
   button[name]["xmax"] = xmax
   button[name]["ymin"] = ymin
   button[name]["ymax"] = ymax
end

function funcName()
   print("You clicked buttonText")
end
        
function fillTable()
   setTable("ButtonText", funcName, 5, 25, 4, 8)
end     

function fill(text, color, bData)
   mon.setBackgroundColor(color)
   print("string length:"..string.len(text))
   print("box length: "..bData["xmax"]-bData["xmin"]+1)
   print("param: "..tostring(bData["param"]).." xmin: "..bData["xmin"].." xmax: "..bData["xmax"].." ymin: "..bData["ymin"].." ymax: "..bData["ymax"])
   local yspot = math.floor((bData["ymin"] + bData["ymax"]) /2)
   local xspot = math.floor((bData["xmax"] - bData["xmin"] - string.len(text)) /2) +1
   for j = bData["ymin"], bData["ymax"] do
      mon.setCursorPos(bData["xmin"], j)
      if j == yspot then
         for k = 0, bData["xmax"] - bData["xmin"] - string.len(text) +1 do
            if k == xspot then
               mon.write(text)
            else
               mon.write(" ")
            end
         end
      else
         for i = bData["xmin"], bData["xmax"] do
            mon.write(" ")
         end
      end
   end
   mon.setBackgroundColor(colors.black)
end

function screen()
   local currColor
   for name,data in pairs(button) do
      local on = data["active"]
      if on == true then currColor = colors.lime else currColor = colors.red end
      fill(name, currColor, data)
   end
end

function toggleButton(name)
   button[name]["active"] = not button[name]["active"]
   screen()
end     

function flash(name)
   toggleButton(name)
   screen()
   sleep(0.15)
   toggleButton(name)
   screen()
end

function checkxy(x, y)
   for name, data in pairs(button) do
      if y>=data["ymin"] and  y <= data["ymax"] then
         if x>=data["xmin"] and x<= data["xmax"] then
            if data["param"] == " " then
              data["func"]()
            else
              data["func"](data["param"])
            end
            return true
            --data["active"] = not data["active"]
            --print(name)
         end
      end
   end
   return false
end

function heading(text, align)
   w, h = mon.getSize()
   -- mon.setCursorPos((w-string.len(text))/2+1, 1)
   -- mon.write(text)
   bigfont.writeOn(mon, fontSize, text, (w-string.len(text))/2-align, 2)
end
     
function label(w, h, text)
   mon.setCursorPos(w, h)
   mon.write(text)
end