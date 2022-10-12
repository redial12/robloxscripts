--bringing storage from cloud
local DataStoreService = game:GetService("DataStoreService")
local TimeStorage = DataStoreService:GetOrderedDataStore("TimeStorage")
local KillStorage = DataStoreService:GetOrderedDataStore("KillStorage")
local BestTime = DataStoreService:GetOrderedDataStore("BestTime")


game.Players.PlayerAdded:Connect(function(player)

	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local Time = Instance.new("IntValue")
	Time.Name = "Time"
	Time.Parent = leaderstats
	Time.Value = TimeStorage:GetAsync(player.UserId, player.leaderstats.Time.Value)

	local Kills = Instance.new("IntValue")
	Kills.Name = "Kills"
	Kills.Parent = leaderstats
	Kills.Value = KillStorage:GetAsync(player.UserId, player.leaderstats.Kills.Value)
	
	local RecordTime = Instance.new("IntValue")
	RecordTime.Name = "RecordTime"
	RecordTime.Parent = leaderstats
	RecordTime.Value = BestTime:GetAsync(player.UserId, player.leaderstats.RecordTime.Value)
	
	
	
	--[[BestTime:GetAsync(player.UserId, player.leaderstats.RecordTime.Value):Connect(function(User, RecordTimeValue)
		if RecordTimeValue == 0 then
			RecordTime.Value = 0
			BestTime:SetAsync(player.UserId, player.leaderstats.RecordTime.Value)
			
			else if RecordTimeValue > 0 then
				RecordTime.Value = RecordTimeValue
			end
		end
	end)]]
	
	local touching
	game.Workspace.Floor.Touched:Connect(function(partTouched)
		
		touching = true
		print(partTouched)
	end)
	
	while true do
		wait(1)
		if touching == true then

			Time.Value = Time.Value + 1
			print("Touching is True")
			if RecordTime.Value < Time.Value then
				RecordTime.Value = Time.Value
			end
		else
			touching = false
			print("Touching is False")
		end
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	
	local success, errormessage = pcall(function()
		TimeStorage:SetAsync(player.UserId, player.leaderstats.Time.Value)
		wait(6)
		KillStorage:SetAsync(player.UserId, player.leaderstats.Kills.Value)
		wait(6)
		BestTime:SetAsync(player.UserId, player.leaderstats.RecordTime.Value)
	end)
	
	if success then
		print("Player Data successfully saved!")
	else
		print("There was an error when saving data")
		warn(errormessage)
	end
end)