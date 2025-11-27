<div align="center">
<em>As of a recent Roblox update, the information that Inxpect helps you gather, is now a built-in feature on Roblox. As a result, Inxpect has been archived, and it is now recommended that you use the official ReflectionService as a replacement.</em>
<br>
<br>
<br>
<br>
<br>
<br>

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
It’s super efficient, easy-to-use, and has full plugin support.

It will intelligently communicate with copies of itself from other plugins, ensuring<br>
only 1 script does the hard job, and that multiple identical maps never coexist.

If an already up-to-date map is found in cache, it won’t generate a new one.

In plugins, it even partially works offline and while the game is running.<br>
This is possible due to its intelligent caching.

*Note that the first time, you *have* to use it with internet connection,<br>
and it’s also not gauranteed to be fully up-to-date when using offline.*
<br>

Additionally, the syntax can’t get any simpler!
```luau
local apiMap = require(script.APIMap) -- Inxpect is named 'APIMap' — since that makes sense.
```
<br>

Don’t worry, it provides only what’s important:
```luau
local apiMap = require(script.APIMap) :: {
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
```

<br>

# 💡 Example:
```luau
local apiMap = require(script.APIMap) -- 'APIMap' is Inxpect.

local function printProperties(class)
	local properties = apiMap[class]
	
	local output = class.."’s properties:"
	for name, data in properties do
		output ..=
			"\n\n    Name: "..name..
			"\n    Type: "..data.Type..
			"\n    Locked: "..tostring(data.Locked)
	end
	print(output)
end
printProperties("Part")
```
<details>
<summary>💡 See output</summary>

```
Part’s properties:

    Name: RightParamB
    Type: number
    Locked: false

    Name: CFrame
    Type: CFrame
    Locked: false

    Name: RightSurface
    Type: Enum.SurfaceType
    Locked: false

    Name: Mass
    Type: number
    Locked: true

    Name: archivable
    Type: boolean
    Locked: false

    Name: Friction
    Type: number
    Locked: false

    Name: FrontParamB
    Type: number
    Locked: false

    Name: BottomSurface
    Type: Enum.SurfaceType
    Locked: false

    Name: ExtentsSize
    Type: Vector3
    Locked: true

    Name: CollisionGroup
    Type: string
    Locked: false

    Name: AssemblyMass
    Type: number
    Locked: true

    Name: AssemblyLinearVelocity
    Type: Vector3
    Locked: false

    Name: Elasticity
    Type: number
    Locked: false

    Name: FrontParamA
    Type: number
    Locked: false

    Name: MaterialVariant
    Type: string
    Locked: false

    Name: RightParamA
    Type: number
    Locked: false

    Name: Parent
    Type: Instance
    Locked: false

    Name: Massless
    Type: boolean
    Locked: false

    Name: CollisionGroupId
    Type: number
    Locked: false

    Name: AssemblyRootPart
    Type: Instance
    Locked: true

    Name: Locked
    Type: boolean
    Locked: false

    Name: Material
    Type: Enum.Material
    Locked: false

    Name: Size
    Type: Vector3
    Locked: false

    Name: BackSurface
    Type: Enum.SurfaceType
    Locked: false

    Name: LocalTransparencyModifier
    Type: number
    Locked: false

    Name: CustomPhysicalProperties
    Type: PhysicalProperties
    Locked: false

    Name: Rotation
    Type: Vector3
    Locked: false

    Name: ReceiveAge
    Type: number
    Locked: true

    Name: Name
    Type: string
    Locked: false

    Name: className
    Type: string
    Locked: true

    Name: RobloxLocked
    Type: boolean
    Locked: true

    Name: LeftParamA
    Type: number
    Locked: false

    Name: CastShadow
    Type: boolean
    Locked: false

    Name: PivotOffset
    Type: CFrame
    Locked: false

    Name: Origin
    Type: CFrame
    Locked: true

    Name: TopSurfaceInput
    Type: Enum.InputType
    Locked: false

    Name: Anchored
    Type: boolean
    Locked: false

    Name: FrontSurfaceInput
    Type: Enum.InputType
    Locked: false

    Name: BottomParamB
    Type: number
    Locked: false

    Name: AssemblyAngularVelocity
    Type: Vector3
    Locked: false

    Name: Capabilities
    Type: SecurityCapabilities
    Locked: false

    Name: BottomSurfaceInput
    Type: Enum.InputType
    Locked: false

    Name: CanCollide
    Type: boolean
    Locked: false

    Name: Sandboxed
    Type: boolean
    Locked: false

    Name: EnableFluidForces
    Type: boolean
    Locked: false

    Name: LeftSurface
    Type: Enum.SurfaceType
    Locked: false

    Name: CurrentPhysicalProperties
    Type: PhysicalProperties
    Locked: true

    Name: Transparency
    Type: number
    Locked: false

    Name: ExtentsCFrame
    Type: CFrame
    Locked: true

    Name: ClassName
    Type: string
    Locked: true

    Name: Orientation
    Type: Vector3
    Locked: false

    Name: Reflectance
    Type: number
    Locked: false

    Name: AssemblyCenterOfMass
    Type: Vector3
    Locked: true

    Name: FormFactor
    Type: Enum.FormFactor
    Locked: false

    Name: Pivot Offset
    Type: CFrame
    Locked: true

    Name: ResizeableFaces
    Type: Faces
    Locked: true

    Name: CanQuery
    Type: boolean
    Locked: false

    Name: brickColor
    Type: BrickColor
    Locked: false

    Name: Velocity
    Type: Vector3
    Locked: false

    Name: SourceAssetId
    Type: number
    Locked: true

    Name: TopSurface
    Type: Enum.SurfaceType
    Locked: false

    Name: TopParamB
    Type: number
    Locked: false

    Name: TopParamA
    Type: number
    Locked: false

    Name: SpecificGravity
    Type: number
    Locked: true

    Name: RotVelocity
    Type: Vector3
    Locked: false

    Name: RootPriority
    Type: number
    Locked: false

    Name: BottomParamA
    Type: number
    Locked: false

    Name: RightSurfaceInput
    Type: Enum.InputType
    Locked: false

    Name: Archivable
    Type: boolean
    Locked: false

    Name: ResizeIncrement
    Type: number
    Locked: true

    Name: formFactor
    Type: Enum.FormFactor
    Locked: false

    Name: BackSurfaceInput
    Type: Enum.InputType
    Locked: false

    Name: Position
    Type: Vector3
    Locked: false

    Name: BackParamA
    Type: number
    Locked: false

    Name: DataCost
    Type: number
    Locked: true

    Name: CenterOfMass
    Type: Vector3
    Locked: true

    Name: CanTouch
    Type: boolean
    Locked: false

    Name: Color
    Type: Color3
    Locked: false

    Name: BackParamB
    Type: number
    Locked: false

    Name: LeftSurfaceInput
    Type: Enum.InputType
    Locked: false

    Name: BrickColor
    Type: BrickColor
    Locked: false

    Name: LeftParamB
    Type: number
    Locked: false

    Name: FrontSurface
    Type: Enum.SurfaceType
    Locked: false

    Name: UniqueId
    Type: UniqueId
    Locked: true

    Name: Shape
    Type: Enum.PartType
    Locked: false

    Name: AudioCanCollide
    Type: boolean
    Locked: false
```
</details>

<br>

# 🎮 Using it in a game.
Install [Packet+](https://github.com/AlexanderLindholt/PacketPlus) if not already installed.

Now ensure that your packet definitions module is tagged `Packets`, so that Inxpect can find it. <br>
Then put this `GetAPIMap` packet in your packet definitions module:
```luau
local Packet = require(script.Packet)

return {
	GetAPIMap = Packet():Response(Packet.Any)
	-- The rest of your packets.
}
```

Then you can use Inxpect just like usual!
