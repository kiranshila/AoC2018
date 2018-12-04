#==
    Advent of Code Challenge
    Day 2
    Kiran Shila
==#

file = open("input_day2.txt")

global exactly2 = 0
global exactly3 = 0

for l in eachline(file)
    dict = Dict()
    twoflag = false
    threeflag = false
    for char in l
        if !haskey(dict,char)
            dict[char] = 1
        else
            dict[char] = dict[char] + 1
        end
    end
    for (key,value) in dict
        if value == 2 && !twoflag
            global exactly2 = exactly2 + 1
            twoflag = true
        elseif value == 3 && !threeflag
            global exactly3 = exactly3 + 1
            threeflag = true
        end
    end
end

println(exactly2)
println(exactly3)

println(exactly2*exactly3)
