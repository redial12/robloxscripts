local DataStoreService = game:GetService("DataStoreService")
local KillStorage = DataStoreService:GetOrderedDataStore("KillStorage")

local function updateLeaderboard()
	local success, errorMessage = pcall(function()
		local Data = KillStorage:GetSortedAsync(false, 5)
		local KillPage = Data:GetCurrentPage()
		for rank, data in ipairs(KillPage) do
			local userName = game.Players:GetNameFromUserIdAsync(tonumber(data.key))
			local Name = userName
			local Kills = data.value
			local isOnLeaderboard = false
			for i, v in pairs(game.Workspace.Spawn.KillsLeaderboard.LeaderboardGUI.Holder:GetChildren()) do
				if v.Player.Text == Name then
					isOnLeaderboard = true
					break
				end
			end

			if Kills and isOnLeaderboard == false then
				local newLbFrame = game.ReplicatedStorage:WaitForChild("LeaderboardFrame2"):Clone()
				newLbFrame.Player.Text = Name
				newLbFrame.Kills.Text = Kills
				newLbFrame.Rank.Text = "#"..rank
				newLbFrame.Position = UDim2.new(0, 0, newLbFrame.Position.Y.Scale + (.1 * #game.Workspace.Spawn.KillsLeaderboard.LeaderboardGUI.Holder:GetChildren()), 0)
				newLbFrame.Parent = game.Workspace.Spawn.KillsLeaderboard.LeaderboardGUI.Holder
			end
		end
	end)

	if not success then
		print(errorMessage)
	end
end

while true do

	for _, player in pairs(game.Players:GetPlayers()) do
		KillStorage:SetAsync(player.UserId, player.leaderstats.Kills.Value)
	end

	for _, frame in pairs(game.Workspace.Spawn.KillsLeaderboard.LeaderboardGUI.Holder:GetChildren()) do
		frame:Destroy()
	end

	updateLeaderboard()
	print("Updated!")

	wait(30)
end