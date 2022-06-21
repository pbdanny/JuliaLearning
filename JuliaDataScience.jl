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
G[1] # data
G[1][1] # data , at col 1
G[1][1][1:10] # data, at col 1 from row 1:10