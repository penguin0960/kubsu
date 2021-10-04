max(X,Y,X):-X>Y,!.
max(_,Y,Y):-!.

max1(X,Y,Z,U):-max(X,Y,K),max(K,Z,U).

fact(1,1):-!.
fact(N,X):-N1 is N-1, fact(N1,X1), X is X1*N.

fact1(N,X):-fact1(N,1,X,1),!.
fact1(N,N,X,X):-!.
fact1(N,I,X,F):-I1 is I+1, F1 is F*I1, fact1(N,I1,X,F1).

fib(1,1):-!.
fib(2,1):-!.
fib(N,X):-N1 is N-1, N2 is N-2, fib(N1,X1), fib(N2,X2), X is X1+X2.

fib1(N,X):-fib1(1,1,2,N,X),!.
fib1(_,X,N,N,X):-!.
fib1(A,B,I,N,X):-C is A+B, I1 is I+1, fib1(B,C,I1,N,X).

pr(X):-X<2,fail.
pr(2):-!.
pr(X):-pr(X,2).
pr(X,X):-!.
pr(X,I):-I1 is I+1, Ost is X mod I, Ost>0, pr(X,I1).

ch(X):-Ost is X mod 2, Ost = 0.
nch(X):-Ost is X mod 2, Ost > 0.

summdigit(0,0):-!.
summdigit(X,S):-X1 is X div 10, summdigit(X1,S1), S is S1+X mod 10.

maxdel(X,M):-maxdel(X,M,2,1),!.
maxdel(X,X,X,1):-!.
maxdel(X,L,X,L):-!.
maxdel(X,M,I,L):-I1 is I+1,
    Ost is X mod I,
    Ost = 0,
    pr(I),
    I>L,
    maxdel(X,M,I1,I).
maxdel(X,M,I,L):-I1 is I+1, maxdel(X,M,I1,L).

nod(A,0,A):-!.
nod(A,B,B):-Ost is A mod B, Ost = 0,!.
nod(A,B,N):-B1 is A mod B,
    A1 is B,
    nod(A1,B1,N).

eiler(1,1):-!.
eiler(N,K):-eiler(N,1,K,0),!.
eiler(N,N,K,K):-!.
eiler(N,I,K,C):-I1 is I+1,
    nod(N,I,Nod),
    Nod = 1,
    C1 is C+1,
    eiler(N,I1,K,C1).
eiler(N,I,K,C):-I1 is I+1, eiler(N,I1,K,C).
