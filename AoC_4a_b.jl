#==
    Advent of Code Challenge
    Day 4
    Kiran Shila

    This one I made unreasonably complicated
==#
using Dates
using DataStructures
file = open("input_day4.txt")
lines = readlines(file)

@enum Action Wake=1 Sleep=2

struct Begin
    ID::Int64
end

dictType = Union{Begin,Action}

function parseAction(s::String)
    if occursin(r"Guard", s)
        return Begin(parse(Int64,split(split(s,"#")[2]," ")[1]))
    elseif occursin(r"asleep", s)
        return Sleep
    elseif occursin(r"wakes", s)
        return Wake
    else
        return
    end
end

events = SortedDict{DateTime,dictType}()

for l in lines
    dateTime = DateTime(split(l,"]")[1][2:end],"yyyy-mm-dd HH:MM")
    thisAction = parseAction(l)
    events[dateTime] = thisAction
end

sleepMinuteOccurance = Dict{Int64,Vector{Int64}}()

currentID = 0
fallAsleep = nothing
wakeUp = nothing
for (key,value) in events
    if typeof(value) == Begin
        global currentID = value.ID
    elseif typeof(value) == Action
        if value == Sleep
            global fallAsleep = key
        elseif value == Wake
            global wakeUp = key
            if !haskey(sleepMinuteOccurance,currentID)
                global sleepMinuteOccurance[currentID] = zeros(Int64,60)
                for i = minute(fallAsleep)+1:minute(wakeUp)+1
                    sleepMinuteOccurance[currentID][i] = 1
                end
            else
                for i = minute(fallAsleep)+1:minute(wakeUp)+1
                    global sleepMinuteOccurance[currentID][i] += 1
                end
            end
        end
    end
end

maxTime = 0
maxID = 0
# Find the guard that slept the most
for (key,value) in sleepMinuteOccurance
    if sum(value) > maxTime
        global maxTime = sum(value)
        global maxID = key
    end
end

mostCommonMinute = findmax(sleepMinuteOccurance[maxID])[2]-1

println(mostCommonMinute*maxID)

maxID = 0
maxOccurances = 0
maxMinute = 0
for (key,value) in sleepMinuteOccurance
    if maximum(value) > maxOccurances
        global maxOccurances = maximum(value)
        global maxID = key
        global maxMinute = findmax(sleepMinuteOccurance[maxID])[2]-1
    end
end

println(maxMinute*maxID)
