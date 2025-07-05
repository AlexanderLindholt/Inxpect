<div align="center">

<img src="./Logo.png"></img>


A super easy and efficient API map builder for Roblox,<br>
with plugin support and plugin cross-communication.

[<img src="https://raw.githubusercontent.com/AlexanderLindholt/LinkButtons/refs/heads/main/Static/Module.png"></img>](https://create.roblox.com/store/asset/136538514747004) ​ [<img src="https://raw.githubusercontent.com/AlexanderLindholt/LinkButtons/refs/heads/main/Static/Devforum.png"></img>](https://devforum.roblox.com/t/3799622)
</div>
<br>
​<br>
<br>

#  🥷 The hidden Roblox API
On Roblox there is not built-in way to view the API
and e.g. see which properties a certain instance has.

Inxpect allows you to easily inspect what was previously hidden.

<br>

# ✨ Fast, easy, smart.
It's super efficient, and communicates with copies of itself<br>
from other plugins, ensuring only one plugin does the hard job.

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

# 💡Example:
```luau
local apiMap = require(script.APIMap) -- 'APIMap' is Inxpect

local partProperties = apiMap["Part"]

local output = "Part:"

for propertyName, propertyType in partProperties do
	output ..=
	"\n    Property: "..propertyName..
	"\n        Type: "..propertyType
end

print(output)
```
<details>
<summary>💡 See output</summary>

```
Part:
    Property: RightParamB
	Type: number
    Property: CFrame
	Type: CFrame
    Property: RightSurface
	Type: Enum.SurfaceType
    Property: archivable
	Type: boolean
    Property: Friction
	Type: number
    Property: FrontParamB
	Type: number
    Property: BottomSurface
	Type: Enum.SurfaceType
    Property: CollisionGroup
	Type: string
    Property: BackSurfaceInput
	Type: Enum.InputType
    Property: AssemblyLinearVelocity
	Type: Vector3
    Property: Elasticity
	Type: number
    Property: FrontParamA
	Type: number
    Property: MaterialVariant
	Type: string
    Property: RightParamA
	Type: number
    Property: Color
	Type: Color3
    Property: Massless
	Type: boolean
    Property: CollisionGroupId
	Type: number
    Property: RotVelocity
	Type: Vector3
    Property: Locked
	Type: boolean
    Property: Material
	Type: Enum.Material
    Property: Size
	Type: Vector3
    Property: BackSurface
	Type: Enum.SurfaceType
    Property: LocalTransparencyModifier
	Type: number
    Property: CustomPhysicalProperties
	Type: PhysicalProperties
    Property: Rotation
	Type: Vector3
    Property: Name
	Type: string
    Property: AudioCanCollide
	Type: boolean
    Property: LeftParamA
	Type: number
    Property: CastShadow
	Type: boolean
    Property: PivotOffset
	Type: CFrame
    Property: TopSurfaceInput
	Type: Enum.InputType
    Property: Anchored
	Type: boolean
    Property: FrontSurfaceInput
	Type: Enum.InputType
    Property: BottomParamB
	Type: number
    Property: AssemblyAngularVelocity
	Type: Vector3
    Property: Capabilities
	Type: SecurityCapabilities
    Property: BottomSurfaceInput
	Type: Enum.InputType
    Property: CanCollide
	Type: boolean
    Property: Sandboxed
	Type: boolean
    Property: EnableFluidForces
	Type: boolean
    Property: LeftSurface
	Type: Enum.SurfaceType
    Property: Transparency
	Type: number
    Property: brickColor
	Type: BrickColor
    Property: Orientation
	Type: Vector3
    Property: LeftSurfaceInput
	Type: Enum.InputType
    Property: TopParamA
	Type: number
    Property: CanQuery
	Type: boolean
    Property: BottomParamA
	Type: number
    Property: Archivable
	Type: boolean
    Property: Reflectance
	Type: number
    Property: formFactor
	Type: Enum.FormFactor
    Property: FormFactor
	Type: Enum.FormFactor
    Property: RootPriority
	Type: number
    Property: BackParamA
	Type: number
    Property: Velocity
	Type: Vector3
    Property: TopSurface
	Type: Enum.SurfaceType
    Property: CanTouch
	Type: boolean
    Property: TopParamB
	Type: number
    Property: LeftParamB
	Type: number
    Property: Parent
	Type: Instance
    Property: BrickColor
	Type: BrickColor
    Property: FrontSurface
	Type: Enum.SurfaceType
    Property: RightSurfaceInput
	Type: Enum.InputType
    Property: BackParamB
	Type: number
    Property: Shape
	Type: Enum.PartType
    Property: Position
	Type: Vector3
```
</details>
