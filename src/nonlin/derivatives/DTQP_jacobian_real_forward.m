%--------------------------------------------------------------------------
% DTQP_jacobian_real_forward.m
% Compute Hessian of the function using forward real-step differentiation
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Contributor: Athul K. Sundarrajan (AthulKrishnaSundarrajan on GitHub)
% Primary contributor: Daniel R. Herber (danielrherber on GitHub)
% Link: https://github.com/danielrherber/dt-qp-project
%--------------------------------------------------------------------------
function Df = DTQP_jacobian_real_forward(f,X,T,param)

% number of functions
nf = length(f);

% number of optimization variables
nx = size(X,2);

% number of time points
nt = length(T);

% initialize
Df = zeros(nt,nf,nx);

% magnitude of the optimization variables
Xa = 1 + abs(X);

% differentiation step size
h = sqrt(eps);

% create expanded step size matrix
H = zeros(nx*nt,nx);
for jx = 1:nx
    H(((jx-1)*nt+1):(jx*nt),jx) = h*Xa(:,jx);
end

% step size vector
Ha = h*Xa(:);

% reference point matrix
X0 = repmat(X,[nx 1]);

% compute forward step matrix
Xf = X0 + H;

% replicate time vector
T = repmat(T,[nx 1]);

% replicate parameter vector if it is time-dependent
if size(param,1) == nt
    PARAM = repmat(param,[nx 1]);
else
    PARAM = param;
end

% go through each function
for kx = 1:nf

    % extract current function
    fun = f{kx};

    % function call at original point
    u0 = fun(T,param,X);
    U0 = repmat(u0,nx,1);

    % function call with forward increment
    Uf = fun(T,PARAM,Xf);

    % forward-step differentiation
    Dft = (Uf-U0)./Ha;

    % reshape and place in Df
    Df(:,kx,:) = reshape(Dft,nt,1,nx);

end

end