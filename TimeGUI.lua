game.Players.PlayerAdded:Connect(function(player)
	local timeValue  = player.leaderstats.Time.Value
	local timeGUI = game.StarterPlayer.StarterCharacterScripts.CustomHealth.Display.TimeAlive.Text
	
	while true do
		wait(1)
		timeGUI = timeValue
	end
end)

