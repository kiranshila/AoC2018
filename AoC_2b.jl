#==
    Advent of Code Challenge
    Day 2
    Kiran Shila
==#

function hamming(s1::String,s2::String)
    sum(ch1 != ch2 for (ch1,ch2) in zip(s1,s2))
end

function stringAND(s1::String,s2::String)
    outString = ""
    for (ch1,ch2) in zip(s1,s2)
        if ch1 == ch2
            outString *= ch1
        end
    end
    outString
end

file = open("input_day2.txt")

lines = readlines(file)

for (i,l) in enumerate(lines)
    for j = i+1:length(lines)
        if hamming(lines[i],lines[j]) == 1
            println(stringAND(lines[i],lines[j]))
        end
    end
end
