using HorizonSideRobots


function mark_kross!(robot::Robot) #главная функция 
    for side in (Nord,Sud,West,Ost)
        putmarkers!(robot,side)
        go_back!(robot,inverse(side))
    end
    putmarker!(robot)      
end

function putmarkers!(robot::Robot,side::HorizonSide)
    while !isborder(robot,side)
        move!(robot,side)
        putmarker!(robot)
    end

end

function go_back!(robot::Robot,side::HorizonSide)
    while ismarker(robot)
        move!(robot,side)
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))

r = Robot("task4.sit")

mark_kross!(r)

show(r)