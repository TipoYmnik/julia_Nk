using HorizonSideRobots

function main!(robot)
    n_step,side = shuttle!(() -> !isborder(robot, Nord), robot)
    try_move!(()->false,robot,Nord)
    along!(()->false,robot,side,div(n_step,2))
    putmarker!(robot)
end 


function shuttle!(stop_condition, robot)
    n = 1
    side = Ost
    while !stop_condition()
        along!(stop_condition, robot, side, n) 
        n += 1
        side = inverse(side)
    end
    return (n, side)
end

inverse(side) = HorizonSide(mod(Int(side)+2,4)) 



function along!(stop_condition, robot, side, n)
    for i in 1:n
        if !stop_condition()
            try_move!(stop_condition, robot, side)
        end
    end
end

function try_move!(stop_condition, robot, side)
    if !stop_condition()     
        move!(robot, side)   
    end
end


r = Robot("task_16.sit",animate = true)


main!(r)