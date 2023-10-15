using HorizonSideRobots

function main!(robot::Robot)
    side = Nord
    local west_step, sud_step = go_to_the_corner(robot)
    along_mark!(robot,side)
    while !isborder(robot,Ost)
        move!(robot,Ost)
        side = inverse(side)
        along_mark!(robot,side)
    end
    go_to_the_corner(robot)
    num_steps!(robot, Ost, west_step)
    num_steps!(robot, Nord, sud_step)
end

function go_to_the_corner(robot::Robot)
    local west_step, sud_step = along!(robot,West), along!(robot,Sud)
    return west_step, sud_step 
end

try_move!(robot::Robot,direct::HorizonSide) = (!isborder(robot,direct) && (move!(robot,direct); return true); false)

function along!(robot::Robot, direct::HorizonSide)
    num_steps = 0
    while try_move!(robot, direct)
        num_steps +=1
    end 
    return num_steps
end

function along_mark!(robot, direct)
    steps = 1
    putmarker!(robot)
    while try_move!(robot, direct)
        putmarker!(robot)
        steps += 1 
    end 
    return steps 
end


function num_steps!(robot::Robot, direct::HorizonSide, num_steps)
    for _ in 1:num_steps
        move!(robot,direct)
    end
end 

r = Robot("task4.sit")

main!(r)

show(r)