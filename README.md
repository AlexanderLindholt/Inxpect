<div align="center">

<img src="./Logo.png"></img>


A super easy and efficient API map builder for Roblox,<br>
with plugin support and smart cross-communication.

[<img src="https://raw.githubusercontent.com/AlexanderLindholt/LinkButtons/refs/heads/main/Static/Module.png"></img>](https://create.roblox.com/store/asset/136538514747004) ​ [<img src="https://raw.githubusercontent.com/AlexanderLindholt/LinkButtons/refs/heads/main/Static/Devforum.png"></img>](https://devforum.roblox.com/t/3799622)
</div>
<br>
​<br>
<br>

#  🥷 The hidden Roblox API
On Roblox there is no built-in way to view the API<br>
and e.g. see which properties a certain instance has.

Inxpect allows you to easily inspect what was otherwise hidden.

<br>

# ✨ Fast, easy, smart.
It's super efficient, easy-to-use, and has full plugin support.

It will intelligently communicate with copies of itself (from other plugins / elsewhere in the game),<br>
ensuring **only 1 script is doing the hard job**. The one working will share the finished map with the rest.

In plugins, it even works offline AND while the game is running.<br>
This is possible due to its intelligent caching.<br>
<br>

Additionally, the syntax can't get any simpler!
```luau
local apiMap = require(script.APIMap) -- Inxpect is named 'APIMap' — since that makes sense.
```
<br>

Don't worry, it provides only what's important:
```luau
{
	-- Classes.
	string = {
		-- Properties.
		string = {
			-- Property data.
			Type = string
			Writable = boolean
		}
	}
}
```

<br>

# 💡 Example:
```luau
local apiMap = require(script.APIMap) -- 'APIMap' is Inxpect.

local function printProperties(class)
	local properties = apiMap[class]
	
	local output = class.."'s properties:"
	for name, data in properties do
		output ..=
			"\n\n    Name: "..name..
			"\n    Type: "..data.Type..
			"\n    Writable: "..tostring(data.Writable)
	end
	print(output)
end
printProperties("Part")
```
<details>
<summary>💡 See output</summary>

```
Part's properties:

    Name: RightParamB
    Type: number
    Writable: true

    Name: CFrame
    Type: CFrame
    Writable: true

    Name: RightSurface
    Type: Enum.SurfaceType
    Writable: true

    Name: Mass
    Type: number
    Writable: false

    Name: archivable
    Type: boolean
    Writable: true

    Name: Friction
    Type: number
    Writable: true

    Name: FrontParamB
    Type: number
    Writable: true

    Name: BottomSurface
    Type: Enum.SurfaceType
    Writable: true

    Name: ExtentsSize
    Type: Vector3
    Writable: false

    Name: CollisionGroup
    Type: string
    Writable: true

    Name: AssemblyMass
    Type: number
    Writable: false

    Name: AssemblyLinearVelocity
    Type: Vector3
    Writable: true

    Name: Elasticity
    Type: number
    Writable: true

    Name: FrontParamA
    Type: number
    Writable: true

    Name: MaterialVariant
    Type: string
    Writable: true

    Name: RightParamA
    Type: number
    Writable: true

    Name: Parent
    Type: Instance
    Writable: true

    Name: Massless
    Type: boolean
    Writable: true

    Name: CollisionGroupId
    Type: number
    Writable: true

    Name: AssemblyRootPart
    Type: Instance
    Writable: false

    Name: Locked
    Type: boolean
    Writable: true

    Name: Material
    Type: Enum.Material
    Writable: true

    Name: Size
    Type: Vector3
    Writable: true

    Name: BackSurface
    Type: Enum.SurfaceType
    Writable: true

    Name: LocalTransparencyModifier
    Type: number
    Writable: true

    Name: CustomPhysicalProperties
    Type: PhysicalProperties
    Writable: true

    Name: Rotation
    Type: Vector3
    Writable: true

    Name: ReceiveAge
    Type: number
    Writable: false

    Name: Name
    Type: string
    Writable: true

    Name: className
    Type: string
    Writable: false

    Name: RobloxLocked
    Type: boolean
    Writable: false

    Name: LeftParamA
    Type: number
    Writable: true

    Name: CastShadow
    Type: boolean
    Writable: true

    Name: PivotOffset
    Type: CFrame
    Writable: true

    Name: Origin
    Type: CFrame
    Writable: false

    Name: TopSurfaceInput
    Type: Enum.InputType
    Writable: true

    Name: Anchored
    Type: boolean
    Writable: true

    Name: FrontSurfaceInput
    Type: Enum.InputType
    Writable: true

    Name: BottomParamB
    Type: number
    Writable: true

    Name: AssemblyAngularVelocity
    Type: Vector3
    Writable: true

    Name: Capabilities
    Type: SecurityCapabilities
    Writable: true

    Name: BottomSurfaceInput
    Type: Enum.InputType
    Writable: true

    Name: CanCollide
    Type: boolean
    Writable: true

    Name: Sandboxed
    Type: boolean
    Writable: true

    Name: EnableFluidForces
    Type: boolean
    Writable: true

    Name: LeftSurface
    Type: Enum.SurfaceType
    Writable: true

    Name: AudioCanCollide
    Type: boolean
    Writable: true

    Name: Transparency
    Type: number
    Writable: true

    Name: ExtentsCFrame
    Type: CFrame
    Writable: false

    Name: ClassName
    Type: string
    Writable: false

    Name: Orientation
    Type: Vector3
    Writable: true

    Name: CanQuery
    Type: boolean
    Writable: true

    Name: AssemblyCenterOfMass
    Type: Vector3
    Writable: false

    Name: brickColor
    Type: BrickColor
    Writable: true

    Name: Pivot Offset
    Type: CFrame
    Writable: false

    Name: ResizeableFaces
    Type: Faces
    Writable: false

    Name: Reflectance
    Type: number
    Writable: true

    Name: FrontSurface
    Type: Enum.SurfaceType
    Writable: true

    Name: LeftParamB
    Type: number
    Writable: true

    Name: SourceAssetId
    Type: number
    Writable: false

    Name: TopParamB
    Type: number
    Writable: true

    Name: LeftSurfaceInput
    Type: Enum.InputType
    Writable: true

    Name: BackParamB
    Type: number
    Writable: true

    Name: Color
    Type: Color3
    Writable: true

    Name: RootPriority
    Type: number
    Writable: true

    Name: CenterOfMass
    Type: Vector3
    Writable: false

    Name: BottomParamA
    Type: number
    Writable: true

    Name: DataCost
    Type: number
    Writable: false

    Name: Archivable
    Type: boolean
    Writable: true

    Name: ResizeIncrement
    Type: number
    Writable: false

    Name: formFactor
    Type: Enum.FormFactor
    Writable: true

    Name: Position
    Type: Vector3
    Writable: true

    Name: BackSurfaceInput
    Type: Enum.InputType
    Writable: true

    Name: BackParamA
    Type: number
    Writable: true

    Name: RightSurfaceInput
    Type: Enum.InputType
    Writable: true

    Name: CurrentPhysicalProperties
    Type: PhysicalProperties
    Writable: false

    Name: CanTouch
    Type: boolean
    Writable: true

    Name: RotVelocity
    Type: Vector3
    Writable: true

    Name: SpecificGravity
    Type: number
    Writable: false

    Name: TopParamA
    Type: number
    Writable: true

    Name: BrickColor
    Type: BrickColor
    Writable: true

    Name: TopSurface
    Type: Enum.SurfaceType
    Writable: true

    Name: Velocity
    Type: Vector3
    Writable: true

    Name: UniqueId
    Type: UniqueId
    Writable: false

    Name: Shape
    Type: Enum.PartType
    Writable: true

    Name: FormFactor
    Type: Enum.FormFactor
    Writable: true
```
</details>

<br>

# 🎮 Using it in a game.
Install [Packet+](https://github.com/AlexanderLindholt/PacketPlus) if not already installed.

Ensure this `GetAPIMap` packet in your packet definitions module:
```
local Packet = require(script.Packet)

return {
	GetAPIMap = Packet():Response(Packet.Any)
	-- The rest of your packets.
}
```

Then you can use Inxpect just like usual!
