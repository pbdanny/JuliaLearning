using DataFramesMeta
using Parquet2
using Statistics
using CategoricalArrays
using GLM
using Plots
using HypothesisTests

ds = Parquet2.Dataset("/home/danny/Downloads/puzzles.parquet")
df = DataFrame(ds)