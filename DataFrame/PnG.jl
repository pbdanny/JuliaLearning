using CSV
using DataFrames
using Statistics

# Basic constructor
df = DataFrame()
df = DataFrame(A=1:3, B=5:7, fixed=1)
df = DataFrame("customer age" => [15, 20, 25],
                "first name" => ["Danny", "Sally", "Arnold"])
dict = Dict("Customer aging" => [1, 3, 5],
            "last name" => ["Dominique", "McArther", "Bold"])
df = DataFrame(dict)
df = DataFrame([1 3 5; 2 4 6; 3 7 9], :auto)
df = DataFrame([1 3 5; 2 4 6; 3 7 9], ["a", "b", "c"])

# Reading from CSV
src = DataFrame(CSV.File("20220512_salesreport_promowk.csv"))

# Inspect dataframe property
propertynames(src)
eltype.(eachcol(src))

# Index [,] could referring with variavle
col = "SKU_ID"
src[!, col]

# Index with !, inplace reference
src.SKU_ID === src[!, "SKU_ID"]
src.SKU_ID === src[:, "SKU_ID"]

# Getting dataframe information
names(src)
size(src)
size(src, 1)
size(src, 2)
nrow(src)
ncol(src)
describe(src)
describe(src, cols=1:3)
show(src, allcols=true)
first(src, 5)
last(src, 5)

mean(src."SKU_ID")
mapcols(SKU_ID -> SKU_ID .^2, src)

# Indexing
src[1:5, :]

# Return as DataFrame 
src[!, [:SKU_ID]]
src[:, ["SKU_ID"]]

# Return as Vector
src."SKU_ID"
src.:SKU_ID
src.SKU_ID
src[!, :SKU_ID]
src[:, "SKU_ID"]

# View of dataframe
view(src, :, 2:5)
@view src[end:-1:1, [1,4]]

# Adjust dataframe
df = src[1:5, 1:3]
df."SKU_DESCRIPTION" = ["x", "y", "z", "a", "b"]
df

# Broadcast assignment
df = src[1:5, 1:3]
df."SKU_DESCRIPTION" .= "x"
df

df[!, :SKU_DESCRIPTION] .= "y"
df
# special case when Broadcast assigment, : , ! mutate (inplace)
df[:, :SKU_DESCRIPTION] .= "z"
df

# Advance Indexing
src[:, Not(:SKU_ID)]
src[:, Between(:SKU_ID, :MANUFACTURER)]
src[:, Cols(:SKU_ID, Between(:BRAND, :CARDED_VISIT))]
src[Not(1:5), r"^C"]
src[1:5, r"^C"]

# dataframe transformation
# combine = aggregte / select = Broadcast aggregte
combine(src, :CARDED_VISIT => sum => :sum_visit)
select(src, :CARDED_VISIT => sum => :sum_visit)
combine(src, "CARDED_VISIT" => sum => :sum_carded_visit, "CARDED_SALES" => sum => :sum_carded_sales)
transform(src, :CARDED_VISIT => sum)[:, r"CARDED"]

src[src.SKU_ID .== 27164063, :]
combine(src[src.SKU_ID .== 27164063, :], :SALES=> sum)
combine(groupby(src[src.:SKU_ID .== 27164063, :], :STORE_FORMAT), [:VISIT, :SALES] .=> sum)

src[:, r"SALES$|VISIT$|UNITS$"]
names(src, Float64)