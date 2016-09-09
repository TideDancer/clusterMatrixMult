% doing clustering based matrix multiplication

function C_approx = clusterMult(A, B, parameterList);

[r, n] = size(A);
numCluster = parameterList(1)
epsilon = parameterList(2);

tic;
% perform clustering
% ------------direct kmenas --------------
% tagA = kmeans(A', numCluster);

% ------------direct hashing -------------
hash = rand(1,r);
group = hash*A;
group = round(group.* numCluster / (max(group)-min(group)) - min(group));
tagA = mod(group,numCluster);
tagA = tagA';

% ----------- projection ----------------
% rr = round(log10(r)/epsilon^2);
% disp(rr/r);
% proj = randn(rr,r)*A;
% tagA = kmeans(proj', numCluster);

% ----------- hash-inbucket-clustering ----------
% numBucket = round(sqrt(numCluster));
% hash = rand(1,r);
% group = abs(hash*A);
% group = round(group.*(1/min(group)));
% bucketA = mod(group,numBucket);
% bucketA = [bucketA', (1:n)'];
% sortedBucket = sortrows(bucketA)
% -------- not finished next is in-group clustering --------

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

% since sample 1 element in each cluster, probability for each cluster is 1/c, thus each col./sqrt(p*c) = col./1 = col itself
for i = 1:length(ind)
  C = [C  A(:,ind(i))];
  R = [R; B(ind(i),:)];
end

C_approx = C*R/(n/numCluster); 
  
return;
