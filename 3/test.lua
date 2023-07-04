--[[
    [Program] TerMonitor
    @version 1.0, 21/12/2013, "BSoD"
    @author Hellkid98, HK98
--]]

local monitors = {}
--# Getting all the monitors attached
for _, name in ipairs(peripheral.getNames()) do
    if peripheral.getType( name ) == "monitor" then
        local nMon = {}
        nMon.name = name
        table.insert(monitors, nMon)
    end
end

--# Wrapping the monitors
local w, h = term.getSize()
for i = 1,#monitors do
    monitors[i].name = peripheral.wrap(monitors[i].name)
    monitors[i]["name"].setTextScale(0.5)
    for scale = 1, 5, 0.5 do
        monitors[i]["name"].setTextScale( scale )
        local mW, mH = monitors[i]["name"].getSize()
        if mW < w or mH < h then
            monitors[i]["name"].setTextScale( scale - 0.5 )
            break
        end
    end
end




term_write = term_write or term.write
term.write = function( text )
    term_write( text )
    for i = 1,#monitors do
        monitors[i]["name"].write( text )
    end
end


term_setCursorPos = term_setCursorPos or term.setCursorPos
term.setCursorPos = function( x, y )
    term_setCursorPos( x, y )
    for i = 1,#monitors do
        monitors[i]["name"].setCursorPos( x, y )
    end
end


term_clear = term_clear or term.clear
term.clear = function()
    term_clear()
    for i = 1,#monitors do
        monitors[i]["name"].clear()
    end
end


term_clearLine = term_clearLine or term.clearLine
term.clearLine = function()
    term_clearLine()
    for i = 1,#monitors do
        monitors[i]["name"].clearLine()
    end
end


term_setCursorBlink = term_setCursorBlink or term.setCursorBlink
term.setCursorBlink = function( boolean )
    term_setCursorBlink( boolean )
    for i = 1,#monitors do
        monitors[i]["name"].setCursorBlink( boolean )
    end
end


term_scroll = term_scroll or term.scroll
term.scroll = function( num )
    term_scroll( num )
    for i = 1,#monitors do
        monitors[i]["name"].scroll( num )
    end
end


term_setTextColor = term_setTextColor or term.setTextColor
term.setTextColor = function( color )
    term_setTextColor( color )
    for i = 1,#monitors do
        monitors[i]["name"].setTextColor( color )
    end
end
term.setTextColour = term.setTextColor


term_setBackgroundColor = term_setBackgroundColor or term.setBackgroundColor
term.setBackgroundColor = function( color )
    term_setBackgroundColor( color )
    for i = 1, #monitors do
        monitors[i]["name"].setBackgroundColor( color )
    end
end
term.setBackgroundColour = term.setBackgroundColor

