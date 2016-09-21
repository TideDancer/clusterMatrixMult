% random matrix test 
clear;
delta = 1e-2;  % failure probability
epsilon = 1e-2; % error norm <= epsilon ||A|| ||B||
beta = 1;
const = 1;

matrix = 'high condition';
cond_num = 10^5;

r = 2^7;
c = 2^20;

tic;
% % build coherent matrix
% Z = zeros(dim); I = eye(dim); O = ones(dim).*1e-8; 
% R = rand(dim).*1e-8; alphaB = randn(dim)*1e8;
% A = [A(1:dim/2, :); Z(1:dim/2, :)] + O;
% B = [B(:, 1:dim/2)  Z(:, 1:dim/2)] + O;

%%%% dexter %%%%%
% load('dexter.mat');
% A = dexter1; B = dexter2';
% min(leverage(A))

% %%%% heart1 %%%%%
% load('goodwin.mat');
% A = full(Problem.A)./1000;
% B = A(randperm(end),randperm(end));

% ------- geometrically distributed singular values ------
% A = gallery('randsvd', dim ,cond_num, 3);
% B = gallery('randsvd', dim ,cond_num, 3);
% disp('gallery(randsvd, dim ,cond_num, 3)');

% ------- randn matrix ------
Acell = cell(1,16); Bcell = cell(1,16);
parfor i=1:16
  Acell{i} = randn(r,c);
  Bcell{i} = randn(c,r);
end
A = []; B = [];
for i = 1:16
  A = [A;Acell{i}];
  B = [B,Bcell{i}];
end 

%% ------- crazy matrix --------
% A = gallery('sampling', dim);
% B = gallery('chebspec',dim,1);
% disp('gallery(sampling,dim),gallery(chebspec,dim,1)');

toc;
disp('generating done');

% start computing
tic;
[C_approx1, numSample]= basicMatrixMult(A, B, 'column2norm', [delta, epsilon, beta]);
toc;
tic;
C_approx2 = clusterMult(A, B, [round(numSample), epsilon]);
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
disp(error1_norm/AB_norm);

error2 = C - C_approx2;
error2_norm = norm(error2, 'fro');
disp(error2_norm/AB_norm);

