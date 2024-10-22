function [root,ea,iter]=Project_False_Position (func,xl,xu,errType,es,maxit,varargin)
% $Author: Kieran OGara
%input:
% func = function name
% xl = lower bound
% xu = upper bound
% errType = integer to determine which error type is used
% es = tolerance threshold
% maxit = maximum allowable iterations
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
iter = 0; xr = xu; xi = 0; ea = 100;
xi = xu - (func(xu,varargin{:}) * ((xl - xu)/(func(xl,varargin{:}) - func(xu,varargin{:}))));

while(1)
    iter = iter + 1;
    
    xi = xu - (func(xu,varargin{:}) * ((xl - xu)/(func(xl,varargin{:}) - func(xu,varargin{:}))));
    test = func(xl,varargin{:})*func(xi,varargin{:});
    if test > 0
        xu = xi;
    else
        xl = xi;
    end
    
    
    if errType == 3
        %True error
        ea = abs(func(xi,varargin{:}));
        if ea <= es
            root = xi;
            break
        else
            continue
        end
    elseif errType == 1
        %absolute approximate error
        ea = abs(xr - xi);
        if ea <= es
            root = xi;
            break
        else
            xr = xi;
            continue
        end
    elseif errType == 2
        %relative approximate error
        ea = abs((xr - xi) / (xr));
        if ea <= es
            root = xi;
            break
        else
            xr = xi;
            continue
        end
    end
    
end
end
    
        
        
    