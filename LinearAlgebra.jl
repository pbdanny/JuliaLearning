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