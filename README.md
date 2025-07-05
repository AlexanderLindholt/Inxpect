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
On Roblox there is not built-in way to view the API<br>
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
	Class (string) = {
		Property (string) = Type (string)
	}
}
```
<br>
<br>

> [!note]
> LocalScripts shouldn't require this module. They should instead request the API map from the server through a RemoteFunction.

<br>

# 💡 Example:
```luau
local apiMap = require(script.APIMap) -- 'APIMap' is Inxpect.

local function printProperties(class)
	local properties = apiMap[class]
	
	local output = class.."'s properties:"
	for propertyName, propertyType in properties do
		output ..=
			"\n\n    Name: "..propertyName..
			"\n    Type: "..propertyType
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

    Name: CFrame
    Type: CFrame

    Name: RightSurface
    Type: Enum.SurfaceType

    Name: archivable
    Type: boolean

    Name: Friction
    Type: number

    Name: FrontParamB
    Type: number

    Name: BottomSurface
    Type: Enum.SurfaceType

    Name: CollisionGroup
    Type: string

    Name: BackSurfaceInput
    Type: Enum.InputType

    Name: AssemblyLinearVelocity
    Type: Vector3

    Name: Elasticity
    Type: number

    Name: FrontParamA
    Type: number

    Name: MaterialVariant
    Type: string

    Name: RightParamA
    Type: number

    Name: Color
    Type: Color3

    Name: Massless
    Type: boolean

    Name: CollisionGroupId
    Type: number

    Name: RotVelocity
    Type: Vector3

    Name: Locked
    Type: boolean

    Name: Material
    Type: Enum.Material

    Name: Size
    Type: Vector3

    Name: BackSurface
    Type: Enum.SurfaceType

    Name: LocalTransparencyModifier
    Type: number

    Name: CustomPhysicalProperties
    Type: PhysicalProperties

    Name: Rotation
    Type: Vector3

    Name: Name
    Type: string

    Name: AudioCanCollide
    Type: boolean

    Name: LeftParamA
    Type: number

    Name: CastShadow
    Type: boolean

    Name: PivotOffset
    Type: CFrame

    Name: TopSurfaceInput
    Type: Enum.InputType

    Name: Anchored
    Type: boolean

    Name: FrontSurfaceInput
    Type: Enum.InputType

    Name: BottomParamB
    Type: number

    Name: AssemblyAngularVelocity
    Type: Vector3

    Name: Capabilities
    Type: SecurityCapabilities

    Name: BottomSurfaceInput
    Type: Enum.InputType

    Name: CanCollide
    Type: boolean

    Name: Sandboxed
    Type: boolean

    Name: EnableFluidForces
    Type: boolean

    Name: LeftSurface
    Type: Enum.SurfaceType

    Name: Transparency
    Type: number

    Name: brickColor
    Type: BrickColor

    Name: Orientation
    Type: Vector3

    Name: LeftSurfaceInput
    Type: Enum.InputType

    Name: TopParamA
    Type: number

    Name: CanQuery
    Type: boolean

    Name: BottomParamA
    Type: number

    Name: Archivable
    Type: boolean

    Name: Reflectance
    Type: number

    Name: formFactor
    Type: Enum.FormFactor

    Name: FormFactor
    Type: Enum.FormFactor

    Name: RootPriority
    Type: number

    Name: BackParamA
    Type: number

    Name: Velocity
    Type: Vector3

    Name: TopSurface
    Type: Enum.SurfaceType

    Name: CanTouch
    Type: boolean

    Name: TopParamB
    Type: number

    Name: LeftParamB
    Type: number

    Name: Parent
    Type: Instance

    Name: BrickColor
    Type: BrickColor

    Name: FrontSurface
    Type: Enum.SurfaceType

    Name: RightSurfaceInput
    Type: Enum.InputType

    Name: BackParamB
    Type: number

    Name: Shape
    Type: Enum.PartType

    Name: Position
    Type: Vector3
```
</details>
