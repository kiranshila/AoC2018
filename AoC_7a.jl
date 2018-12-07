#==
    Advent of Code Challenge
    Day 7
    Kiran Shila
==#
using DataStructures
file = open("input_day7.txt")
lines = readlines(file)

struct Node
    parents::Vector{Char}
    children::Vector{Char}
end

Node() = Node([],[])

nodeDict = SortedDict{Char,Node}()

# Make key for every letter
for letter in "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    nodeDict[letter] = Node()
end

for line in lines
    # Grab Input
    parent = line[6]
    child = line[37]

    # Push to parent and child
    push!(nodeDict[parent].children,child)
    push!(nodeDict[child].parents,parent)
end

# Find Starting Node
start = []
for (key,value) in nodeDict
    if length(value.parents) == 0 && length(value.children) != 0
        push!(start,key)
    end
end

output = ""
available = start

function charsInString(charArray::Vector{Char},s::String)
    for char in charArray
        if !in(char,s)
            return false
        end
    end
    return true
end

while length(available) != 0
    sort!(available,rev=true)
    thisAvail = pop!(available)
    global output *= thisAvail

    # Find next available
    for child in nodeDict[thisAvail].children
        if charsInString(nodeDict[child].parents,output)
            push!(available,child)
        end
    end
end

println(output)
