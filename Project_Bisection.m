function [root,ea,iter]=Project_Bisection(func,xl,xu,errType,es,maxit,varargin)
% $Author: Kieran OGara
%input:
% func = name of function
% xl, xu = lower and upper guesses
% errType = desired error calculation
% es = desired relative error (default = 0.0001%)
% maxit = maximum allowable iterations (default = 50)
%output:
% root = real root
% ea = approximate relative error (%)
% iter = number of iterations


if nargin<3,error('at least 3 input arguments required'),end
test = func(xl,varargin{:})*func(xu,varargin{:});
if test>0,error('no sign change'),end
if nargin<4|isempty(errType), errType = 1;end
if nargin<5|isempty(es), es=0.0001;end
if nargin<6|isempty(maxit), maxit=50;end
iter = 0; xr = xl; ea = 100;

while (1)
  xrold = xr;
  xr = (xl + xu)/2;
  iter = iter + 1;
  if xr ~= 0
      if errType == 1
          ea = abs((xr - xrold));
      elseif errType == 2
          ea = abs((xr - xrold)/xr);
      elseif errType == 3
          ea = abs(func(xr,varargin{:}));
      end
  end
  
  
  
  test = func(xl,varargin{:})*func(xr,varargin{:});
  if test < 0
   xu = xr;
  elseif test > 0
    xl = xr;
  else
  ea = 0;
  end
  if ea < es|iter >= maxit, break,end
end
root = xr;