using HorizonSideRobots

function mark_chess!(robot)
    local west_step, sud_step = go_to_the_corner(robot)
    flag_1,flag_2 = mod(west_step,2),mod(sud_step,2)
    flag = mod(flag_1 + flag_2,2)
    direct = Ost
    flag = along_chess_mark!(robot,direct,flag)
    flag = mod(flag + 1,2)
    direct = inverse(direct)
    while try_move!(robot,Nord)
        flag = along_chess_mark!(robot,direct,flag)
        flag = mod(flag + 1,2)
        direct = inverse(direct)
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

function along_chess_mark!(robot,side,flag)
    while !isborder(robot,side)
        if flag == 0
            putmarker!(robot)
        end 
        flag = mod(flag + 1,2)
        move!(robot,side)
        if flag == 0
            putmarker!(robot)
        end 
    end 
    return flag
end 

inverse(side) = HorizonSide(mod(Int(side)+2,4))


function num_steps!(robot::Robot, direct::HorizonSide, num_steps)
    for _ in 1:num_steps
        move!(robot,direct)
    end
end 

r = Robot("untitled.sit")

mark_chess!(r)

show!(r)

#along_chess_mark!(r,Ost,0)

