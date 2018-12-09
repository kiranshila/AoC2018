#==
    Advent of Code Challenge
    Day 8
    Kiran Shila
==#
file = open("input_day8.txt")
numbers = [parse(Int64,ss) for ss in split(readlines(file)[1])]

struct Node
    numChildren::Int64,numMetaData::Int64,Children::Vector{Node},Metadata::Vector{Int64}
end

function offsetToNext(node::Node)
    if node.numChildren == 0
        return node.numMetaData+2
    else
        return sum(offsetToNext(child) for child in node.Children)+node.numMetaData+2
    end
end

function buildTree(numVec::Vector,offset::Int64)
    thisChildren = numVec[offset]
    thisMetadata = numVec[offset+1]
    # Base Case
    if thisChildren == 0
        return Node(0,thisMetadata,[],numVec[offset+2:offset+1+thisMetadata])
    else
        children = [buildTree(numVec,offset+2)]
        for i = 2:thisChildren
            push!(children,buildTree(numVec,offset+2+sum(offsetToNext(child) for child in children[1:i-1])))
        end
        totalOffset = sum(offsetToNext(child) for child in children)
        return Node(thisChildren,
                    thisMetadata,
                    children,
                    numVec[offset+2+totalOffset:offset+2+totalOffset+thisMetadata-1])
    end
end

function sumMetadata(node::Node)
    if node.numChildren == 0
        return sum(node.Metadata)
    else
        return sum(sumMetadata(child) for child in node.Children)+sum(node.Metadata)
    end
end

function sumMetadataPartTwo(node::Node)
    if node.numChildren == 0
        return sum(node.Metadata)
    else
        total = 0
        for data in node.Metadata
            if data != 0 && data <= length(node.Children)
                total += sumMetadataPartTwo(node.Children[data])
            end
        end
        return total
    end
end



@time sumMetadata(buildTree(numbers,1))
