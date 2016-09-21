% in Drines paper
% A m*n, B n*p
% sample c columns of A and corresponding rows of B
% sampleType corresponds to those in sample.m

function [C_approx, sampleSize] = basicMatrixMult(A, B, sampleType, parameterList);

[r, n] = size(A);
delta = parameterList(1);
epsilon = parameterList(2);
beta = parameterList(3);

% ------------- multiplication routing -------------
[pdf, cdf] = sample(A,B,sampleType,beta);

if beta > 1
  beta = 1;
end
yita = 1+sqrt(8/beta*log10(1/delta));
c = round(yita^2 / beta / epsilon^2);
if c > n
  disp('c > n, so no result will be produced')
  C_approx = []; sampleSize = c;
  return;
end

ind = datasample(1:length(pdf), c, 'Replace', false, 'Weights', pdf);
ind = sort(ind); % need to be sorted thus add them in orders to C and R

C = []; R = [];
for i = 1:c
  C = [C  A(:,ind(i))./sqrt(c*pdf(ind(i)))];
  R = [R; B(ind(i),:)./sqrt(c*pdf(ind(i)))];
end

C_approx = C*R; 
sampleSize = c;
  
return;

