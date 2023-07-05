-- todo: add annotations

function errorCheck(func)
	local success, result = pcall(func)
	if not success then
		return true
	else
		return false, result
	end
end

-- Function to convert variable name to string
function getVariableName(var)
	local localVarName
	local localVarValue

	-- Iterate over the local variables in the current stack frame
	local i = 1
	while true do
		localVarName, localVarValue = debug.getlocal(2, i)
		if not localVarName then
			break
		end

		-- Check if the variable value matches the given var
		if localVarValue == var then
			return localVarName
		end

		i = i + 1
	end

	-- If the variable name was not found, return nil or an empty string
	return nil
end

local isEmptyVar = {
	log = function(self, ...)
		local arguments = { ... }

		for i, arg in ipairs(arguments) do
			if type(arg) == "userdata" or type(arg) == "table" then

				local success, result = pcall(logger.log)
				if not success then
					if arg ~= nil then
						print("logAPI is unavailable, however "..getVariableName(arg).." is not empty: "..tostring(arg))
					elseif arg == nil then
						print("logAPI is unavailable, however "..getVariableName(arg).." is empty")
					end
				else
					if arg ~= nil then
						logger.log(getVariableName(arg).." is not empty: "..arg)
					elseif arg == nil then
						logger.log("error", getVariableName(arg).." is empty")
					end
				end
			else
				error("invalid argument at index "..i..": expected variable - "..tostring(arg), 0)
			end
		end
	end,
	check = function(self, ...)
		local arguments = { ... }
		local boolean = false
		for i, arg in ipairs(arguments) do
			if type(arg) == "userdata" or type(arg) =="table" then
				if arg ~= nil then
					boolean = false
				elseif arg == nil then
					boolean = true
				end
			else
				error("invalid argument at index "..i..": expected variable - "..tostring(arg), 0)
			end
		end
		return boolean
	end
}
