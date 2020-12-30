function U = HagerHouRao1_U(t)
%HAGERHOURAO1_U
%    U = HAGERHOURAO1_U(T)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    27-Dec-2020 10:33:00

t2 = t-1.0;
U = [exp(t.*(-3.0./2.0)).*(exp(t.*3.0).*2.0-4.017107384637534e+1).*4.527850074362907e-2,cosh(t2).*(tanh(t2)-1.0./2.0).*6.480542736638853e-1];