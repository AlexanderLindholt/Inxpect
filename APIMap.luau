--!optimize 2
--!native

--[[

+++++                                                                                               
+++++                                                                                        ++++   
+++++                                                                                        ++++   
+++++   +++++++++++++    +++++   +++++   ++++ ++++++++      ===========      ++++++++++   ++++++++++
+++++   ++++++++++++++    +++++ +++++    +++++++ ++++++    ======  =====   +++++++ ++++++   +++++   
+++++   ++++     +++++     +++++++++     +++++     +++++  =====     =====  ++++      ++++    ++++   
+++++   ++++      ++++      +++++++      ++++      +++++  =============== +++++              ++++   
+++++   ++++      ++++      +++++++      ++++      +++++  =====      ====  ++++              ++++   
+++++   ++++      ++++    +++++ ++++     +++++    ++++++  =====     =====  +++++    +++++    ++++   
+++++   ++++      ++++   +++++   +++++   ++++++++++++++    =============    ++++++++++++     +++++++
+++++   ++++      ++++  +++++     +++++  ++++  ++++++         ===========     ++++++++        ++++++
                                         ++++                        =====                          
                                         ++++                         =====                         
                                         ++++                           =====                       
                                                                         =====                      
                                                                          =====                     
                                                                            =====                   
                                                                             ===                    
v1.6.0

A super easy and efficient API map builder for Roblox,
with plugin support and smart cross-communication.


GitHub:
https://github.com/AlexanderLindholt/Inxpect

DevForum:
https://devforum.roblox.com/t/3799622


--------------------------------------------------------------------------------
MIT License

Copyright (c) 2025 Alexander Lindholt

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--------------------------------------------------------------------------------

]]--

-- A full version identifier for the map this code might generate.
local mapVersion = version().."-1.6.0" -- Roblox version + library version.

-- Attempt to get the plugin object.
local plugin = script:FindFirstAncestorOfClass("Plugin")

-- Main services.
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

-- API map type.
export type APIMap = {
	-- Classes.
	[string]: {
		-- Properties.
		[string]: {
			-- Property info.
			Type: string,
			Locked: boolean
		}
	}
}

-- Tags list for detecting accessbility.
local lockedTags = {
	ReadOnly = true,
	NotScriptable = true
}
-- Types map for translation.
local types = {
	bool = "boolean",
	int = "number",
	float = "number",
	double = "number",
	int32 = "number",
	int64 = "number",
	int16 = "number",
	int8 = "number"
}

-- Function for translating the type found in API dump into Luau type.
local function translateType(valueType)
	return if valueType.Category == "Class" then
		"Instance"
		elseif valueType.Category == "Enum" then
		"Enum."..valueType.Name
		else
		types[valueType.Name] or valueType.Name
end
-- Function for creating property data table.
local function createProperty(member)
	-- Detect accessibility.
	local locked = false
	do
		-- Check security.
		local security = member.Security
		if security ~= "None" then
			if (security.Read and security.Read ~= "None") or
				(security.Write and security.Write ~= "None") then
				locked = true
			end
		end
		-- Search tags.
		if not locked and member.Tags then
			for _, tag in member.Tags do
				if lockedTags[tag] then locked = true end
			end
		end
	end
	
	-- Build and return property data table.
	return {
		Type = translateType(member.ValueType), -- Translate the type to Luau.
		Locked = locked
	}
end

-- API map builder function.
local function buildMap()
	-- Let copies of this library know that we're building the map.
	workspace:SetAttribute("APIMapBuilding", true)
	
	-- Grab the latest Roblox API dump from GitHub.
	local success, apiDump = pcall(HttpService.GetAsync, HttpService,
		"https://raw.githubusercontent.com/MaximumADHD/Roblox-Client-Tracker/refs/heads/roblox/API-Dump.json",
		true -- Disable caching because we only request this data once.
	)
	if not success then
		workspace:SetAttribute("APIMapBuilding", nil)
		
		if plugin then
			if plugin:GetSetting("APIMapVersion") == mapVersion then
				-- Grab the map from plugin storage.
				map = plugin:GetSetting("APIMap")
				-- Store map in current place.
				workspace:SetAttribute("APIMap", map)
				workspace:SetAttribute("APIMapVersion", mapVersion)
				-- Decode and return map.
				return HttpService:JSONDecode(map)
			else
				if workspace:GetAttribute("APIMapVersion") == mapVersion then
					-- Grab the map from current place storage.
					map = workspace:GetAttribute("APIMap")
					-- Store map in plugin.
					plugin:SetSetting("APIMap", map) -- Map is already encoded btw.
					plugin:SetSetting("APIMapVersion", mapVersion)
					-- Decode and return map.
					return HttpService:JSONDecode(workspace:GetAttribute("APIMap"))
				else
					-- Grab the map from plugin storage.
					map = plugin:GetSetting("APIMap")
					if map then
						-- Store map in current place.
						workspace:SetAttribute("APIMap", map)
						workspace:SetAttribute("APIMapVersion", mapVersion)
						-- Decode and return map.
						return HttpService:JSONDecode(map)
					else
						-- Grab the map from current place storage.
						map = workspace:GetAttribute("APIMap")
						if map then
							-- Store map in plugin.
							plugin:SetSetting("APIMap", map) -- Map is already encoded btw.
							plugin:SetSetting("APIMapVersion", mapVersion)
							-- Decode and return map.
							return HttpService:JSONDecode(workspace:GetAttribute("APIMap"))
						end
					end
				end
			end
		end
		
		return
	end
	
	-- Decode the API dump.
	apiDump = HttpService:JSONDecode(apiDump)
	
	-- Build map.
	local map = {}
	local rawMap = {}
	for _, class in apiDump.Classes do
		rawMap[class.Name] = class
	end
	for _, class in apiDump.Classes do
		-- Skip classes that are not creatable.
		if (class.Tags and class.Tags.NotCreatable) then continue end
		
		-- The current class's properties table.
		local properties = {}
		
		-- Gather superclasses.
		local superclasses = {}
		local superclass = rawMap[class.Superclass]
		local index = 1
		while superclass do
			superclasses[index] = superclass
			superclass = rawMap[superclass.Superclass]
			index += 1
		end
		-- Inherit properties from superclasses.
		for index = #superclasses, 1, -1 do
			local superClass = superclasses[index]
			for _, member in superClass.Members do
				if member.MemberType == "Property" then
					properties[member.Name] = createProperty(member)
				end
			end
		end
		
		-- Add local properties.
		for _, member in class.Members do
			if member.MemberType == "Property" then
				properties[member.Name] = createProperty(member)
			end
		end
		
		-- Add to map.
		map[class.Name] = properties
	end
	
	-- Store encoded map.
	local encodedMap = HttpService:JSONEncode(map)
	workspace:SetAttribute("APIMap", encodedMap)
	workspace:SetAttribute("APIMapVersion", mapVersion)
	if plugin then
		plugin:SetSetting("APIMap", encodedMap)
		plugin:SetSetting("APIMapVersion", mapVersion)
	end
	
	-- Let copies of this library know that we're no longer building.
	workspace:SetAttribute("APIMapBuilding", nil)
	
	-- Return map.
	return map
end

-- Retrieve/build and return map.
if plugin then -- Plugin context.
	if RunService:IsRunning() then
		-- Grab, decode and return map from current place cache.
		return HttpService:JSONDecode(workspace:GetAttribute("APIMapCache")) :: APIMap
	else
		if workspace:GetAttribute("APIMapVersion") == mapVersion then
			-- Grab the map from current place storage.
			map = workspace:GetAttribute("APIMap")
			-- Store map in plugin.
			plugin:SetSetting("APIMap", map) -- Map is already encoded btw.
			plugin:SetSetting("APIMapVersion", mapVersion)
			-- Decode and return map.
			return HttpService:JSONDecode(map) :: APIMap
		else
			-- Grab the map from plugin storage.
			if plugin:GetSetting("APIMapVersion") == mapVersion then
				-- Grab the map from plugin storage.
				map = plugin:GetSetting("APIMap")
				-- Store the map in current place.
				if not workspace:GetAttribute("APIMapBuilding") then
					workspace:SetAttribute("APIMap", map) -- Map is already encoded btw.
					workspace:SetAttribute("APIMapVersion", mapVersion)
				end
				-- Decode and return map.
				return HttpService:JSONDecode(map) :: APIMap
			else
				if workspace:GetAttribute("APIMapBuilding") then
					-- A copy of this library is building the map, so we wait for it to finish.
					workspace:GetAttributeChangedSignal("APIMap"):Wait()
					
					-- Grab the map from current place storage.
					if workspace:GetAttribute("APIMapVersion") == mapVersion then
						-- Grab the map from current place storage.
						map = workspace:GetAttribute("APIMap")
						-- Store map in plugin.
						plugin:SetSetting("APIMap", map) -- Map is already encoded btw.
						plugin:SetSetting("APIMapVersion", mapVersion)
						-- Decode and return map.
						return HttpService:JSONDecode(map) :: APIMap
					else
						-- Build and return map.
						return buildMap() :: APIMap
					end
				else
					-- Build and return map.
					return buildMap() :: APIMap
				end
			end
		end
	end
else -- Game context.
	local CollectionService = game:GetService("CollectionService")
	
	local packets = CollectionService:GetTagged("Packets")[1]
	if not packets then error("Could not find packets module.") end
	packets = require(packets)
	
	if RunService:IsClient() then
		-- Request the server for the map.
		map = packets.GetAPIMap:Fire()
	else -- Server context.
		-- Retrieve or build map.
		local map
		if workspace:GetAttribute("APIMapVersion") == mapVersion then
			-- Grab and decode map.
			map = HttpService:JSONDecode(workspace:GetAttribute("APIMap"))
		else
			-- Build map.
			map = buildMap()
		end
		
		-- Setup client map retrieval.
		packets.GetAPIMap.OnServerInvoke = function()
			return map
		end
	end
	
	-- Return map.
	return map :: APIMap
end
