
using HorizonSideRobots

function count_borders!(robot)
    side = Ost
    steps = go_to_corner_2(robot) # отправляет робота в Юго-западный угол, записывает путь в виде массива
    counter = count_borders_in_row!(robot,side)  # считает кол-во перегородок в ряду
    while try_move!(robot,Nord)
        side = inverse(side)
        counter += count_borders_in_row!(robot,side)
    end
    along!(robot,Sud)
    along!(robot,inverse(side))
    go_to_the_start(robot,steps)
    return counter
end 

function count_borders_in_row!(robot, side)
    state = 0 
    num_borders = 0
    while try_move!(robot, side)
        if state == 0
            if isborder(robot, Nord)
                 state = 1
            end
        elseif state == 1 
            if !isborder(robot, Nord)
                state = 2 
                if isborder(robot,side)
                    num_borders += 1
                end
            end
        else #state == 2
            if !isborder(robot, Nord)
                state = 0 
                num_borders += 1
             end
        end
    end
    return num_borders
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

function inverse_arr(arr::Any)
    b = []
    for i in 1:length(arr)
        append!(b,arr[length(arr)+ 1 - i])
    end 
    return b
end

function go_to_the_start(robot,steps::Vector)
    for step in steps
        move!(robot,HorizonSide(step))
    end 
end

try_move!(robot::Robot,direct) = (!isborder(robot,direct) && (move!(robot,direct); return true); false)

inverse(side) = HorizonSide(mod(Int(side)+2,4))

along!(robot::Robot, direct::HorizonSide) = (while try_move!(robot, direct) end)


r = Robot("task_11.sit")

count_borders!(r) |> println

show!(r)

