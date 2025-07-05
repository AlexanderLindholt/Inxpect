--!optimize 2

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
v1.2.0

A super easy and efficient API map builder for Roblox,
with plugin support and plugin cross-communication.


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

-- Services.
local StudioService = game:GetService("StudioService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

-- Map type.
type Map = {
	[string]: {
		[string]: string
	}
}

-- Tags list for validation.
local readOnlyTags = {
	ReadOnly = true,
	NotScriptable = true,
	NotCreatable = true
}
-- Types map for conversion.
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

-- Property functions.
local function isPublicProperty(member)
	if member.MemberType ~= "Property" then return end
	
	local security = member.Security
	if security ~= "None" then
		if (security.Read and security.Read ~= "None") or
			(security.Write and security.Write ~= "None") then
			return
		end
	end
	
	if member.Tags then
		for _, tag in member.Tags do
			if readOnlyTags[tag] then return end
		end
	end
	
	if member.ValueType ~= nil then return true end
end
local function translateType(valueType)
	return if valueType.Category == "Class" then
		"Instance"
		elseif valueType.Category == "Enum" then
		"Enum."..valueType.Name
		else
		types[valueType.Name] or valueType.Name
end

-- Attempt to find the plugin object. Used to check for plugin context.
local plugin = script:FindFirstAncestorOfClass("Plugin")

-- API map builder function.
local function buildMap()
	-- Let the other plugins know that we're building the map.
	if plugin then workspace:SetAttribute("APIMapCache", true) end
	
	-- Grab the latest Roblox API dump from GitHub.
	local apiDump = HttpService:JSONDecode(
		HttpService:GetAsync(
			"https://raw.githubusercontent.com/MaximumADHD/Roblox-Client-Tracker/refs/heads/roblox/API-Dump.json",
			true -- We disable caching because we only request this data once.
		)
	)
	
	-- Process data and build map.
	local map = {}
	local rawMap = {}
	for _, class in apiDump.Classes do
		rawMap[class.Name] = class
	end
	for _, class in apiDump.Classes do
		if not (class.Tags and class.Tags.NotCreatable) then
			-- The current class' properties table.
			local properties = {}
			
			-- Gather superclasses.
			local superClasses = {}
			local superClass = rawMap[class.Superclass]
			while superClass do
				table.insert(superClasses, superClass)
				superClass = rawMap[superClass.Superclass]
			end
			-- Inherit properties from superclasses.
			for index = #superClasses, 1, -1 do
				local superClass = superClasses[index]
				for _, member in superClass.Members do
					if isPublicProperty(member) then
						properties[member.Name] = translateType(member.ValueType)
					end
				end
			end
			
			-- Add local properties.
			for _, member in class.Members do
				if isPublicProperty(member) then
					properties[member.Name] = translateType(member.ValueType)
				end
			end
			
			-- Add to map.
			map[class.Name] = properties
		end
	end
	
	-- Cache map.
	if plugin then workspace:SetAttribute("APIMapCache", HttpService:JSONEncode(map)) end
	
	-- Return map.
	return map
end

-- Retrieve/build and return map.
if plugin then
	if RunService:IsRunning() then
		return HttpService:JSONDecode(workspace:GetAttribute("APIMapCache"))
	elseif not StudioService:GetAttribute("APIMapCache") then
		StudioService:SetAttribute("APIMapCache", true)
		return buildMap() :: Map
	else
		local map = workspace:GetAttribute("APIMapCache")
		if map then
			if map == true then
				-- Another plugin is building the map, so we wait for it to finish.
				workspace:GetAttributeChangedSignal("APIMapCache"):Wait()
				map = workspace:GetAttribute("APIMapCache")
			end
			return HttpService:JSONDecode(map) :: Map
		else
			return buildMap() :: Map
		end
	end
else
	return buildMap() :: Map
end
