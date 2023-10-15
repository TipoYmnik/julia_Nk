using HorizonSideRobots

try_move!(robot,direct) = (!isborder(robot,direct) && (move!(robot,direct); return true); false)

along!(robot,direct) = while try_move!(robot,direct) end

function along!(robot, direct)
    num_steps = 0
    while try_move!(robot, direct)
        num_steps +=1
    end 
    return num_steps
end

function go_to_the_corner(robot)
    local west_step, sud_step = along!(robot,West), along!(robot,Sud)
    return west_step, sud_step 
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

function num_steps_mark!(robot, direct, num_steps)
    steps = 1
    putmarker!(robot)
    while (steps < num_steps) && try_move!(robot,direct)
        putmarker!(robot)
        steps += 1
    end
end 

function num_steps!(robot, direct, num_steps)
    for _ in 1:num_steps
        move!(robot,direct)
    end
end 
    
    
    


function task_3!(robot)
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



inverse(side::HorizonSide)::HorizonSide = HorizonSide(mod(Int(side)+2, 4))



function task_5_0!(robot)
    a = []
    go_to_the_corner(robot)
    for side in [Nord, Ost, Sud, West]
        append!(a,along_mark!(robot,side))
    end
    return a[2]
end


function task_1!(robot)
    local west_step,sud_step = go_to_the_corner(robot)
    local num_rows, num_colons = along!(robot, Nord), along!(robot, Ost)
    num_steps!(robot,West,div(num_colons + 1, 2))
    along_mark!(robot, Sud)
    num_steps!(robot,Nord,div(num_rows + 1, 2))
    along!(robot,Ost)
    along_mark!(robot,West)
    along!(robot,Sud)
    num_steps!(robot, Ost, west_step)
    num_steps!(robot, Nord, sud_step)
end

function task_4!(robot)
    side = Ost
    local west_step,sud_step = go_to_the_corner(robot)
    num_steps = along_mark!(robot,side)
    while !isborder(robot,Nord) && (num_steps > 0)
        move!(robot,Nord)
        num_steps -=1
        side = inverse(side)
        num_steps_mark!(robot,side,num_steps)
        side = inverse(side)
        move!(robot,side)
        try_move!(robot,Nord) && along_mark!(robot,side)
        num_steps -= 1
    end
    go_to_the_corner(robot)
    num_steps!(robot, Ost, west_step)
    num_steps!(robot, Nord, sud_step)
end


function task_5_1!(robot,direct)
    for _ in 1:4








function task_5!(robot)
    #num_steps = task_5_0!(robot)
    direct = Ost
    while (along_1!(robot,direct) == 12)
        try_move!(robot,Nord)
        direct = inverse(direct)
    end 
    direct = inverse(direct)

end 

    
function along_1!(robot, direct)
    num_steps = 1
    while try_move!(robot, direct) && !isborder(robot,Nord)
        num_steps +=1
    end 
    return num_steps
end 




