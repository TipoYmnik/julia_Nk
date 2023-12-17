using HorizonSideRobots

function chess_mark!(robot)
    local west_step, sud_step = go_to_the_corner(robot)
    flag_1,flag_2 = mod(west_step,2),mod(sud_step,2)
    flag = mod(flag_1 + flag_2,2)
    if flag == 0
        condition = (Ost)-> put_marker_2!(robot,Ost)
    else 
        condition = (Ost)-> put_marker_1!(robot,Ost)
    end 
    snake!(condition, robot,(Ost,Nord))
    go_to_the_corner(robot)
    num_steps!(robot, Ost, west_step)
    num_steps!(robot, Nord, sud_step)
end


function snake!(stop_condition::Function, robot, (move_side,next_row_side)::NTuple{2,HorizonSide} ) 
    along!(stop_condition, robot, move_side)   
    while !stop_condition(move_side) && try_move!(robot, next_row_side)
        move_side = inverse(move_side)
        along!(stop_condition, robot, move_side)
    end
end 

#(inverse(next_row_side),inverse(move_side))

inverse(side) = HorizonSide(mod(Int(side)+2,4)) 

try_move!(robot::Robot,direct::HorizonSide) = (!isborder(robot,direct) && (move!(robot,direct); return true); false)

along!(stop_condition::Function, robot, side) = (while !stop_condition(side) && try_move!(robot, side) end) 

function along!(stop_condition::Function, robot, side,max_num_steps::Int)
    num_steps = 0
    while (num_steps < max_num_steps) && !stop_condition(side) && try_move!(robot, side)
        num_steps += 1
    end
    return nun_steps
end  

#snake!(robot, (move_side,
#next_row_side)::NTuple{2,HorizonSide}) = snake!(() -> false, robot, (next_row_side, move_side))


function put_marker_1!(robot,side)
    if try_move!(robot,side)
        putmarker!(robot)
    end 
    return false
end

function put_marker_2!(robot,side)
    if !isborder(robot,side)
        putmarker!(robot)
        move!(robot,side)
    end
    return false
end

function go_to_the_corner(robot::Robot)
    local west_step, sud_step = along!(robot,West), along!(robot,Sud)
    return west_step, sud_step 
end

function along!(robot::Robot, direct::HorizonSide)
    num_steps = 0
    while try_move!(robot, direct)
        num_steps +=1
    end 
    return num_steps
end

function num_steps!(robot::Robot, direct::HorizonSide, num_steps)
    for _ in 1:num_steps
        move!(robot,direct)
    end
end 


r = Robot("task_13.sit")

chess_mark!(r)

show!(r) 




