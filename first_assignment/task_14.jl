using HorizonSideRobots

function chess_mark!(robot)
    steps = go_to_corner_2(robot) # отправляет робота в Юго-западный угол, записывает путь в виде массива
    flag_1,flag_2 = mod(count(<=(0),steps),2), mod(count(>=(3),steps),2)
    flag = mod(flag_1 + flag_2,2)
    condition = (Ost)-> condition_robot(robot,Ost,flag)
    snake!(condition, r ,(Ost,Nord))
    go_to_corner_2(robot)
    go_to_the_start(robot,steps)
end



function snake!(stop_condition::Function, robot, (move_side,next_row_side)::NTuple{2,HorizonSide}) 
    state = 0
    num_steps_correct = along!(stop_condition, robot, move_side)   
    while !stop_condition(move_side,state) && try_move!(robot, next_row_side)
        move_side = inverse(move_side)
        num_steps = along!(stop_condition, robot, move_side)
        if num_steps != num_steps_correct
            state = 1
        end 
    end
end 



inverse(side) = HorizonSide(mod(Int(side)+2,4)) 

try_move!(robot::Robot,direct::HorizonSide) = (!isborder(robot,direct) && (move!(robot,direct); return true); false)

function along!(stop_condition::Function, robot, side) 
    steps = 0
    while !stop_condition(side) && try_move!(robot, side)
        steps +=1 
    end
    return steps 
end 

function along!(stop_condition::Function, robot, side,max_num_steps::Int)
    num_steps = 0
    while (num_steps < max_num_steps) && !stop_condition(side) && try_move!(robot, side)
        num_steps += 1
    end
    return num_steps
end  

#snake!(robot, (move_side,
#next_row_side)::NTuple{2,HorizonSide}) = snake!(() -> false, robot, (next_row_side, move_side))


function put_marker!(robot,side,flag)
    if flag == 1
        if try_move!(robot,side)
            putmarker!(robot)
        end 
    end
    if flag == 0
        if !isborder(robot,side)
            putmarker!(robot)
            move!(robot,side)
        end
    end 
    return false 
end 

function bypassing(robot,side)
    steps,steps_2 = 0,0
    while isborder(robot,side) && try_move!(robot,Nord)
        steps += 1
    end 
    try_move!(robot,side)
    while isborder(robot,Sud)
        move!(robot,side)
        steps_2 += 1
    end 
    for _ in 1:steps
        move!(robot,Sud)
    end
    return mod(steps_2,2)
end 

function condition_robot(robot,side,flag,state = 0)
    flag_2 = 0
    if isborder(robot,side) && (state == 1)
        flag_2 = bypassing(robot,side)
    end 
    flag = mod(flag_2 + flag,2)
    return put_marker!(robot,side,flag)
end


function go_to_the_start(robot,steps::Vector)
    for step in steps
        move!(robot,HorizonSide(step))
    end 
end

function inverse_arr(arr::Any)
    b = []
    for i in 1:length(arr)
        append!(b,arr[length(arr)+ 1 - i])
    end 
    return b
end

function go_to_corner_2(robot)
    a = []
    while !(isborder(robot,Sud) && isborder(robot,West))
        if try_move!(robot,Sud)
            append!(a,0)
        end 
        if try_move!(robot,West)
            append!(a,3)
        end 
    end
    return inverse_arr(a)
end


r = Robot("task_14.sit")

chess_mark!(r)

show!(r) 



