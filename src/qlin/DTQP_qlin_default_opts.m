%--------------------------------------------------------------------------
% DTQP_qlin_default_opts.m
% Default options for the quasilinearization methods
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Contributor: Athul K. Sundarrajan (AthulKrishnaSundarrajan on GitHub)
% Primary contributor: Daniel R. Herber (danielrherber on GitHub)
% Link: https://github.com/danielrherber/dt-qp-project
%--------------------------------------------------------------------------
function opts = DTQP_qlin_default_opts(opts)

% initialize quasilinearization-specific options structure
if ~isfield(opts,'qlin')
    opts.qlin = [];
end

% relative function tolerance
if ~isfield(opts.qlin,'tolerance')
    opts.qlin.tolerance = 1e-6;
end

% maximum number of iterations
if ~isfield(opts.qlin,'imax')
    opts.qlin.imax = 500;
end

% constant scaling based on previous solution
if ~isfield(opts.qlin,'deltascaleflag')
    % opts.qlin.deltascaleflag = true; % enabled
    opts.qlin.deltascaleflag = false; % disabled
end

% sequential quadratic programming flag
if ~isfield(opts.qlin,'sqpflag')
    % opts.qlin.sqpflag = true; % enabled
    opts.qlin.sqpflag = false; % disabled
end
if opts.qlin.sqpflag
	opts.qlin.deltascaleflag = true; % required to be enabled
end

end