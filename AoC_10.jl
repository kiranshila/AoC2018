#==
    Advent of Code Challenge
    Day 10
    Kiran Shila
==#
cd("$(homedir())/Desktop/Projects/Julia/AoC2018/")
using Plots
file = open("test_input")
lines = readlines(file)

mutable struct Point
    x::Int64
    y::Int64
    Δx::Int64
    Δy::Int64
end

points = Vector{Point}()

for line in lines
    x,y,Δx,Δy = collect(parse(Int64,m.match) for m in eachmatch(r"[-]?\d+(?:\.\d+)?",line))
    push!(points,Point(x,y,Δx,Δy))
end

minx = minimum(point.x for point in points)
miny = minimum(point.y for point in points)

# Adjust numbers
for point in points
    point.x += abs(minx) + 1
    point.y += abs(miny) + 1
end

maxx = maximum(point.x for point in points)
maxy = maximum(point.y for point in points)

Juno.@progress for i = 1:3
    display(scatter(collect(point.x for point in points),collect(point.y for point in points),shape=:circle,framestyle=:none))
    for point in points
        point.x += point.Δx
        point.y += point.Δy
    end
end

function cyclePoints(points::Array{Point})
    for point in points
        point.x += point.Δx
        point.y += point.Δy
    end
end
