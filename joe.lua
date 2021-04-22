

local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer
local char = lp.Character
local hrp = char:FindFirstChild("HumanoidRootPart")
local humanoid = char:FindFirstChild("Humanoid")
getgenv().range = 1000
getgenv().looped = true
local debounce = false
local version = "0.1.A"
local sips = 0
function Format(Int)
	return string.format("%02i", Int)
end

function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	
	local Days = (Hours - Hours%24)/24
	
	Days = Hours - Days*24
	
	
	
	return "It's been "..Format(Days).." Days, "..Format(Hours).." Hours, "..Format(Minutes).." Minutes, "..Format(Seconds).." Seconds Since I've started drinking."
end

print(convertToHMS(time()))


--[[local tool = lp.Backpack:FindFirstChildWhichIsA("Tool")
tool.Parent = char]] 
local function getMag(vector1, vector2)
-- removes sqrt because time, reduces function complexity
    local newV2 = Vector3.new(vector2.X, vector1.Y, vector2.Z)
--return (vector1 - newV2).magnitude
    return (vector1 - vector2).magnitude
--return ((vector1.X - vector2.X)^2)+((vector1.Y - vector2.Y)^2)+((vector1.Z - vector2.Z)^2)
end
function checkSight(target)
	local ray = Ray.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, (target.Position - game.Players.LocalPlayer.Character.Head.Position).Unit * getgenv().range)
	local hit,position = workspace:FindPartOnRayWithIgnoreList(ray, {game.Players.LocalPlayer.Character})
	if hit then
		if hit:IsDescendantOf(target.Parent) and not hit:IsDescendantOf(game.Players.LocalPlayer.Character) and math.abs(hit.Position.Y - game.Players.LocalPlayer.Character.Head.Position.Y) < 500 then
			print("I can see the target")
			return true
		end
	end
	return false
end
function chat(message)
     game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents").SayMessageRequest:FireServer(message,"All")
    end
function cameraLookAt(target)
    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Position)
end



function bighead(target,size)
    if size then 
        target.Size = Vector3.new(size,size,size)
        else
           target.size = Vector3.new(5,5,5)
       end
    end
function charLookAt(chr, target) --assume chr is a character and target is a brick to look towards
    if char.PrimaryPart then --just make sure the character's HRP has loaded
        local chrPos = char.PrimaryPart.Position --get the position of the HRP
        local tPos = target.Position --get the position of the target
        local newCF = CFrame.new(Vector3.new(chrPos.x, chrPos.y, chrPos.z), Vector3.new(tPos.x, chrPos.y, tPos.z)) --create our CFrame
        char:SetPrimaryPartCFrame(newCF) --set the HRP's CFrame to our result, thus moving the character!
    end
end

local function findClosePlayer()
    print("findcloseplayer called")
    local bestplayer = nil
    local bestDist = math.huge
    while bestplayer == nil do wait()
        local root = hrp
        for _, player in pairs(game:GetService("Players"):GetChildren()) do
            if player.Name ~= game.Players.LocalPlayer.Name then
            pcall(function()
             if player.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                 if checkSight(player.character.Head) then
                  local dst = getMag(root.Position, player.character.HumanoidRootPart.Position)
                  if dst < bestDist then
                        bestplayer = player
                        bestDist = dst
                  end

end
             end
             end)
        end
        end
        
        if bestplayer ~= nil then
            break
        end
    end
    --targetPart.CFrame = bestplayer.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
    return bestplayer
end

function findPath(target)
	local path = game:GetService("PathfindingService"):CreatePath()
	path:ComputeAsync(hrp.Position,target.Character:WaitForChild("HumanoidRootPart").Position)
	local waypoints = path:GetWaypoints()
	if path.Status == Enum.PathStatus.Success then
		    for _, waypoint in ipairs(waypoints) do
			if waypoint.Action == Enum.PathWaypointAction.Jump then
			        chat("Elevated Path Found Jumping")
					game.Players.LocalPlayer.Character.Humanoid.Jump = true
			end
			game.Players.LocalPlayer.Character.Humanoid:MoveTo(waypoint.Position)
			local timeOut = game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:Wait(1)
			if not timeOut then
			        chat("Target Sight Lost, Recalculating")
					game.Players.LocalPlayer.Character.Humanoid.Jump = true
				    print("Path too long!")
			    	findPath(target)
				break
			end
			if checkSight(target.Character.HumanoidRootPart) then
			    chat("Chasing Target")
			    
				repeat
					print("Moving directly to the target")
						game.Players.LocalPlayer.Character.Humanoid:MoveTo(target.Character.HumanoidRootPart.Position)
					wait(0.1)
					if target == nil then
						break
					elseif target.Parent == nil then
						break
					end
						if game.Players.LocalPlayer.Character.Humanoid.Health <= 90 then
	                        break
                 	end
				until checkSight(target.Character.HumanoidRootPart) == false or game.Players.LocalPlayer.Character.Humanoid.Health < 1 or target.Character.Humanoid.Health < 1
				
			end
			if (hrp.Position - waypoints[1].Position).magnitude > 20 then
			    chat("Target Moved Recalculating Path")
				print("Target has moved, generating new path")
				findPath(target)
				break
			end
		end
		
	end
end



while getgenv().looped do wait()
   
    local player = findClosePlayer()
   -- findPath(player)
   
       charLookAt(char,player.Character:FindFirstChild("Head"))
    
    
  --  if humanoid.Health <= 90 then
           
            repeat wait()
                
                if getMag(hrp.Position,player.Character.HumanoidRootPart.Position) <= 60 then
                    
                    spawn(function()
                         if getMag(hrp.Position,player.Character.HumanoidRootPart.Position) <= 4 then
                             game:GetService("Workspace").Live.Perthyz.Brawl:Activate()
                             end
                        
                        end)
            humanoid.Jump = true
       charLookAt(char,player.Character:FindFirstChild("Head"))
        charLookAt(char,player.Character:FindFirstChild("Head"))
         charLookAt(char,player.Character:FindFirstChild("Head"))
                humanoid:MoveTo(player.Character.Head.CFrame * CFrame.new(math.random(-1,1),0,0).p)
                end
                until humanoid.Health >= 90 
     --   end
    
    end


