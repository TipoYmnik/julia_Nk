using HorizonSideRobots

function num_steps!(robot, direct, num_steps)
    for _ in 1:num_steps
        move!(robot,direct)
    end
end 

inverse(side) = HorizonSide(mod(Int(side)+2,4))

left(side) = HorizonSide(mod(Int(side)+1,4))

right(side) = HorizonSide(mod(Int(side)-1,4))

function find!(robot,direct,num_step,side)
    for _ in 1:num_step
        if !isborder(robot,side)
            move!(robot,side)
            return true
        end 
        move!(robot,direct)
    end
    return false
end 

    

function main!(robot,side)
    local n = 1
    direct = left(side)
    while !find!(robot,direct,n,side)
        direct = inverse(direct)
        n += 1
    end 
    num_steps!(robot,direct,div(n,2))
end






        