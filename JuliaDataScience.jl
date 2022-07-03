using DelimitedFiles
using BenchmarkTools

# Downloaf file
car = download("https://raw.githubusercontent.com/plotly/datasets/master/mtcars.csv", "mtcars.csv")
P, H = readdlm("mtcars.csv", ',';header=true)
# P = data, H = header
writedlm("write_mt.txt", P, '-')

using CSV
using DataFrames
# CSV have to specific sink type, default DataFrame
C = CSV.read("mtcars.csv", DataFrame)
typeof(C)
@show typeof(C)
C[1:10,1:4]
C[1:10,[:manufacturer,:mpg]]
C.manufacturer
C.mpg

# CSV read faster
@btime P, H = readdlm("mtcars.csv", ',';header=true)
@btime C = CSV.read("mtcars.csv", DataFrame)

# DataFrame
names(C)
describe(C)
CSV.write("CSV_mt_write.csv", C)

# Excel
using XLSX
# Load range in sheet
T = XLSX.readdata("mtcars.xlsx", # file name
                  "mtcars", # sheet name
                  "A1:F9" # range
                  )
# Load whole sheet
G = XLSX.readtable("mtcars.xlsx", "mtcars")
# XLSX yield tuple of 2 vector
# G[1] = data , Vector of Vector
# G[2] = column name, Vector
G[1] # data
G[1][1] # data , at col 1
G[1][1][1:10] # data, at col 1 from row 1:10

G[2][1:10] # column name

# Create data from from XLSX
D = DataFrame(G[1], G[2])
D = DataFrame(G...) # use splat to unwarp tuple

combine(D, :manufacturer, size)

# Create dataframe operation
foods = ["apple", "cucumber", "tomato", "Banana"]
calories = [105, 47, 33, 105]
price = [0.85, 1.6, 0.8, 0.6]
df_cal = DataFrame(item=foods, calories=calories)
df_price = DataFrame(item=foods, price=price)
# Join dataframe
df_join = innerjoin(df_cal, df_price,on=:item)

# Creat DataFrame from matrix
DataFrame(T, :auto)

XLSX.writetable("write_XLSXobj_with_XLSX.xlsx", D)

# Julia Dict
d = Dict("a"=>1, "b"=>2, "c"=>3)
d = Dict{String, Integer}("a"=>1, "b"=>2) # with type definition
# creae element of dicf with list comprehension
d = Dict(string(i)=>sind(i) for i = 0:5:360) # create with for Loop
# Create empty dict
d = Dict{String, Int64}()
d = Dict()

#=
Traversing data
1) Matrix
=#
function find_mft_from_mpg(T, mpg::Int)
    loc = findfirst(T[:,2] .== mpg)
    return T[loc,1]
end
find_mft_from_mpg(T, 21)

function find_mft_from_mpg_hndlng_err(T, mpg::Int)
    loc = findfirst(T[:, 2] .== mpg)
    !isnothing(loc) && return T[loc, 1]
    error("Not found manufacturer")
end
find_mft_from_mpg_hndlng_err(T, 21)
find_mft_from_mpg_hndlng_err(T, 22)

function find_all_mft_mpg_hndlng_err(T, mpg::Int)
    locs = findall(T[:, 2] .== mpg)
    !isempty(locs) && return T[locs, 1]
    error("Could not find manufacturer")
end
find_all_mft_mpg_hndlng_err(T, 21)

# Traversing 2) DataFrame
D[D.mpg .>= 23, :]
D[:mpg >=23, :]
nrow(D[D.mpg .>= 23, :])