--Wait For Game To Load
if not game:IsLoaded() then
    game.Loaded:Wait()
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
--Teleport Bypass End


--Interact remote
function interact(x)
    local Event1 = game:GetService("ReplicatedStorage")["RS_Package"].Remotes.StartInteraction
    local Event2 = game:GetService("ReplicatedStorage")["RS_Package"].Remotes.CompleteInteraction
    Event1:FireServer(x)
    wait(0.1)
    Event2:FireServer(x)
end


--Start The Game
wait(6)
game:GetService("ReplicatedStorage")["RS_Package"].Remotes.PlayerReady:FireServer("Class 2")
wait(6)


--Kill Switch(Reset game after 6 minutes)
function killswitch()
	wait(killtime)
	local Event = game:GetService("ReplicatedStorage")["RS_Package"].Remotes.VoteReset
	Event:FireServer()
end


--Remove Map
function removemap()
	game.Workspace.Map.ExcessParts:Destroy()
end


--Prevent Falling
HumanoidRootPart = plr.Character["HumanoidRootPart"]
Descendants = plr.Character:GetDescendants()
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


--Loot Small Loots
function lootsmall()
    for _,i in pairs(Workspace.Lootables:GetChildren()) do
		if not table.find(ignore,i.Name) then	
			if i.Name == 'JewelSpot' then
				local posx = i:FindFirstChild("SmallJewels2").PrimaryPart.Position.x
				local posy = i:FindFirstChild("SmallJewels2").PrimaryPart.Position.y
				local posz = i:FindFirstChild("SmallJewels2").PrimaryPart.Position.z
				local dis = (plr.Character.Torso.Position - i:FindFirstChild("SmallJewels2").PrimaryPart.Position).Magnitude
				tp(posx,posy+1,posz,dis)
				interact(i:FindFirstChild("SmallJewels2"))
				interact(i:FindFirstChild("SmallJewels2"))
				interact(i:FindFirstChild("SmallJewels2"))
				i:Destroy()

			elseif not table.find(ignore,i.Name) then
				local posx = i.PrimaryPart.Position.x
				local posy = i.PrimaryPart.Position.y
				local posz = i.PrimaryPart.Position.z
				local dis = (plr.Character.Torso.Position - i.PrimaryPart.Position).Magnitude
				repeat wait()
				tp(posx,posy+1,posz,dis)
				interact(i)
				until (not i:IsDescendantOf(Workspace.Lootables)) or i.Name == 'OpenedRegister'
			else end
		elseif i == nil then
			return true
		else end
    end
end


--Loot Big Loots
function lootbig()
	if game.Workspace:FindFirstChild('BigLoot') ~= nil then
		for _,i in pairs(game.Workspace.BigLoot:GetChildren()) do
			if not table.find(ignore,i.Name) then
				local posx = i.PrimaryPart.Position.x
				local posy = i.PrimaryPart.Position.y
				local posz = i.PrimaryPart.Position.z
				local dis = (plr.Character.Torso.Position - i.PrimaryPart.Position).Magnitude
				repeat wait()
				tp(posx,posy+1,posz,dis)
				interact(i)
				until not i:IsDescendantOf(Workspace.BigLoot)

			elseif i == nil then
				return true
			else end
		end
	else
		return true
	end
end


--Grab lootbox
function lootbox()
	if game.Workspace:FindFirstChild('SafeSpots') ~= nil then
		for _,i in pairs(game.Workspace.SafeSpots:GetChildren()) do
			if i.Name ~= 'SafesScript' then
				local posx = i.PrimaryPart.Position.x
				local posy = i.PrimaryPart.Position.y
				local posz = i.PrimaryPart.Position.z
				local dis = (plr.Character.Torso.Position - i.PrimaryPart.Position).Magnitude
				repeat wait()
				tp(posx,posy+1,posz,dis)
				interact(i)
				until not i:IsDescendantOf(Workspace.SafeSpots)
			elseif i == nil then
				return true
			else end
		end
	else
		return true
	end
end

--Picklock
function picklock() 
	for _,i in pairs(game.Workspace.Map:GetChildren()) do
		if i.Name == 'Safe' then
			local posx = i.PickLock.Position.x
			local posy = i.PickLock.Position.y
			local posz = i.PickLock.Position.z
            local dis = (plr.Character.Torso.Position - i.PickLock.Position).Magnitude
			repeat wait()
			tp(posx,posy+1,posz,dis)
			interact(i)
			until i.Name == 'OpenedSafe'
			if takeloot(i) == true then end
		elseif i == nil then
			return true
		else
		end
	end
end

--Take Loot From Safe
function takeloot(safe)
	for _,v in pairs(safe:GetDescendants()) do
		if table.find(safeitem,v.Name) then
			local posx = v.PrimaryPart.Position.x
			local posy = v.PrimaryPart.Position.y
			local posz = v.PrimaryPart.Position.z
			local dis = (plr.Character.Torso.Position - v.PrimaryPart.Position).Magnitude
			repeat wait()
			tp(posx,posy+1,posz,dis)
			interact(v)
			until not v:IsDescendantOf(safe)
		elseif v == nil then
			return true
		else
		end
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
if picklock() == true then end
if lootsmall() == true then end
if lootbig() == true then end
if dropbag() == true then end
reset()
