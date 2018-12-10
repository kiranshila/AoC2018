#==
    Advent of Code Challenge
    Day 9
    Kiran Shila
==#
numPlayers = 479
lastPoints = 71035*100
include("AoC_9_Helpers.jl")

# Create 0 Marble
currentMarble = Marble()
zeroMarble = currentMarble

scores = zeros(Int64,numPlayers)

@time Juno.@progress for marble = 1:lastPoints
    global currentMarble = playGame(scores,marble,currentMarble,mod(marble-1,numPlayers)+1)
end

print(maximum(scores))
