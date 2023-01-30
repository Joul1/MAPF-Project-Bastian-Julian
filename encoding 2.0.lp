%We need a timelimit to have a finite range of move-atoms
%Timelimit
timelim(15).

%Alternatively one can use #minimize statements to find the lowest timelimit.
%{timelim(1..15)}=1:-.
%#minimize{T:timelim(T)}.


%allowed timesteps
timesteps(1..T):-timelim(T).

%possible movement options, ignoring the wait option
moveOpt(1,0).moveOpt(-1,0).moveOpt(0,1).moveOpt(0,-1).

%Making edges reflexive, by mirroring every edge-atom
edge(U,V):-edge(V,U).



%Every agent begins at their starting position
%Each robot can either wait or has to move
%Move option, on starting position
{move(R,(X,Y),(X+Dx,Y+Dy),1):moveOpt(Dx,Dy)}==1:- start(R,(X,Y)),agent(R), not move(R,(X,Y),(X,Y),1).
%Wait option, on starting position
{move(R,(X,Y),(X,Y),1)}:-                         start(R,(X,Y)),agent(R).


%Every plan has another plan afterwards, until the timelimit is reacht
%Move option
{move(R,(X,Y),(X+Dx,Y+Dy),T+1) : moveOpt(Dx,Dy)}==1 :- move(R,(_,_),(X,Y),T),agent(R),timesteps(T+1), not move(R,(X,Y),(X,Y),T+1).
%Wait option
{move(R,(X,Y),(X,Y),T+1)} :-                           move(R,(_,_),(X,Y),T),agent(R),timesteps(T+1).


%plans can't move agents into walls
%Walls as missing edges
:-move(_,U,V,_),not edge(U,V),U!=V.
%walls as missing vertecies
:-move(_,_,V,_),not vertex(V).

%Every agent has to end at their respective goal at the timelimit
:-not move(R,_,U,T),goal(R,U) ,agent(R),timelim(T).


%vertex conflcit
:-move(R1,(_,_),(X,Y),T),move(R2,(_,_),(X,Y),T),R1!=R2.

%swap conflict
:-move(R1,U,V,T),move(R2,V,U,T),R1!=R2.



%create paths
path(R,U,V):-move(R,U,V,T).

%create plans
plan(R,(X2-X1,Y2-Y1),T):-move(R,(X1,Y1),(X2,Y2),T).


%#show move/4.

#show path/3.
#show plan/3.


