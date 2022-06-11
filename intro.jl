# --------------
# Getting start
# --------------

# check methods support operator
methods(+)
methods(transpose)

# definition of type
fieldnames(UnitRange)

# find code line used
@which copy([1,2,3])

# type of Variable
typeof(A)

# Vector / Matix
a = [1;2;3]

# Vector of float, 5 elements with undefined value
a = Vector{Float16}(undef, 5)

b = [4 5 6] # row vector
A = [1 2 3; 4 5 6]

# Element access
a[1]

# elements assing value
a[1] = -2.3
a

# 1-index system
A[1,2]
A[:,1]

# Matrices definition
M = Matrix{Float16}(undef, 4, 2)

# Matrics inline
M = [1 2 3
     4 5 6]

M[1,3]

transpose(A)
a = [1;2;3]

# Array based on memory
# assing operator = point to same memory
c = a
c[1] = -100
a
d = copy(a)
a[2] = -2
d

# zeros, one Matrix
g = zero(A)
i = one(A)

# control flow
for i=1:5
    println(i)
end

t = 0
while t<5
    println(t)
    t+=1
end

school = :UCI

if school==:UCI
    println("ZotZotZot")
else
    println("Not even worth discussing.")
end

for i=1:2, j=1:3
    println(i, j)
end


# Linear Algebra
using LinearAlgebra
# dot operation
a'*c # return as Array
dot(a,c) # return as Scalar

# Identity / Zeros / Ones Matix
I(2)
I(3)
zeros(4,1)
ones(2,3)

# inverse
B = [1 3 2; 3 2 2; 1 1 1]
inv(B)
B * inv(B)

# Create Array
A = Array{Float32}(undef, 3,2)
A[1,1] = 0.1

# Create Tuple
pairs = Array{Tuple{Int8, Int8}}(undef, 3)
pairs[1] = (2,1)
pairs[2] = (1,2)

# Indics, Range
a = [10; 20; 30; 40; 50; 60; 70; 80; 90]
a[1:3]
a[3:end]
b = collect(a[3:end]) # create new Array

# Range with step
b = collect(1:2:7) # start at 1, step = 2, end at 7

# Matrix elements
A = [1 2 3; 4 5 6; 7 8 9]
A[:,2]
A[:,2:end]

# Printing
print("Hello ");print("World")
a = 123
print("Variable a have value ", a)
print("a have $a, and a-10 = $(a-10)")

b =[1;3;10]
print("2nd elements of b is $(b[2])")

# print with macro
using Printf
@printf("%10.2f", a)

# Forloop 
for i in 1:3
    println("Line number $(i)")
end

# Dict
my_keys = ["Zinedine Zidane", "Magic Johnson", "Yuna Kim"]
my_values = ["football", "basketball", "figure skating"]

d = Dict()

for i in 1:length(my_keys)
    d[my_keys[i]] = my_values[i]
end

d = Dict("A"=>1, "B"=>2, "C"=>"C")

# Function
# Full form
function f(x, y)
    return 3x+y
end
# inline functions
f(x, y) = 3x+y
f(x, y) = 3x, 2y

function f(x, y)
    return 3x, 2y
end

# Random number
rand()  # Uniform
rand(5)
rand(3,3)

# Random in index
rand(1:10)

# Standard random
randn(2,3)

# Statistic package
using StatsFuns
mu = 50; sigma = 3;
normpdf(mu, sigma, 52)
normcdf(mu, sigma, 50)
norminvcdf(mu, sigma, 0.5)

# File operation
# text file
open("data.txt") do file
    data = readlines(file)
end

for line in data
    print(line)
end

using CSV, Plots

data = CSV.File("data.csv")