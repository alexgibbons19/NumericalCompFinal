function [root,ea,iter]=Project_Newtraph(func,dfunc,xr,errType,es,maxit,varargin)
% $Author: Alex Gibbons
% newtraph: Newton-Raphson root location zeroes
% [root,ea,iter]=newtraph(func,dfunc,xr,es,maxit,p1,p2,...):
%   uses Newton-Raphson method to find the root of func
% input:
%   func = name of function
%   dfunc = name of derivative of function
%   xr = initial guess
%   errType = which of the 3 stopping criterion user would like to use
%   es = desired relative error (default = 0.0001%)
%   maxit = maximum allowable iterations (default = 50)
%   p1,p2,... = additional parameters used by function
% output:
%   root = real root
%   ea = error(%)
%   iter = number of iterations
if nargin<3,error('at least 3 input arguments required'),end
if nargin<4|isempty(errType), errType = 1;end
if nargin<5|isempty(es),es=0.0001;end
if nargin<6|isempty(maxit),maxit=50;end
iter = 0;
while (1)
    xrold = xr;
    xr = xr - func(xr)/dfunc(xr);
    iter = iter + 1;
   if xr ~= 0
       if errType == 1 % absolute approx error
           ea = abs(xr - xrold);
       elseif errType == 2 % absolute relative error
           ea = abs((xr - xrold) / xr);
       elseif errType == 3 % true error
           ea = abs(func(xr,varargin{:}));
       end
   end
   if ea <= es | iter >= maxit, break, end 
end
root = xr;