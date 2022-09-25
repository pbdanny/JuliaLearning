### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 58ef5cec-c935-11eb-06b1-714bc68ea024
md" # Gradient Descent"

# ╔═╡ 16cbf73b-d132-4a98-87a1-ffa3b342699d
function gradient_descent(gradient, start, learning_rate, n_iter=50, tolerance=1e-6)
	vector = start
	for i = 1:n_iter
		diff = -learning_rate*gradient(vector)
		abs.(diff).<=tolerance && break
		vector += diff
	end
	return vector
end

# ╔═╡ 20f393fe-6b65-4bda-a8a7-ccf94155eff1
function cost_function(theta, x, y)
	hypo = hypothesis(theta, x)
	cf = ((hypo - y)^2)/(2*len(x))
	return cf
end

# ╔═╡ a4eaa2d0-784a-49fc-8ac6-5ebfd5ef4183
begin
	x = 10
	y = 20
	theta = 1
end

# ╔═╡ 1d1c2bfb-9bd0-417e-b3df-d59aed8df693
cost_function(theta, x, y)

# ╔═╡ 5a4dede6-a609-49c7-8061-300ccce81175
A = [1 2 -3]

# ╔═╡ b7b2ccc9-ca9e-4383-873c-bf4173f81158
all(A .> 1)

# ╔═╡ 60c634a2-3ecd-4eb8-869a-beeaf71c6efd
abs.(A).>1

# ╔═╡ Cell order:
# ╟─58ef5cec-c935-11eb-06b1-714bc68ea024
# ╠═16cbf73b-d132-4a98-87a1-ffa3b342699d
# ╠═20f393fe-6b65-4bda-a8a7-ccf94155eff1
# ╠═a4eaa2d0-784a-49fc-8ac6-5ebfd5ef4183
# ╠═1d1c2bfb-9bd0-417e-b3df-d59aed8df693
# ╠═5a4dede6-a609-49c7-8061-300ccce81175
# ╠═b7b2ccc9-ca9e-4383-873c-bf4173f81158
# ╠═60c634a2-3ecd-4eb8-869a-beeaf71c6efd
