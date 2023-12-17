function fibonacci(n) #task_a 
    a = [1,1]
    if n <= 2
        return a[n]
    else
        for i in 3:n
            append!(a,a[i-1] + a[i-2])
        end
        return a[n]
    end 
end 

function fib_rec(n) #task_b
    if n <= 2
        return 1
    end
    return fib_rec(n-1) + fib_rec(n-2)
end

function mem_fibonacсi(n) #task_c 
    if n == 0
        return 1, 0
    else
        current, prev = mem_fibonacсi(n-1)
        return prev+current, current
    end
end


for i in 0:40
    mem_fibonacсi(i) |> println
end
