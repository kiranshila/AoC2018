#==
    Advent of Code Challenge
    Day 5
    Kiran Shila
==#

file = open("input_day5.txt")
alphabet = "abcdefghijklmnopqrstuvwyz"
myInput = readlines(file)[1]

function reactPolymer(s::String)
    longstring = s
    complete = false
    while !complete
        lastChar = longstring[1]
        complete = true
        for (i,char) in enumerate(longstring)
            # If the characters are the same
            if uppercase(lastChar) == uppercase(char)
                # And if they are opposite polarity
                if lastChar < char || lastChar > char
                    # Remove the two chars from the string
                    longstring = longstring[1:i-2] * longstring[i+1:end]
                    complete = false
                    break
                end
            end
            lastChar = char
        end
    end
    return length(longstring)
end

# Part 1
println(reactPolymer(myInput))

# Part 2
removeLetter(s::String,letter::Char) = join(split(join(split(s,lowercase(letter))),uppercase(letter)))

bestReduction = Inf;
for letter in alphabet
    println(letter)
    improvedPolymer = removeLetter(myInput,letter)
    thisReduction = reactPolymer(improvedPolymer)
    if thisReduction <  bestReduction
        global bestReduction = thisReduction
    end
end

println(bestReduction)
