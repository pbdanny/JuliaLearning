using Distributions
using Makie
using CairoMakie

x = 1:10
fig = lines(x, x.^2; label="Parabola")
axislegend()
fig

# Assumed 17 success from total 1134
# p of success = 17/1134 = 0.014

y = 1:50
b = Binomial(1134, 0.015)
fig = barplot(y, pdf.(b, y); label="PMF Binomial", axis = (;title="17 success from 1134 trial"))
axislegend()
fig


pdf(b, 2)