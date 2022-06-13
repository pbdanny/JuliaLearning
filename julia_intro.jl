println("Hello")

my_var = 42
typeof(my_var)

π = 3.414
typeof(π)

😸 = "Smile cat"
typeof(😸)

🦮  = "Dog barking"
🦮 + 😸

α = 10
β = 20
α + β

days = 365
typeof(days)
days_float = convert(Float16, days)
@assert days == 365
@assert days_float == 365.0

convert(Int64, "1")

typeof('a')
typeof("a")
typeof('abc')

println("Hello i have $α")
println("Hello i have more then total is $(α + β)")

print(string("Start", 10, "end"))

s1 = "First"
s2 = "Next"
s1*s2
"$s1$s2"

# Data struct
phone = Dict("Hellen"=> "209002", "Jane"=>"2039")
phone["John"] = "34299"
pop!(phone, "Hellen")

ani = ("cat", "dog", "bird")
ani[1]
ani[1] = "bat"

fri = ["Ted","Bryan","Jim"]
fri[1]
fri[1] = "Betty"
fri
fri[4] = "Steve"
push!(fri, "Steve")
fri
pop!(fri)

book = [["A", "B"], ["C", "D"]]
book
rand(2,4)

# Loop
n = 0
while n < 10
    println("$n")
    n +=1
end

for n in 1:10
    println(n)
end

friends = ["John", "Jim", "Larry"]
for friend in friends
    println("I have $friend as friend")
end

for n ∈ 1:10
    println(n)
end

m, n = 5, 5
A = zeros(m, n)

for i in 1:m
    for j in 1:n
        A[i, j] = i+j
    end
end
A

B = zeros(m, n)
for i in 1:m, j in 1:n
    B[i, j] = i + j
end
B
# Array comprehension
C = [i + j for i in 1:m, j in 1:n]

for n in 1:10
    A = [i + j for i in 1:n, j in 1:n]
    display(A)
end

# Condition
x = round(rand()*10)
y = round(rand()*10)
if x > y
    println("x ($x) > y ($y)")
elseif y > x
    println("y ($y) > x ($x)")
else
    println("Tied $x = $y")
end

# ternary operator
x = round(rand()*10)
y = round(rand()*10)
x > y ? println("x > y") : println("x <= y")

# Function
function sayhi(name)
    println("Hi $name")    
end
sayhi("Gorge")

# one row function define
sayhi(name) = println("Hi hello $name")
sayhi("Gorge")

# lambda (I)
sayhi3 = name -> println("Yo $name")
f3 = x -> x + x^2

# lambda (II)
sayhi4(name) = println("Yo $name")
f4(x) = x + x^2

# Duck typing
# Julia will try work with input of function when the operation possible to infer
sayhi3(123)
A = rand(2,2)
sayhi3(A)
f3(A)
M = rand(2)
f3(M)

# Mutate , following function name with ! , Mutate
v = [5, 2, 1]
v
sort(v)
v
sort!(v)
v
u = (4, 2, 1)
sort(u)

# Broadcasting
# put `.` function name and argument list
A = [i + 3*j for j in 0:2, i in 1:3]
# not Broadcasting version equal to A + A^2
f3(A)
# Broadcasting version
f3.(A)
f3.(v)

# Package management
# REPL `]`
using Pkg
Pkg.add("Example")
using Example
hello("Me")

# Plotting
x = -3:0.1:3
f(x) = x^2
y = f.(x)

plot(x, y , label="line")
# use mutate ! to add plot on top
scatter!(x, y, label="Points")

# Multiple dispatch
# show multiple dispatch variants
methods(+)
# show which method using
@which 3+3
@which 3.0+3.0
@which 3.0+3

# Extend method
import Base: +
@which "hello" + "hello"
+(x::String, y::String) = string(x, y)
"hello" + "worl"
@which "hello" + "hello"

foo(x, y) = println("duck type fn")
foo(x::Int, y::Float64) = println("One Int, One float")
foo(x::Float64, y::Float64) = println("Both are Float")
foo(x::Int, y::Int) = println("Both are Int")

# Struct 
struct MyObj
    Field1
    Field2
end

myob = MyObj("Hello", "world")
myob.Field1
myob.Field2

myob.Field1 = "Cast"

# mutable struct
mutable struct Person
    name::String
    age::Float64
end
logan = Person("Logan", 44)
logan.age
logan.name
logan.age = 45
logan.age
logan.age = "12"

# Default attribute, with new contstructor
mutable struct Person2
    name::String
    age::Float64
    isActive::Bool

    function Person2(name, age)
        new(name, age, true)
    end
end
newperson = Person2("Logan", 27)

function birthday(person::Person2)
    person.age +=1
end

birthday(newperson)
birthday(newperson)
newperson.age