math.randomseed(tick())

local colors = script.Colors:GetChildren()

local color = colors[math.random(1,#colors)]

local char = script.Parent

local player = game:GetService("Players"):GetPlayerFromCharacter(char)

local gui = script.Display

local showOverLocalPlayer = true


gui.Parent = char.Head

if not showOverLocalPlayer then gui.PlayerToHideFrom = player end

gui.Frame.Script.Disabled = false
gui.PlayerName.Text = script.Parent.Name
gui.PlayerName.TextColor3 = color.Value


char.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
script:Remove()
