using HorizonSideRobots

function main!(robot::Robot)
    for directs in ((Nord, West), (Nord, Ost), (Sud, West), (Sud, Ost))
        num_steps = 0
        while !isborder_2(robot,directs) 
            num_steps += mark_and_numsteps!(robot,directs) 
        end
        putmarker!(robot)
        go_back!(robot,directs,num_steps) 
    end
end

function go_back!(robot::Robot,directs::Tuple{HorizonSide,HorizonSide},num_steps)
    for _ in 1:num_steps
        move!(robot,inverse(directs[1]))
        move!(robot,inverse(directs[2]))
    end   
end

function mark_and_numsteps!(robot::Robot,directs::Tuple{HorizonSide,HorizonSide})
    num_steps = 0
    putmarker!(robot)
    for side in directs
        move!(robot,side)
        num_steps += 1
    end
    return num_steps//2
end

function isborder_2(robot,sides::Tuple{HorizonSide,HorizonSide})
    if (isborder(robot,sides[1]) == 0) && (isborder(robot,sides[2]) == 0)
        return false
    else
        return true
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))

r = Robot("task4.sit")

main!(r)

show(r)