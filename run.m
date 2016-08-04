% random matrix test 
dim = 2^9;

%A = squareMatrixGen(dim, 'dense', 'normal');
%B = squareMatrixGen(dim, 'dense', 'normal');

errRatio1 = []; errRatio2 = [];

for randsvd_mod = 1:5
for k = 1:1
cond_num = 10^k;

% seed matrix
A = gallery('randsvd', dim ,cond_num, randsvd_mod);
B = gallery('randsvd', dim ,cond_num, randsvd_mod);

% build coherent matrix
Z = zeros(dim); I = eye(dim); O = ones(dim).*1e-8; 
R = rand(dim).*1e-8; alphaB = randn(dim)*1e8;
A = [A(1:dim/2, :); Z(1:dim/2, :)] + O;
B = [B(:, 1:dim/2)  Z(:, 1:dim/2)] + O;

%%%% dexter %%%%%
% load('dexter.mat');
% A = dexter1; B = dexter2';
% min(leverage(A))

%%%% heart1 %%%%%
load('goodwin.mat');
A = full(Problem.A)./1000;
B = A(randperm(end),randperm(end));

% start computing
tic;
[C_approx1, numSample] = basicMatrixMult(A, B, 'column2norm', 1); % coloum 2-norm based sampling
toc;
tic;
%C_approx2 = clusterMult(A, B, round(numSample));
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
