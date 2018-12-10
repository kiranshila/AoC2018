#==
    Advent of Code Challenge
    Day 9
    Kiran Shila
==#
numPlayers = 479
lastPoints = 71035*100

#==
mutable struct Marble
    isCurrent::Bool
    value::Int64
    CW::Marble
    CCW::Marble
    # Inner Constructors
    Marble() = (x = new();x.isCurrent = true;x.value = 0; x.CW = x; x.CCW = x)
    Marble(isCurrrent,value,CW,CCW) = new(isCurrrent,value,CW,CCW)
end
==#


function Base.string(x::Marble)
    if x.CW.value == 0 && x.isCurrent
        return "($(x.value))"
    elseif x.CW.value == 0 && !x.isCurrent
        return "$(x.value)"
    elseif x.CW.value != 0 && x.isCurrent
        return "($(x.value)) " * string(x.CW)
    else
        return "$(x.value) " * string(x.CW)
    end
end

Base.print(io::IO,x::Marble) = print(io,string(x))
Base.display(x::Marble) = print(x)

# Create 0 Marble
currentMarble = Marble()
zeroMarble = currentMarble

function insertMarbleAtCurrent!(number::Int64,thisMarble::Marble)
    thisMarble.isCurrent = false
    newMarble = Marble(true,number,thisMarble.CW.CW,thisMarble.CW)
    thisMarble.CW.CW = newMarble
    newMarble.CW.CCW = newMarble
    return newMarble
end

function removeMarble!(thisMarble::Marble)
    thisMarble.CCW.CW = thisMarble.CW
    thisMarble.CW.CCW = thisMarble.CCW
end

scores = zeros(Int64,numPlayers)

function playGame(scores::Vector{Int64},marbleNum::Int64,currentMarble::Marble,player::Int64)
    if mod(marbleNum,23) != 0
        return insertMarbleAtCurrent!(marbleNum,currentMarble)
    else
        sevenAway = currentMarble.CCW.CCW.CCW.CCW.CCW.CCW.CCW
        scores[player] += marbleNum + sevenAway.value
        currentMarble.isCurrent = false
        sevenAway.CW.isCurrent = true
        removeMarble!(sevenAway)
        return sevenAway.CW
    end
end

@time Juno.@progress for marble = 1:lastPoints
    global currentMarble = playGame(scores,marble,currentMarble,mod(marble-1,numPlayers)+1)
end

print(maximum(scores))
