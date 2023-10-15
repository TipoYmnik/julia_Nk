using HorizonSideRobots

function main!(robot::Robot)
    local west_step, sud_step = external_mark!(robot)
    direct = Ost 
    along_2!(robot,direct)
    while try_move!(robot,Nord)
        direct = inverse(direct)
        along_2!(robot,direct)
    end
    internal_mark!(robot,direct)
    num_steps!(robot, Nord, sud_step)
    num_steps!(robot, Ost, west_step)
end


function along_mark!(robot::Robot, direct::HorizonSide)
    steps = 0
    putmarker!(robot)
    while try_move!(robot, direct)
        putmarker!(robot)
        steps += 1 
    end 
    return steps 
end

function external_mark!(robot::Robot)
    local west_step, sud_step = go_to_the_corner(robot)
    for side in (Nord, Ost, Sud, West)
        along_mark!(robot,side)
    end
    go_to_the_corner(robot)
    return west_step,sud_step
end

function internal_mark!(robot::Robot,direct::HorizonSide)
    putmarker!(robot)
    for sides in [(direct,Nord),(Nord, inverse(direct)),(inverse(direct),Sud),(Sud,direct)]
        while isborder(robot,sides[2])
            move!(robot,sides[1])
            putmarker!(robot)
        end
        move!(robot,sides[2])
        putmarker!(robot)
    end
    go_to_the_corner(robot)
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

along_2!(robot::Robot,direct::HorizonSide) = while try_move!(robot,direct) && !isborder(robot,Nord) end



inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))

function num_steps!(robot::Robot, direct::HorizonSide, num_steps)
    for _ in 1:num_steps
        move!(robot,direct)
    end
end 


