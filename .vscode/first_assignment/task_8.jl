using HorizonSideRobots

right(side) = HorizonSide(mod(Int(side)-1,4))

function find_marker!(robot)
    side = Nord
    n = 0
    flag = 0
    while !find_marker!(robot,side,n)
        # сделали n шагов , если найдет маркет , вернкт true , если нет false
        if flag == 2
            n +=1
            flag = 0
        end
        flag +=1
        side = right(side)
    end
end

function find_marker!(robot,side,max_num)
    if ismarker(robot)
        return true              
    end 
    for _ in 1:max_num
        if ismarker(robot)
            return true              # === ismarker(robbot) && return true 
        end 
        move!(robot,side)
    end
    return false
end 
    
r = Robot("task_8.sit")

find_marker!(r)

show(r)