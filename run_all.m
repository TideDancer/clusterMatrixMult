% random matrix test 

%A = squareMatrixGen(dim, 'dense', 'normal');
%B = squareMatrixGen(dim, 'dense', 'normal');

% seed matrix
% A = gallery('randsvd', dim ,cond_num, randsvd_mod);
% B = gallery('randsvd', dim ,cond_num, randsvd_mod);
% 
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


delta = 1/dim;  % failure probability
epsilon = 1e-1; % error norm <= epsilon ||A|| ||B||
beta = 1;
const = 1;

density = 'dense';
distribution = 'uniform';
matrix = 'high condition';
cond_num = 10^5;

% ------- geometrically distributed singular values ------
% A = gallery('randsvd', dim ,cond_num, 3);
% B = gallery('randsvd', dim ,cond_num, 3);
% disp('gallery(randsvd, dim ,cond_num, 3)');

% ------- square matrix ------
A = squareMatrixGen(dim, density, distribution);
B = squareMatrixGen(dim, density, distribution);

%% ------- crazy matrix --------
%A = gallery('sampling', dim);
%B = gallery('chebspec',dim,1);
%disp('gallery(sampling,dim),gallery(chebspec,dim,1)');


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

