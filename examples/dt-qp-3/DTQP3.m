%--------------------------------------------------------------------------
% DTQP3.m
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary contributor: Daniel R. Herber (danielrherber), University of 
% Illinois at Urbana-Champaign
% Project link: https://github.com/danielrherber/dt-qp-project
%--------------------------------------------------------------------------
function varargout = DTQP3(varargin)

% default parameters
opts.plotflag = 1; % create the plots
opts.saveflag = 0;
opts.displevel = 2;

% if input arguments are provided
% DTQP2(p,p.nt,opts,opts.Quadmethod,opts.Defectmethod,opts.NType)
if nargin >= 1
    p = varargin{1};
end
if nargin >= 2
    p.nt = varargin{2};
end
if nargin >= 3
    opts = varargin{3};
end
if nargin >= 4
    opts.Quadmethod = varargin{4};
end
if nargin >= 5
    opts.Defectmethod = varargin{5};
end
if nargin >= 6
    opts.NType = varargin{6};
end
if nargin > 6
    warning('too many input arguments...');
end

% set current file name and path
[mpath,mname] = fileparts(mfilename('fullpath'));
opts.mpath = mpath;
opts.mname = mname;

%% tunable parameters
p.tf = 10; % time horizon
p.x0 = 1; % initial state
p.b = 1;
p.r = 1;
p.m = 1;
p.a1 = 2;
p.a2 = 1;
p.w1 = 3;
p.w2 = 8;
p.ParameterFlag = 1; % parameter version?

%% setup
p.t0 = 0;

% system dynamics
if p.ParameterFlag
	setup.G = p.b;
else
	setup.B = p.b;
end
setup.d{1,1} = @(t) p.a1*sin(p.w1*t) + p.a2*sin(p.w2*t);

% Lagrange term
if p.ParameterFlag
    L(1).left = 3; % parameters 
    L(1).right = 3; % parameters
    L(1).matrix = p.r;
else
    L(1).left = 1; % control variables
    L(1).right = 1; % control variables
    L(1).matrix = p.r;
end

% Mayer term
M(1).left = 5; % final states
M(1).right = 5; % final states
M(1).matrix = p.m;

% initial conditions
LB(1).right = 4; % initial states
LB(1).matrix = p.x0;
UB(1).right = 4; % initial states
UB(1).matrix = p.x0;

% combine
setup.L = L; setup.M = M; setup.LB = LB; setup.UB = UB; setup.p = p;

%% solve
[T,U,Y,P,F,p,opts] = DTQP_solve(setup,opts);

%% output
[O,sol] = DTQP3_output(T,U,Y,P,F,p,opts);
if nargout == 1
	varargout{1} = O;
end

%% plot
DTQP3_plot(T,U,Y,P,F,p,opts,sol)