using LinearAlgebra, Statistics, Plots

n = 100
ϵ = randn(n)
plot(1:n, ϵ)

typeof(ϵ)
print(ϵ[1:5])


# poor style
n = 100
ϵ = zeros(n)
for i in 1:n
    ϵ[i] = randn()
end

# better style
n = 100
ϵ = zeros(n)
for i in eachindex(ϵ)
    ϵ[i] = randn()
end

# Loop over index of ϵ
ϵ_sum = 0.0
m = 5
for ϵ_val in ϵ[1:m]
    ϵ_sum = ϵ_sum + ϵ_val
end
ϵ_mean = ϵ_sum / m

# ≈ test equality for floating point number ()
ϵ_mean ≈ mean(ϵ[1:m])
ϵ_mean ≈ sum(ϵ[1:m]) / m

#= Function =#
# poor style
function generatedata(n)
    ϵ = zeros(n)
    for i in eachindex(ϵ)
        ϵ[i] = (randn())^2
    end
    return ϵ
end
data = generatedata(10)
plot(data)

# better style
function generatedata(n)
    ϵ = randn(n)
    for i in eachindex(ϵ)
        ϵ[i] = ϵ[i]^2
    end
    return ϵ
end
data = generatedata(5)

#= broadcast ^2
Julia is complie language then `loop` or `vectorize` close in performance
=#
# better style
function generatedata(n)
    ϵ = randn(n)
    return ϵ.^2    
end
data = generatedata(5)

# good style , lamba style
generatedata(n) = randn(n).^2
data = generatedata(5)

# good style
f(x) = x^2
generatedata(n) = f.(randn(n))
data = generatedata(5)

# function as parameter
generatedata(n, gen) = gen.(randn(n))
f(x) = x^2
data = generatedata(5, f)

# Clearest, general solution
n = 100
f(x) = x^2
x = randn(n)
plot(f.(x), label="x^2")
plot!(x, label="x") # ! add modify global state of plot

# Multiple dispatch
using Distributions, Plots
function plothistogram(distribution, n)
    ϵ = rand(distribution, n)
    histogram(ϵ)
end

lp = Laplace()
plothistogram(lp, 500)

#= Fixed points mapping =#
# While loop styles

using LinearAlgebra

ρ = 1.0
β = 0.9
maxiter = 1000
tolerance = 1.0E-7
v_iv = 0.8

v_old = v_iv
normdiff = Inf
iter = 1

while normdiff > tolerance && iter <= maxiter
    v_new = ρ + β*v_old
    normdiff = norm(v_new - v_old)
    v_old = v_new
    iter = iter + 1
end
println("Fixed Point = $v_old, and |f(x) - x| = $normdiff in $iter iterations")

# For loop style
v_old = v_iv
normdiff = Inf
iter = 1
for i in 1:maxiter
    v_new = ρ + β*v_old
    normdiff = norm(v_new - v_old)
    if normdiff < tolerance
        iter = i
        break
    end
    v_old = v_new
end
println("Fixed Point = $v_old, and |f(x) - x| = $normdiff in $iter iterations")

# improved version
function v_fp(β, ρ, v_iv, tolerance, maxiter)
    v_old = v_iv
    normdiff = Inf
    iter = 1
    while normdiff > tolerance && iter <= maxiter
        v_new = ρ + β*v_old
        norm_diff = norm(v_new - v_old)
        v_old = v_new
        iter = iter + 1
    end
    return (v_old, normdiff, iter)
end

ρ = 1.0
β = 0.9
maxiter = 1000
tolerance = 1.0E-7
v_initital = 0.8
v_star, normdiff, iter = v_fp(β, ρ, v_initital, tolerance, maxiter)
println("Fixed point = $v_star, and |f(x) - x| = $normdiff in $iter iterations")

# passing function in function
function fixedpointmap(f, iv, tolerance, maxiter)
    x_old = iv
    normdiff = Inf
    iter = 1
    while normdiff > tolerance && iter <= maxiter
        x_new = f(x_old)
        normdiff = norm(x_new - x_old)
        x_old = x_new
        iter = iter + 1
    end
    return (x_old, normdiff, iter)
end

ρ = 1.0
β = 0.9
f(v) = ρ+β*v

maxiter = 1000
tolerance = 1.0E-7
v_initial = 0.8

v_star, normdiff, iter = fixedpointmap(f, v_initial, tolerance, maxiter)
println("Fixed point = $v_star, and |f(x) - x| = $normdiff in $iter iterations")

# named function parameter , named tuples
function fixedpointmap(f; iv, tolerance=1.0E-1, maxiter=1000)
    x_old = iv
    normdiff = Inf
    iter = 1
    while normdiff > tolerance && iter <= maxiter
        x_new = f(x_old)
        normdiff = norm(x_new - x_old)
        x_old = x_new
        iter = iter + 1
    end
    return (value = x_old, normdiff=normdiff, iter=iter)
end
ρ = 1.0
β = 0.9
f(v) = ρ + β*v
sol = fixedpointmap(f, iv=0.8, tolerance=1.0E-8)
println("Fixed point = $(sol.value), and |f(x) - x| = $(sol.normdiff) in $(sol.iter) iterations")

# change input function
r = 2.0
f(x) = r*x*(1-x)
sol = fixedpointmap(f, iv=0.8)
println("Fixed point = $(sol.value), and |f(x) - x| = $(sol.normdiff) in $(sol.iter) iterations")

using NLsolve, LinearAlgebra
ρ = 1.0
β = 0.9
f(v) = ρ .+β*v
sol = fixedpoint(f, [0.8]; m=0)
println("Fixed point = $(sol.zero), and |f(x) - x| = $(norm(f(sol.zero) - sol.zero)) in " *
        "$(sol.iterations) iterations")

# Use anonymous function (lambda)
# Use Anderson iteration, less iteration
ρ = 1.0
β = 0.9
iv = [0.8]
r = 2.0
# sol = fixedpoint(v -> ρ .+β*v, iv)
sol = fixedpoint(x -> r.*x.*([1.0]-x), iv)
println("Fixed point = $(sol.zero), and |f(x) - x| = $(norm(f(sol.zero) - sol.zero)) in " *
        "$(sol.iterations) iterations")

# Change to better precision calculation
ρ = 1.0
β = 0.9
iv = [BigFloat(0.8)]
sol = fixedpoint(v -> ρ .+β*v, iv)
println("Fixed point = $(sol.zero), and |f(x) - x| = $(norm(f(sol.zero) - sol.zero)) in " *
        "$(sol.iterations) iterations")

# With broadcast, could change to Array
ρ = [1.0, 2.0, 0.1]
β = 0.9
iv = [0.8, 2.0, 51.0]
sol = fixedpoint(v -> ρ .+β*v, iv)
println("Fixed point = $(sol.zero), and |f(x) - x| = $(norm(f(sol.zero) - sol.zero)) in " *
        "$(sol.iterations) iterations")

# Use macro to run the code easily
using NLsolve, StaticArrays
ρ = @SVector [1.0, 2.0, 0.1]
β = 0.9
iv = [0.8, 2.0, 51.0]
sol = fixedpoint(v -> ρ .+ β * v, iv)
println("Fixed point = $(sol.zero), and |f(x) - x| = $(norm(f(sol.zero) - sol.zero)) in " *
        "$(sol.iterations) iterations")

#===== Exercise =====#
function factorial2(n)
    out = 1.0
    for i in 1:n
        out = out*i
    end
    return out
end

function binomial_rv(n, p)
    rv = rand(n)
    flag = (rv .< p)
    return sum(flag)
end

function monte_π(n)
    x = rand(n)
    y = rand(n)
    in_radious = 0

    for i in 1:n
        xy_dist = sqrt(x[i]^2 + y[i]^2)
        if xy_dist <= 1
            in_radious += 1
        end
    end

    proportion = in_radious / n
    pi = proportion * 4
    
    return pi
end

function flip10coins()
    rv = rand(10)
    head_count = 0.5 .>= rv
    pay = 0.0
    for i in 1:10
        if i > 7
            i = 7
        end
        sum3consec = sum(head_count[i:i+3])
        if sum3consec == 3
            pay = 1.0
        end
    end
    println(head_count)
    return pay
end

using Distributions, Plots
n = 200
x = zeros(n)
α = 0.9
# ϵ = rand(error, 200)
for t in 1:n-1
    x[t+1] = α*x[t] + rand(Normal())
end
plot(x)

using Distributions, Plots
p = plot()
for α in [0.0, 0.8, 0.98]
    n = 200
    x = zeros(n)
    for t in 1:n-1
        x[t+1] = α*x[t] + rand(Normal())
    end
    plot!(p, x, label="α = $(α)")
end

using Distributions, Plots
