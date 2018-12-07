#==
    Advent of Code Challenge
    Day 6
    Kiran Shila
==#
using Distances
using Plots
file = open("input_day6.txt")
lines = readlines(file)
coordinates = Vector{Any}()

for line in lines
    push!(coordinates,[parse(Int64,strip(split(line,",")[1])),parse(Int64,strip(split(line,",")[2]))])
end

minx = Inf
miny = Inf
for coordinate in coordinates
    if coordinate[1] < minx
        global minx = coordinate[1]
    elseif coordinate[2] < miny
        global miny = coordinate[2]
    end
end

# Make zero the minimum
for coordinate in coordinates
    coordinate[1] -= minx-1
    coordinate[2] -= miny-1
end

maxx = 0
maxy = 0
for coordinate in coordinates
    if coordinate[1] > maxx
        global maxx = coordinate[1]
    elseif coordinate[2] > maxy
        global maxy = coordinate[2]
    end
end
area = zeros(Int64,maxx,maxy)

# Place coordinates in area
for (i,coordinate) in enumerate(coordinates)
    area[coordinate[1],coordinate[2]] = i
end

# Make closest point map
blob_size = zeros(Float64,50)
for i = 1:maxx
    for j = 1:maxy
        # Find closest point
        distance = Inf
        closePoint = 0
        dupcount = 0
        for point = 1:length(coordinates)
            thisDistance = chebyshev(coordinates[point],[i, j])
            if thisDistance < distance
                distance = thisDistance
                closePoint = point
                dupcount = 0
            elseif thisDistance == distance
                dupcount += 1
            end
        end
        if dupcount == 0 # No duplicates
            area[i,j] = closePoint
            blob_size[closePoint] += 1
        else
            area[i,j] = 0
        end
        if i == 1 || i == maxx || j == 1 || j == maxy
            blob_size[closePoint] += -Inf
        end
    end
end

# Part 1
println(maximum(blob_size))
heatmap(area)

# Part 2
safearea = zeros(Int64,maxx,maxy)
for i = 1:maxx
    for j = 1:maxy
        # Find closest point
        distance = 0
        for point = 1:length(coordinates)
            distance += braycurtis(coordinates[point],[i, j])
        end
        if distance < 10000
            safearea[i,j] = 1
        end
    end
end
heatmap(safearea)
println(sum(safearea))
