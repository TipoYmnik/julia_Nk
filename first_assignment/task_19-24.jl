using HorizonSideRobots

function along_rec!(robot, side,k=0) #task_19
    if !isborder(robot, side)
        move!(robot,side)
        k +=1 
        return along_rec!(robot, side,k)
    else
        return k
    end
end



function put_marker_and_back_rec!(robot, side) #task_20
    if isborder(robot, side)
        putmarker!(robot)
    else
        move!(robot, side)
        put_marker_and_back_rec!(robot, side)
        move!(robot, inverse(side))
    end
end

r = Robot(animate = true)

#put_marker_and_back_rec!(r,Ost)

function next_step!(robot, side) #task_21
    if !isborder(robot, side)
        move!(robot, side)
    else
        move!(robot, left(side))
        next_step!(robot, side)
        move!(robot, right(side))
    end
end

right(side::HorizonSide) = HorizonSide(mod(Int(side)-1, 4))

left(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))

inverse(side) = HorizonSide(mod(Int(side)+2,4))

#next_step!(r,Ost)





function doubledist!(robot, side) #task_22
    k = along_rec!(robot, side)
    num_steps,real_steps = 0,0
    while (num_steps < k)
        try_move!(robot,inverse(side))
        if try_move!(robot,inverse(side))
            real_steps +=1
        end
        num_steps += 1
    end
    return (num_steps == real_steps)
end







#doubledist!(r,West)

function symmetric_position(robot, side) # task_23
    if isborder(robot, side)
        along_rec!(robot, inverse(side))
    else
        move!(robot,side)
        symmetric_position(robot, side)
        move!(robot,side)
    end
end

symmetric_position(r,West)




function halfdist!(robot, side) #task_24
    if !isborder(robot, side)
        move!(robot, side)
        no_delayed_action!(robot, side)
        move!(robot, inverse(side)) # отложенное действие
    end
end

function no_delayed_action!(robot,side)
    if !isborder(robot, side)
        move!(robot, side)
        halfdist!(robot, side)
    end
end

