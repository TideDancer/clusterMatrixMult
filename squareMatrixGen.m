% generate square matrix

% input:
% dim: dimension of matrix generated, will be changed to closest power of 2 values
% type: dense, sparse, etc
% dist: distribution of the matrix generated, 'normal', 'uniform', etc
% if type == sparse, parameterList(1) will be density value 0<density<1

% output: generated squared matrix

function M = MatrixGen(r, c, type, dist, parameterList);

if strcmp(type, 'dense')

  if strcmp(dist, 'normal')
    M = randn(r,c);

  elseif strcmp(dist, 'uniform')
    M = rand(r,c);


elseif strcmp(type, 'sparse')
  density = parameterList(1);

  if strcmp(dist, 'normal')
    M = sprandn(n, n, density);

  elseif strcmp(dist, 'uniform')
    M = sprand(n, n, density);

  end


end

return;


