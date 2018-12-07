#==
    Advent of Code Challenge
    Day 7
    Kiran Shila
==#
using DataStructures
include("AoC_7_Helpers.jl")

file = open("input_day7.txt")
lines = readlines(file)

numWorkers = 5

workers = []

for i = 1:numWorkers
    push!(workers,Worker())
end

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
available = copy(start)
inProgress = SortedSet()

seconds = 0
while length(available) != 0 || length(inProgress) != 0
    # Perform Work
    doWork(workers)

    # Check to see if work is complete, if it is, reset worker and add job to completed jobs
    for worker in workers
        if worker.currentTask.progress == jobDuration(worker.currentTask) && worker.currentTask.name != ' '
            global output *= worker.currentTask.name
            delete!(inProgress,worker.currentTask.name)
            worker.currentTask = Job()
        end
    end
    # Add new tasks to available
    if length(output) > 0
        lastJob = output[end]
        for child in nodeDict[lastJob].children
            if charsInString(nodeDict[child].parents,output) && !in(child,inProgress) && !in(child,available)
                push!(available,child)
            end
        end
    end

    # Try to asign every available task to every available worker
    # Grab task from available
    sort!(available)
    while freeWorkers(workers) && length(available) != 0
        task = available[1]
        # Asign task to worker
        for worker in workers
            if worker.currentTask.name == ' '
                # Asign task
                worker.currentTask.name = task
                push!(inProgress,task)
                # Remove from available
                deleteat!(available,1)
                break
            end
        end
    end
    global seconds += 1
end

println(seconds-1)
