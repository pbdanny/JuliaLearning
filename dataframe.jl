using DataFramesMeta
using Parquet2
using Statistics
using CategoricalArrays
using GLM
using Plots
using HypothesisTests

ds = Parquet2.Dataset("/home/danny/Downloads/puzzles.parquet")
df = DataFrame(ds)

names(df)
select(df, "Themes")
select(df, :Themes)
@select(df, :Themes)

# Mixed column select symbol, index num
select(df, "Themes", 4 , [:Rating, :Moves])
@select(df, :Themes, :NbPlays)
@select(df, $"Themes", $["Rating", "Moves"])

names(df)

names(select(df, Not(:Moves)))
names(select(df, Between(:Popularity, :OpeningFamily)))

names(df)
select(df, r"^[M|T|P]")

select(df, r"s$")
select(df, Cols(endswith("s")))

select(df, Not(:Moves))

select(df, Not(Cols(==(:Rating))))

select(df, :Themes => :theme)

select(df, Cols(endswith("s")) .=> identity .=> lowercase)
transform(df, Cols(endswith("s")) .=> identity .=> lowercase)