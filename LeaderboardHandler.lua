local DataStoreService = game:GetService("DataStoreService")
local TimeStorage = DataStoreService:GetOrderedDataStore("TimeStorage")

local function updateLeaderboard()
	local success, errorMessage = pcall(function()
		local Data = TimeStorage:GetSortedAsync(false, 5)
		local TimePage = Data:GetCurrentPage()
		for rank, data in ipairs(TimePage) do
			local userName = game.Players:GetNameFromUserIdAsync(tonumber(data.key))
			local Name = userName
			local Time = data.value
			local isOnLeaderboard = false
			for i, v in pairs(game.Workspace.Spawn.TimeLeaderboard.LeaderboardGUI.Holder:GetChildren()) do
				if v.Player.Text == Name then
					isOnLeaderboard = true
					break
				end
			end

			if Time and isOnLeaderboard == false then
				local newLbFrame = game.ReplicatedStorage:WaitForChild("LeaderboardFrame"):Clone()
				newLbFrame.Player.Text = Name
				newLbFrame.Time.Text = Time
				newLbFrame.Rank.Text = "#"..rank
				newLbFrame.Position = UDim2.new(0, 0, newLbFrame.Position.Y.Scale + (.1 * #game.Workspace.Spawn.TimeLeaderboard.LeaderboardGUI.Holder:GetChildren()), 0)
				newLbFrame.Parent = game.Workspace.Spawn.TimeLeaderboard.LeaderboardGUI.Holder
			end
		end
	end)

	if not success then
		print(errorMessage)
	end
end

while true do

	for _, player in pairs(game.Players:GetPlayers()) do
		TimeStorage:SetAsync(player.UserId, player.leaderstats.Time.Value)
	end

	for _, frame in pairs(game.Workspace.Spawn.TimeLeaderboard.LeaderboardGUI.Holder:GetChildren()) do
		frame:Destroy()
	end

	updateLeaderboard()
	print("Updated!")

	wait(30)
end