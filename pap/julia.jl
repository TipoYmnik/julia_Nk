using HorizonSideRobots
HSR = HorizonSideRobots

robot = Robot(;animate=true)

function mark_line!(robot, side)
    #Маркирует линию до упора заданного направления, в начале маркер не ставит. Возвращает число сделанных шагов

end

function HorisonSideRobots.move!(robbot,side,num_steps)
    for k in 1:num_steps 
        move!(robot, side)
    end
end

function kross!(robot)
    for s in (North, West, Sud, Ost)
        n = mark_line!(robot, s)
        move!(robot, inverse(s), n)
    end
    putmarker!(robot)
end

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))


#=
Дома

1
Робот в произвольной клетке,
Робот в исходной положении Замаркеровано всё поле 

2
Робот в произвольной клетке,
Робот в исходном положении, замаркерованы все клетки по периметру

3
Робот в произвольной клетке,
Косой крест, робот в центре.
=#
