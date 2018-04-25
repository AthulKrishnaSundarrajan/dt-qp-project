%--------------------------------------------------------------------------
% BrysonHo156.m
% p. 156 of A. E. Bryson Jr. and Y.-C. Ho, Applied Optimal Control.
% Taylor & Francis, 1975, isbn: 9780891162285
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary contributor: Daniel R. Herber (danielrherber), University of 
% Illinois at Urbana-Champaign
% Project link: https://github.com/danielrherber/dt-qp-project
%--------------------------------------------------------------------------
function varargout = BrysonHo156(varargin)

% set p and opts (see BrysonHo156_opts.m)
% input arguments can be provided in the format 'BrysonHo156(p,opts)'
[p,opts] = DTQP_standardizedinputs('BrysonHo156_opts',varargin);

%% tunable parameters
p.t0 = 0; p.tf = 10; % time horizon
p.x0 = 10; p.v0 = 1; p.c = 1;
p.omega = 1;

%% setup
% system dynamics
A = [0,1;-p.omega^2,0]; 
B = [0;1];  

% Lagrange term
L(1).left = 1; % control variables
L(1).right = 1; % control variables
L(1).matrix = 1/2; % 1/2*u^2

% Mayer term
M(1).left = 5; % final state variables
M(1).right = 5; % final state variables
M(1).matrix = [p.c/2,0;0,0];

% initial conditions
LB(1).right = 4; % initial states
LB(1).matrix = [p.x0;p.v0];
UB(1).right = 4; % initial states
UB(1).matrix = [p.x0;p.v0];

% combine
setup.A = A; setup.B = B; setup.L = L; setup.M = M;
setup.LB = LB; setup.UB = UB; setup.p = p;

%% solve
[T,U,Y,P,F,p,opts] = DTQP_solve(setup,opts);

%% output
[O,sol] = BrysonHo156_output(T,U,Y,P,F,p,opts);
if nargout == 1
	varargout{1} = O;
end

%% plot
BrysonHo156_plot(T,U,Y,P,F,p,opts,sol)