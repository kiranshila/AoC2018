#==
    Advent of Code Challenge
    Day 1
    Kiran Shila
==#

file = open("input_day1.txt")
sum(parse(Int64,l) for l in eachline(file))
