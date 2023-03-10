function [Z,obj] = LSR1( X , lambda )

%--------------------------------------------------------------------------
% Code reference
% Lu, Can-Yi :Robust and efficient subspace segmentation via least squares regression
%--------------------------------------------------------------------------

% Input
% X             Data matrix, dim * num
% lambda        parameter, lambda>0


% Output the solution to the following problem:
% min ||X-XZ||_F^2+lambda||Z||_F^2
%   s.t. diag(Z)=0

% Z             num * num

if nargin < 2
    lambda = 0.001 ;
end
[dim,num] = size(X) ;


% for i = 1 : num
%    X(:,i) = X(:,i) / norm(X(:,i)) ;
% end


I = eye(num) ;
invX = I / (X'*X+lambda*I) ;
Z = zeros( num , num ) ;
for i = 1 : num
    Z(:,i) = invX(:,i) / invX(i,i) ;
    Z(i,i) = 0 ;
end
Z = -1 * Z ;
obj = sum(sum((X-X*Z).^2));
PI = Z > 0;
Z = Z.*PI;
Z = abs( (Z + Z') / 2);