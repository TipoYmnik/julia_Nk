using HorizonSideRobots

HSR = HorizonSideRobots





function HSR.putmarker!(robot::Robot,n_max::Int,flag::Int) 
    step = 1
    side = Nord
    for _ in 1:n_max
        putmarker!(robot)
        while (step < n_max) && try_move!(robot,side) 
            putmarker!(robot)
            step += 1
        end 
        try_move!(robot,tern(side,flag)) #ф-ция tern  поворачивает side вправо или влево в зависимости от flag
        side = inverse(side)
        step = (n_max - step) + 1
        flag = mod(flag +1,2)  
    end  
end

function mark_chess!(robot,n_max)
    local west_step, sud_step = go_to_the_corner(robot) # ф-ция отправляет робота до юго-западного угла, возвращет кол-во шагов
    direct = Ost
    flag = 0
    along_chess_mark!(robot,direct,n_max,flag) #ф-ция маркерует один ряд клетками размера n*n
    while !isborder(robot,Nord)
        flag = mod(flag+1,2)
        direct = inverse(direct)
        if ismarker(robot)
            num_steps!(robot,direct,n_max)# робот делает не больше, чем n_max шагов в направлении direct
        end
        num_steps!(robot,Nord,n_max)
        along_chess_mark!(robot,direct,n_max,flag)
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

function along_chess_mark!(robot,side,n_max,flag)
    while !isborder(robot,side) 
        putmarker!(robot,n_max,flag)
        move!(robot,side,n_max)
    end
end 

function HorizonSideRobots.move!(robot,side,n_max)
    flag = mod(n_max,2)
    for _ in 1:n_max
        try_move!(robot,side)
    end 
    if flag == 1
        for _ in 1:(n_max-1)
            try_move!(robot,Sud)
        end 
    end 
end 



right(side::HorizonSide) = HorizonSide(mod(Int(side)-1, 4))

left(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))

function tern(side::HorizonSide,flag)
    if flag == 0
        side = right(side)
    else
        side = left(side)
    end 
end

function num_steps!(robot::Robot, direct::HorizonSide, num_steps)
    step = 0
    while (step < num_steps) && try_move!(robot,direct)
        step += 1
    end 
    return step 
end 

r = Robot(animate = true)

mark_chess!(r,2)

#show!(r)

#along_chess_mark!(r,Ost,0)

#along_chess_mark!(r,Ost,2,0)




