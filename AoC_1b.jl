#==
    Advent of Code Challenge
    Day 1
    Kiran Shila
==#

global s = Set{Int64}()
global freq = 0
global foundDouble = false
while !foundDouble
    file = open("input_day1.txt")
    for l in eachline(file)
        global freq += parse(Int64,l)
        if in(freq,s)
            println(freq)
            global foundDouble = true
            break
        else
            push!(s,freq)
        end
    end
    close(file)
    global iters += 1
end
