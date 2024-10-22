function [root,ea,iter]=Project_Secant(func,x0,x1,errType,es,maxit,varargin)
% $Author: Alex Gibbons
% [root,ea,iter]=secant(func,x0,x1,errType,es,maxit,p1,p2,...):
% uses secant method to find the root of func
% requires input for 1 of 3 stopping criterion
%input:
% func = name of function
% x0, x1 = lower and upper guesses
% errType = which of the 3 stopping criterion user would like to use
% es = desired stopping criterion (default = 0.0001%)
% maxit = maximum allowable iterations (default = 50)
% p1,p2,... = additional parameters used by func
%output:
% root = real root
% ea = one of 3 types of errors
% iter = number of iterations
if nargin<3,error('at least 3 input arguments required'),end
if nargin<4|isempty(errType), errType = 1;end
if nargin<5|isempty(es), es=0.0001;end
if nargin<6|isempty(maxit), maxit=50;end
temp = x1;
iter = 0;
if abs(func(x0, varargin{:}))<abs(func(x1,varargin{:}))
    x1=x0;
    x0=temp;
end
while(1)
    x2 = x1-func(x1, varargin{:})*(( x0-x1 )/(func(x0, varargin{:})-func(x1, varargin{:}))); x0 = x1; x1 = x2;
    fx2 = func(x2, varargin{:});
    iter = iter + 1;
    
    if errType == 1  % absolute approx error
        ea = abs(x0 - x2); % calc and store abs approx error
    elseif errType == 2 % relative approx error
        ea = abs((x0 - x2)/x0); % calc and store rel approx error
    elseif( errType == 3 ) % true error
        ea = abs(fx2); % calc and store true val
    end
    if ea <= es | iter >= maxit; break,end
end
root = x2;