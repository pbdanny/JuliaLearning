using DataFrames
using CSV
using Statistics

pre = DataFrame(CSV.File("listerine_offline_conversion_090622_290622.csv"))
new = DataFrame(CSV.File("rerun_offline_conversion.csv"))

nrow(pre)
nrow(new)

mean(pre[:, :value])
mean(new[:, :value])


nrow(unique(pre[:, [:golden_record_external_id_hash]]))
nrow(unique(new[:, [:golden_record_external_id_hash]]))
