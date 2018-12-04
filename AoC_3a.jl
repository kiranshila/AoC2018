#==
    Advent of Code Challenge
    Day 3
    Kiran Shila
==#

fabricDict = Dict()
# Key will be coordinate pair, value will be claims

# Read claims to fabric dictionary
file = open("input_day3.txt")
for l in eachline(file)
    # ID = strip(split(l,"@")[1])
    ΔX,ΔY = map(x -> parse(Int64,x),split(strip(split(split(l,"@")[2],":")[1]),","))
    Width,Height = map(x -> parse(Int64,x),split(strip(split(split(l,"@")[2],":")[2]),"x"))
    for i = ΔX+1:ΔX+Width
        for j = ΔY+1:ΔY+Height
            # Construct hashkey
            key = "$i,$j"
            if !haskey(fabricDict,key)
                global fabricDict[key] = 1
            else
                global fabricDict[key] += 1
            end
        end
    end
end

# Find overlaping fabric
overlapingFabric = 0
for (key,value) in fabricDict
    if value >= 2
        global overlapingFabric += 1
    end
end
println(overlapingFabric)
