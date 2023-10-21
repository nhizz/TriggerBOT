# TriggerBOT
1 It defines PlayerTeam, which stores the player's team and Neutral a variable that holds information about player(s) team.

2 triggerBotToggled and aimBotToggled are initialized to false. These variables will be used to enable or disable the trigger bot and aim bot.

3 aimbotTweenInfo is set with a tween duration of 0.2 seconds, determining how fast the aimbot cursor moves, and aimbotTweenStatus is initialized as nil.

4 The Click function generates a random time delay (between 0.03 and 0.07 seconds) before performing a mouse click action.

5 The script connects to the Stepped event of the RunService, which fires every frame.
