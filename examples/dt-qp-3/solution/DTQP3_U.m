function u = DTQP3_U(a1,a2,b,m,r,tf,w1,w2,x0)
%DTQP3_U
%    U = DTQP3_U(A1,A2,B,M,R,TF,W1,W2,X0)

%    This function was generated by the Symbolic Math Toolbox version 8.0.
%    15-Jan-2018 23:40:16

t2 = sin(tf.*w1.*(1.0./2.0));
t3 = sin(tf.*w2.*(1.0./2.0));
u = -(b.*m.*(a1.*t2.^2.*w2.*2.0+a2.*t3.^2.*w1.*2.0+w1.*w2.*x0))./(w1.*w2.*(r+b.^2.*m.*tf));