local basalt = require("basalt")

local main = basalt.createFrame():setTheme({FrameBG = colors.lightGray, FrameFG = colors.black})

local id = 1
local processes = {}

local function openProgram(path, title, x, y, w, h)
    local pId = id
    id = id + 1
    local f = main:addMovableFrame()
		:setDraggingMap({{x1 = 0, y1, 0, x2 = 10, y2 = 5}})
        :setSize(w or 30, h or 12)
        :setPosition(x or math.random(2, 12), y or math.random(2, 8))

    f:addLabel()
        :setSize("parent.w", 1)
        :setBackground(colors.black)
        :setForeground(colors.lightGray)
        :setText(title or "New Program")

    f:addProgram()
        :setSize("parent.w", "parent.h - 1")
        :setPosition(1, 2)
        :execute(path or "rom/programs/shell.lua")

    f:addButton()
        :setSize(1, 1)
        :setText("X")
        :setBackground(colors.black)
        :setForeground(colors.red)
        :setPosition("parent.w", 1)
        :onClick(function()
            f:remove()
            processes[pId] = nil
        end)
    processes[pId] = f
    return f
end

openProgram("rom/programs/fun/worm.lua")

main:addButton():setPosition("parent.w - 16", 2):setText("Open"):onClick(function()
    openProgram()
end)


basalt.autoUpdate()
