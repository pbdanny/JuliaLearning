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

#---- Column selection
select(df, "Themes")
select(df, :Themes)
# meta DataFrame, use symbol or $"column name"
@select(df, :Themes)
@select(df, $"Themes")

# column selection able to combine both column name, index, symbol
select(df, "Themes", 4 , [:Rating, :Moves])
@select(df, :Themes, :NbPlays)
@select(df, $"Themes", $["Rating", "Moves"])

# function for column selection
# Not(), for dropping the column
names(select(df, Not(:Moves)))
# Between()
names(select(df, Between(:Popularity, :OpeningFamily)))

# regex for column selection
select(df, r"^[M|T|P]")
select(df, r"s$")

# use Cols with predicate
select(df, Cols(endswith("s")))
# below command will error if Not() with not presented column naame
select(df, Not(:X))
# use Not(Cols(==(:)))
select(df, Not(Cols(==(:X))))
# for use Not(regex)
select(df, Not(r"^X"))

#---- Column transformation

# rename column =>
select(df, :Themes => :theme)
# behide the scene
select(df, :Themes => identity(:theme))
# also behide the scene
select(df, :Themes => identity => :theme)

# Select , broadcast function with .=> identity
# identity, to operate the function on column name, not the data inside
# use .=> since Cols(endswith(" ")) return Array, then need to broadcast to next fn.
select(df, Cols(endswith("s")) .=> identity .=> lowercase)
select(df, Cols(r"s$") .=> identity .=> lowercase)
# coloumn transformation
transform(df, Cols(endswith("s")) .=> identity .=> lowercase)

# Order the column
select(df, :OpeningFamily, [1, 4])
# move to end
select(df, Not(:Moves), :Moves)

# select when duplicate, show only OpeningFamily
select(df, Between(1, 3), Between(3, 5))
names(df, Between(2, 5))
names(df, Cols(r"s$"))

# Aggregation
select(df, [:Rating, :Popularity, :NbPlays] .=> mean .=> uppercase)
