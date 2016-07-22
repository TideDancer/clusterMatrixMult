% random matrix test 
dim = 2^8;

%A = squareMatrixGen(dim, 'dense', 'normal');
%B = squareMatrixGen(dim, 'dense', 'normal');

errRatio1 = []; errRatio2 = [];

for randsvd_mod = 1:5
for k = 8:8
cond_num = 10^k;

A = gallery('randsvd', dim ,cond_num, randsvd_mod);
B = gallery('randsvd', dim ,cond_num, randsvd_mod);

Z = zeros(dim); I = eye(dim); O = ones(2*dim).*1e-8;
A = [A Z; Z I] + O;
B = [B Z; Z I] + O;

tic;
C_approx1 = basicMatrixMult(A, B, 'column2norm', 1); % coloum 2-norm based sampling
toc;
tic;
C_approx2 = clusterMult(A, B, []);
toc;



% ------------------- compare --------------------------
tic;
C = A*B;
toc;
A_norm = norm(A, 'fro');
B_norm = norm(B, 'fro');
AB_norm = A_norm * B_norm;
C_norm = norm(C, 'fro');

error1 = C - C_approx1;
error1_norm = norm(error1, 'fro');
errRatio1 = [errRatio1 error1_norm/AB_norm];

error2 = C - C_approx2;
error2_norm = norm(error2, 'fro');
errRatio2 = [errRatio2 error2_norm/AB_norm];

end
end
