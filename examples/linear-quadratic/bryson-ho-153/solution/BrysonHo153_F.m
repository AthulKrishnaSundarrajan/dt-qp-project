function I = BrysonHo153_F(c,t0,tf,x0)
%BRYSONHO153_F
%    I = BRYSONHO153_F(C,T0,TF,X0)

%    This function was generated by the Symbolic Math Toolbox version 8.0.
%    19-Dec-2017 11:31:19

t2 = x0.^2;
t3 = t0-tf;
I = t2.*t3.*1.0./(-t0+tf+1.0./c).^2.*(-1.0./2.0)+c.*t2.*1.0./(c.*t3-1.0).^2.*(1.0./2.0);
