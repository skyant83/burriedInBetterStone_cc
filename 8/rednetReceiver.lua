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

local filter = "" -- Enter your protocol filter here

--* Checks the Broadcast Channel for messages with the protocol filter attached for responses
local _, message = rednet.receive(filter)