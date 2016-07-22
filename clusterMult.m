% doing clustering based matrix multiplication

function C_approx = clusterMult(A, B, parameterList);

[r, n] = size(A);
c = round(log10(n));

tic;
% perform clustering
tagA = kmeans(A', c);
toc;

% put [idx of original column, tag column] together to perform sampling
% dimension 2 is the value of actual idx of original column
tagA = [tagA, (1:n)'];

% sort rows based on tag
sortedTag = sortrows(tagA);

% sample 1 element in each cluster
ind = [];
start = 1;
for i = 2:length(sortedTag)
  if sortedTag(i) == sortedTag(i-1)
    continue;
  else
    len = i - start;
    id = datasample(1:len, 1);
    ind = [ind; sortedTag(start + id -1, 2)];
    start = i;
  end
end
if i > start
  len = i - start;
  id = datasample(1:len, 1);
  ind = [ind; sortedTag(start + id -1, 2)];
else
  ind = [ind; sortedTag(i, 2)];
end

% perform multiplication
ind = sort(ind); % need to be sorted thus add them in orders to C and R
C = []; R = [];

% since sample 1 element in each cluster, probability for each cluster is 1/c, thus each col./sqrt(p*1/c) = col./1 = col itself
for i = 1:c
  C = [C  A(:,ind(i))];
  R = [R; B(ind(i),:)];
end

C_approx = C*R; 
  
return;
