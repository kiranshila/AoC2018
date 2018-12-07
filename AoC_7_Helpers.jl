mutable struct Job
    name::Char
    progress::Int64
end

jobDuration(j::Job) = convert(Int64,j.name) - 4
Job() = Job(' ',0)

mutable struct Worker
    currentTask::Job
end

Worker() = Worker(Job())

struct Node
    parents::Vector{Char}
    children::Vector{Char}
end

Node() = Node([],[])

function doWork(workers::Vector)
    for worker in workers
        if worker.currentTask.name != ' '
            worker.currentTask.progress += 1
        end
    end
end

function workersBusy(workers::Vector)
    for worker in workers
        if worker.currentTask.name != ' '
            return true
        end
    end
    return false
end

function charsInString(charArray::Vector{Char},s::String)
    for char in charArray
        if !in(char,s)
            return false
        end
    end
    return true
end

function freeWorkers(workers::Vector)
    for worker in workers
        if worker.currentTask.name == ' '
            return true
        end
    end
    return false
end
