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

# lambda
sayhi3 = name -> println("Yo $name")
f3 = x -> x + x^2

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