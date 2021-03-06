mutable struct Marble
    isCurrent::Bool
    value::Int64
    CW::Marble
    CCW::Marble
    # Inner Constructors
    Marble() = (x = new();x.isCurrent = true;x.value = 0; x.CW = x; x.CCW = x)
    Marble(isCurrrent,value,CW,CCW) = new(isCurrrent,value,CW,CCW)
end

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
