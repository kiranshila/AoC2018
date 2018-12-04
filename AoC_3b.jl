#==
    Advent of Code Challenge
    Day 3
    Kiran Shila
==#

fabricDict = Dict()
# Key will be coordinate pair, value will be claims

# Read claims to fabric dictionary
file = open("input_day3.txt")
lines = readlines(file)
for l in lines
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

# Go through lines again and find claim that hasn't been collided
for l in lines
    ID = strip(split(l,"@")[1])
    ΔX,ΔY = map(x -> parse(Int64,x),split(strip(split(split(l,"@")[2],":")[1]),","))
    Width,Height = map(x -> parse(Int64,x),split(strip(split(split(l,"@")[2],":")[2]),"x"))
    collision = false
    for i in ΔX+1:ΔX+Width, j in ΔY+1:ΔY+Height
        # Construct hashkey
        key = "$i,$j"
        if fabricDict[key] != 1 # Meaning somone else claimed this region
            collision = true
            break
        end
    end
    # After checking the entire area of the claim with no collision
    if !collision
        println(ID)
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
