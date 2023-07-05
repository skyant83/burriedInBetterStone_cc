function log( Str1, Str2 )
	-- instructions
	-- To write in you log (file) use this: log("Message"), is there a error? Use this: log("error", "Message")
	-- settings
	local logfile="logs/latest.txt" -- This is the destination where the logs and errors in writed.
	local logfiledisable=true -- To turn of the log file, change this to 'false'.
	local erroronly=false -- If this setting on 'true' then putt only errors in the log file.
	local screenlog=true -- This setting show the log file on the computer screen, to turn it off, change this to 'false'.
	local timedate=true -- This setting can you change the time to 24h or 12h (AM/PM). True = 24h, false = 12h (AM/PM)
	local senderror=false -- If this settings on 'true' then send the errors to a computer. You must be installed a rednet modem!
		local senderrorid=0 -- Change this to the ID where the errors send to.
		local closemodem=true -- This setting will close the modem after send error report.
	local ignTime = false
	local deleteOld = true

	
	if deleteOld == true then
		local files = fs.list("/logs/")
		if #files > 5 then
			log("Old logs detected")
			log("Deleting oldest files excluding the most recent 5 (including the legacy log ;))")
			local toDelete = #files - 5
			
			for i = 1, toDelete do
				local oldestFile = files[i]
				if oldestFile ~= "(oldtest logs)2023-07-05-01-43-40-AM.txt" then
					fs.delete("/logs/"..oldestFile)
				end
			end
		end
	end
	
	
	-- script
	if logfiledisable == true and not fs.exists(logfile) then
		local file=fs.open(logfile, "w")
		-- file.writeLine("-- Log script by iRichard --")
		file.writeLine("Log created on day: "..timeTable.." (IRL time).")
		file.writeLine("Log created on day: "..os.day().." at "..textutils.formatTime(os.time(), timedate).." (in-game time).")
		file.writeLine("Computer ID: "..os.getComputerID())
		file.writeLine("------------")
		file.close()
	end

	local time = os.epoch("local") / 1000
	local timeTable = os.date("%F-%I-%M-%S-%p", time)
	
	local gotlogs = fs.attributes("/logs/latest.txt")
	
	local gotTable = os.date("%F-%I-%M-%S-%p", gotlogs["modified"] / 1000)
	if fs.exists(logfile) then
		if gotTable ~= timeTable then
			fs.move("/logs/latest.txt", "/logs/"..gotTable..".txt")
		end
	end
	
	if screenlog == true then
		if Str1 == "error" or Str1 == "Error" or Str1 =="ERROR" then
			if term.isColour() then
				term.setTextColor(colors.red)
			end
			if ignTime == false then
				print("[ERROR:"..timeTable.."] "..Str2)
			else
				print("[ERROR:"..os.day().."-"..textutils.formatTime(os.time(), timedate).."] "..Str2)
			end
			if term.isColour() then
				term.setTextColor(colors.white)
			end
			if logfiledisable == true then
				local file=fs.open(logfile, "a")
				if ignTime == false then
					file.writeLine("[ERROR:"..timeTable.."] "..Str2)
				else
					file.writeLine("[ERROR:"..os.day().."-"..textutils.formatTime(os.time(), timedate).."] "..Str2)
				end
				file.close()
			end
			if senderror == true then
				for _, autoside in pairs(rs.getSides()) do
					if peripheral.getType(autoside) == "modem" then rednet.open(autoside) present = true break end
				end
				autoside = false
				if rednet.isOpen(autoside) == true then
					if ignTime == false then
						rednet.send(senderrorid, "[ERROR (ID:"..os.getComputerID()..":"..timeTable.."] "..Str2)
					else
						rednet.send(senderrorid, "[ERROR (ID:"..os.getComputerID()..":"..os.day().."-"..textutils.formatTime(os.time(), timedate).."] "..Str2)
					end
					if closemodem == true then
						rednet.close(autoside)
					end
				else
					if term.isColour() then
						term.setTextColor(colors.red)
					end
					if ignTime == false then
						print("[ERROR:"..timeTable.."] Error report not send! Rednet modem isn't open or not installed.")
					else
						print("[ERROR:"..os.day().."-"..textutils.formatTime(os.time(), timedate).."] Error report not send! Rednet modem isn't open or not installed.")
					end
					term.setTextColor(colors.white)
					if logfiledisable == true then
						if not fs.exists(logfile) then
							local file=fs.open(logfile, "w")
							-- file.writeLine("-- Log script by iRichard980 --")
							file.writeLine("Log created on: "..timeTable.." (IRL time).")
							file.writeLine("Log created on day: "..os.day().." at "..textutils.formatTime(os.time(), timedate).." (in-game time).")
							file.writeLine("Computer ID: "..os.getComputerID())
							file.writeLine("------------")
							file.close()
						end
						local file=fs.open(logfile, "a")
						if ignTime == false then
							file.writeLine("[ERROR:"..timeTable.."] Error report not send! Rednet modem isn't open or not installed.")
						else
							file.writeLine("[ERROR:"..os.day().."-"..textutils.formatTime(os.time(), timedate).."] Error report not send! Rednet modem isn't open or not installed.")
						end
						file.close()
					end
				end
			end
		else
			if ignTime == false then
				print("[LOG:"..timeTable.."] "..Str1)
			else
				print("[LOG:"..os.day().."-"..textutils.formatTime(os.time(), timedate).."] "..Str1)
			end
			if logfiledisable == true and erroronly == false then
				if not fs.exists(logfile) then
					local file=fs.open(logfile, "w")
					-- file.writeLine("-- Log script by iRichard980 --")
					if ignTime == false then
						file.writeLine("Log created on: "..timeTable.." (IRL time).")
					else
						file.writeLine("Log created on day: "..os.day().." at "..textutils.formatTime(os.time(), timedate).." (in-game time).")
					end
					file.writeLine("Computer ID: "..os.getComputerID())
					file.writeLine("------------")
					file.close()
				end
				local file=fs.open(logfile, "a")
				if ignTime == false then
					file.writeLine("[LOG:"..timeTable.."] "..Str1)
				else
					file.writeLine("[LOG:"..os.day().."-"..textutils.formatTime(os.time(), timedate).."] "..Str1)
				end
				file.close()
			end
		end
	end
end

return { log = log}