--Wait For Game To Load
if not game:IsLoaded() then
    game.Loaded:Wait()
end


--Kill Switch(Reset game after 6 minutes)
function killswitch()
	wait(killtime)
	local Event = game:GetService("ReplicatedStorage")["RS_Package"].Remotes.VoteReset
	Event:FireServer()
end


--Start The Game
wait(6)
game:GetService("ReplicatedStorage")["RS_Package"].Remotes.PlayerReady:FireServer("Class 2")
wait(6)


--Remove Map
function removemap()
	game.Workspace.Map.ExcessParts:Destroy()
end


--Prevent Falling
HumanoidRootPart = game:service"Players".LocalPlayer.Character["HumanoidRootPart"]
Descendants = game:service"Players".LocalPlayer.Character:GetDescendants()
Mass = 0
for i, v in ipairs(Descendants) do
    if v:IsA("BasePart") then
    Mass = Mass + v:GetMass()
    end
end
local AntiGravity = Instance.new("BodyForce") do
    AntiGravity.Force = Vector3.new(0, Mass*workspace.Gravity, 0)
    AntiGravity.Parent = HumanoidRootPart
end


--Noclip
function noclip()
    while true do wait()
        game.Players.LocalPlayer.Character:findFirstChildOfClass("Humanoid"):ChangeState(11)
    end
end


--Teleport Bypass
local plr = game:service"Players".LocalPlayer
function tp(x,y,z,d)
	time = d/speed
	tweenService = game:GetService("TweenService")
	tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear)
	tween = tweenService:Create(plr.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(x,y,z)})
	tween:Play()
	tween.Completed:Wait()
end


--Interact remote
function interact(x)
    local Event1 = game:GetService("ReplicatedStorage")["RS_Package"].Remotes.StartInteraction
    local Event2 = game:GetService("ReplicatedStorage")["RS_Package"].Remotes.CompleteInteraction
    Event1:FireServer(x)
    wait(0.1)
    Event2:FireServer(x)
end


--Loot Small Loots
function lootsmall()
    for _,i in pairs(Workspace.Lootables:GetChildren()) do
		if not table.find(ignore,i.Name) then
			repeat wait()
			local posx = i.PrimaryPart.Position.x
			local posy = i.PrimaryPart.Position.y
			local posz = i.PrimaryPart.Position.z
			local dis = (plr.Character.Torso.Position - i.PrimaryPart.Position).Magnitude
			tp(posx,posy+1,posz,dis)
			interact(i)
			until not i:IsDescendantOf(Workspace.Lootables)
		
		elseif i == nil then
			return true
			
		else
		end
    end
end


--Loot Big Loots
function lootbig()
    for _,i in pairs(Workspace.BigLoot:GetChildren()) do
		if not table.find(ignore,i.Name) then
			repeat wait()
			local posx = i.PrimaryPart.Position.x
			local posy = i.PrimaryPart.Position.y
			local posz = i.PrimaryPart.Position.z
			local dis = (plr.Character.Torso.Position - i.PrimaryPart.Position).Magnitude
			tp(posx,posy+1,posz,dis)
			interact(i)
			until not i:IsDescendantOf(Workspace.BigLoot)
		
		elseif i == nil then
			return true
			
		else end
    end
end


--Grab lootbox
function lootbox()
	for _,i in pairs(game.Workspace.SafeSpots:GetChildren()) do
		if not i.Name == 'SafesScript' then
			repeat wait()
			local posx = i.PrimaryPart.Position.x
			local posy = i.PrimaryPart.Position.y
			local posz = i.PrimaryPart.Position.z
			local dis = (plr.Character.Torso.Position - i.PrimaryPart.Position).Magnitude
			tp(posx,posy+1,posz,dis)
			interact(i)
			until not i:IsDescendantOf(Workspace.SafeSpots)
		
		elseif i == nil then
			return true
		else end
	end
end
		

--Drop off bags
function dropbag()
	local posx = game.Workspace.BagSecuredArea.EscapeVan.PrimaryPart.Position.x
	local posy = game.Workspace.BagSecuredArea.EscapeVan.PrimaryPart.Position.y
	local posz = game.Workspace.BagSecuredArea.EscapeVan.PrimaryPart.Position.z
	local dis = (plr.Character.Torso.Position - game.Workspace.BagSecuredArea.EscapeVan.PrimaryPart.Position).Magnitude
	tp(posx,posy,posz,dis)
	game:GetService("ReplicatedStorage")["RS_Package"].Remotes.ThrowBag:FireServer(Vector3.new(0, 0, 0))
	wait(3)
	return true
end


--Reset game
function reset()
	local Event = game:GetService("ReplicatedStorage")["RS_Package"].Remotes.VoteReset
	Event:FireServer()
end


--Scripts
spawn(noclip)
spawn(killswitch)
removemap()
if grabsafe == true then if lootbox() == true then end end
if lootsmall() == true then end
if lootbig() == true then end
if dropbag() == true then end
reset()
