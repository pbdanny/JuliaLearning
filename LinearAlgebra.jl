using LinearAlgebra
using SparseArrays
using Images

A = randn(5, 5)
# Symetric metrix
C = A'*A
isposdef(C)
@show C[1,2] == C[2,1]
C[1,2] == C[2,1]

# Solve linear equation Ax = b
b = rand(Int8, 5)
# A\b -> faster solution than inverse
x = A\b
# check if x is the solution for Ax=B
norm(A*x - b) # Should close to 0, the rest is precision

@show typeof(A)
@show typeof(b)
@show typeof(rand(1,10))
@show typeof(B)
# Copy matrix
D = copy(B)

# Factorization
# LU Factorization L*U = P*A
luA = lu(A)
# lu(A) yield 3 matrix , Lower triangular : L, Upper Triangular :U
# and Permutation matrix : P
# all satisfied L*U = P*A
norm(luA.L*luA.U - luA.P*A) # should close to zero

# QR Factorization
# Q*R = A
# Q = orthogonal matrix: Q ,R = Upper Triangular : R
qrA = qr(A)
norm(qrA.Q*qrA.R - A)
# Q is othogonal, transpose = invert
qrA.Q' == inv(qrA.Q) 

# Cholesky Factorization
# L*L' = A
cholA = cholesky(C)
cholA.L
cholA.Upper

# Auto select factoring methods, best fits
factorize(A)

# Diagonal 
diagm([1,2,3])
Diagonal([1,2,3]) # memory efficient version
I(3)

# I could use as varible
A+10I

# Sparse matrix
S = sprand(5,5,2/5)
S.rowval
S.n

#= 
Images
=#
X1 = load("./MIT/philip.jpg")
typeof(X1)
size(X1)
X1[1,1] # pixel at 1,1

Xgray = Gray.(X1)
# extract RGB
R = map(i->X1[i].r, 1:length(X1))
R = Float64.(reshape(R, size(X1)...))
G = map(i->X1[i].g, 1:length(X1))
G = Float64.(reshape(G, size(X1)...))
B = map(i->X1[i].b, 1:length(X1))
B = Float64.(reshape(B, size(X1)...))

# Get RGB - B part
Z = zeros(size(R)...)
RGB.(Z,Z,B)

# Gray value
Xgrayval = Float64.(Xgray)