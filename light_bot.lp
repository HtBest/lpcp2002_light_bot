mact(fw;left;right;turn;nop;jump;subr).
sact(fw;left;right;turn;nop;jump).
mstep(1..X):-main(X).
sstep(1..X):-subr(X).
leftof(w,a).
leftof(a,s).
leftof(s,d).
leftof(d,w).
rightof(w,d).
rightof(d,s).
rightof(s,a).
rightof(a,w).


turned(0,X,Y,off):-bulb(X,Y).
x(0,X):-initrow(X).
y(0,Y):-initcol(Y).
dir(0,w):-initdir(0).
dir(0,d):-initdir(1).
dir(0,s):-initdir(2).
dir(0,a):-initdir(3).

1{proc(main,STEP,ACT):mact(ACT)}1:- mstep(STEP).
1{proc(subr,STEP,ACT):sact(ACT)}1:- sstep(STEP).


turned(STEP,0,X,Y,S):-turned(STEP-1,X,Y,S),proc(main,STEP,subr).
x(STEP,0,S):-x(STEP-1,S),proc(main,STEP,subr).
y(STEP,0,S):-y(STEP-1,S),proc(main,STEP,subr).
dir(STEP,0,S):-dir(STEP-1,S),proc(main,STEP,subr).

turned(STEP,X,Y,S):-proc(main,STEP,subr),turned(STEP,SSTEP,X,Y,S),subr(SSTEP).
x(STEP,S):-proc(main,STEP,subr),x(STEP,SSTEP,S),subr(SSTEP).
y(STEP,S):-proc(main,STEP,subr),y(STEP,SSTEP,S),subr(SSTEP).
dir(STEP,S):-proc(main,STEP,subr),dir(STEP,SSTEP,S),subr(SSTEP).



turned(STEP,SSTEP,X,Y,on):- proc(subr,SSTEP,turn),x(STEP,SSTEP,X),y(STEP,SSTEP,Y), turned(STEP,SSTEP-1,X,Y,off).
turned(STEP,SSTEP,X,Y,off):- proc(subr,SSTEP,turn),x(STEP,SSTEP,X),y(STEP,SSTEP,Y), turned(STEP,SSTEP-1,X,Y,on).
turned(STEP,SSTEP,X,Y,on):- not turned(STEP,SSTEP,X,Y,off), turned(STEP,SSTEP-1,X,Y,on),sstep(SSTEP).
turned(STEP,SSTEP,X,Y,off):- not turned(STEP,SSTEP,X,Y,on), turned(STEP,SSTEP-1,X,Y,off),sstep(SSTEP).

turned(STEP,X,Y,on):- proc(main,STEP,turn),x(STEP,X),y(STEP,Y), turned(STEP-1,X,Y,off).
turned(STEP,X,Y,off):- proc(main,STEP,turn),x(STEP,X),y(STEP,Y), turned(STEP-1,X,Y,on).
turned(STEP,X,Y,on):- not turned(STEP,X,Y,off), turned(STEP-1,X,Y,on),mstep(STEP).
turned(STEP,X,Y,off):- not turned(STEP,X,Y,on), turned(STEP-1,X,Y,off),mstep(STEP).



x(STEP,SSTEP,X-1):- proc(subr,SSTEP,fw),x(STEP,SSTEP-1,X),y(STEP,SSTEP-1,Y),dir(STEP,SSTEP-1,w),X>0,height(X,Y,H),height(X-1,Y,H).
x(STEP,SSTEP,X+1):- proc(subr,SSTEP,fw),x(STEP,SSTEP-1,X),y(STEP,SSTEP-1,Y),dir(STEP,SSTEP-1,s),X<XMAX,row(XMAX+1),height(X,Y,H),height(X+1,Y,H).
x(STEP,SSTEP,X-1):- proc(subr,SSTEP,jump),x(STEP,SSTEP-1,X),y(STEP,SSTEP-1,Y),dir(STEP,SSTEP-1,w),X>0,height(X,Y,H1),height(X-1,Y,H2),|H1-H2|==1,H2>=0.
x(STEP,SSTEP,X+1):- proc(subr,SSTEP,jump),x(STEP,SSTEP-1,X),y(STEP,SSTEP-1,Y),dir(STEP,SSTEP-1,s),X<XMAX,row(XMAX+1),height(X,Y,H1),height(X+1,Y,H2),|H1-H2|==1,H2>=0.
x(STEP,SSTEP,X):-not x(STEP,SSTEP,X+1),not x(STEP,SSTEP,X-1),x(STEP,SSTEP-1,X),sstep(SSTEP).

x(STEP,X-1):- proc(main,STEP,fw),x(STEP-1,X),y(STEP-1,Y),dir(STEP-1,w),X>0,height(X,Y,H),height(X-1,Y,H).
x(STEP,X+1):- proc(main,STEP,fw),x(STEP-1,X),y(STEP-1,Y),dir(STEP-1,s),X<XMAX,row(XMAX+1),height(X,Y,H),height(X+1,Y,H).
x(STEP,X-1):- proc(main,STEP,jump),x(STEP-1,X),y(STEP-1,Y),dir(STEP-1,w),X>0,height(X,Y,H1),height(X-1,Y,H2),|H1-H2|==1,H2>=0.
x(STEP,X+1):- proc(main,STEP,jump),x(STEP-1,X),y(STEP-1,Y),dir(STEP-1,s),X<XMAX,row(XMAX+1),height(X,Y,H1),height(X+1,Y,H2),|H1-H2|==1,H2>=0.
x(STEP,X):-#count{X1:x(STEP,X1),X1!=X}==0,x(STEP-1,X),mstep(STEP).





y(STEP,SSTEP,Y-1):- proc(subr,SSTEP,fw),x(STEP,SSTEP-1,X),y(STEP,SSTEP-1,Y),dir(STEP,SSTEP-1,a),Y>0,height(X,Y,H),height(X,Y-1,H).
y(STEP,SSTEP,Y+1):- proc(subr,SSTEP,fw),x(STEP,SSTEP-1,X),y(STEP,SSTEP-1,Y),dir(STEP,SSTEP-1,d),Y<YMAX,col(YMAX+1),height(X,Y,H),height(X,Y+1,H).
y(STEP,SSTEP,Y-1):- proc(subr,SSTEP,jump),x(STEP,SSTEP-1,X),y(STEP,SSTEP-1,Y),dir(STEP,SSTEP-1,a),Y>0,height(X,Y,H1),height(X,Y-1,H2),|H1-H2|==1,H2>=0.
y(STEP,SSTEP,Y+1):- proc(subr,SSTEP,jump),x(STEP,SSTEP-1,X),y(STEP,SSTEP-1,Y),dir(STEP,SSTEP-1,d),Y<YMAX,col(YMAX+1),height(X,Y,H1),height(X,Y+1,H2),|H1-H2|==1,H2>=0.
y(STEP,SSTEP,Y):-not y(STEP,SSTEP,Y+1),not y(STEP,SSTEP,Y-1),y(STEP,SSTEP-1,Y),sstep(SSTEP).

y(STEP,Y-1):- proc(main,STEP,fw),x(STEP-1,X),y(STEP-1,Y),dir(STEP-1,a),Y>0,height(X,Y,H),height(X,Y-1,H).
y(STEP,Y+1):- proc(main,STEP,fw),x(STEP-1,X),y(STEP-1,Y),dir(STEP-1,d),Y<YMAX,col(YMAX+1),height(X,Y,H),height(X,Y+1,H).
y(STEP,Y-1):- proc(main,STEP,jump),x(STEP-1,X),y(STEP-1,Y),dir(STEP-1,a),Y>0,height(X,Y,H1),height(X,Y-1,H2),|H1-H2|==1,H2>=0.
y(STEP,Y+1):- proc(main,STEP,jump),x(STEP-1,X),y(STEP-1,Y),dir(STEP-1,d),Y<YMAX,col(YMAX+1),height(X,Y,H1),height(X,Y+1,H2),|H1-H2|==1,H2>=0.
y(STEP,Y):-#count{Y1:y(STEP,Y1),Y1!=Y}==0,y(STEP-1,Y),mstep(STEP).





dir(STEP,SSTEP,D2):- proc(subr,SSTEP,left),dir(STEP,SSTEP-1,D1),leftof(D1,D2).
dir(STEP,SSTEP,D2):- proc(subr,SSTEP,right),dir(STEP,SSTEP-1,D1),rightof(D1,D2).
dir(STEP,SSTEP,D):- proc(subr,SSTEP,ACT),dir(STEP,SSTEP-1,D),ACT!=left,ACT!=right.

dir(STEP,D2):- proc(main,STEP,left),dir(STEP-1,D1),leftof(D1,D2).
dir(STEP,D2):- proc(main,STEP,right),dir(STEP-1,D1),rightof(D1,D2).
dir(STEP,D):- proc(main,STEP,ACT),dir(STEP-1,D),ACT!=left,ACT!=right,ACT!=subr.

bad:-turned(STEP,_,_,off),main(STEP).
:-bad.

#show proc/3.