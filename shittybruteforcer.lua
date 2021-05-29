
for i = 1,100 do 
spawn(function()
if not getgenv().try then
	getgenv().try = 0
end
if not getgenv().t then
	getgenv().t = {}
end
local function random_string(len)
    local charset = "ABCDEFGHIJKLMNOPQRSTUVXYZ"
    local built_string = ""
    for i=1,len do
        local char = math.random(1,#charset)
        built_string = built_string..charset:sub(char,char)
    end
   	 return built_string
end


getgenv().looped = true
while getgenv().looped do wait()
		local a = random_string(5)
		if not table.find(t,a) then
		spawn(function()
  			getgenv().try = getgenv().try + 1
			rconsoleprint('@@GREEN@@')
			rconsoleprint('Time '..tick()..' | Try: '..getgenv().try..' | Pass: '..a.."\n")
			table.insert(t,a)
			game:GetService("ReplicatedStorage").LobbyEvents.PlayCode:InvokeServer(A)
		end)
		end

end
end)
end
