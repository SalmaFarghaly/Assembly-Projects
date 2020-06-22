.model large
.stack 64  
;;============================================DATA SEGMENT===================================
.data
;;data for shapes of first player
XSHR1      dw 213D
XSHL1      DW 213D
YSH1       dw 420D 
XSHR2      dw 288D
XSHL2      DW 288D
YSH2       dw 420D
XSHR3      dw 363D
XSHL3      DW 363D
YSH3       dw 420D 
XSHR       DW 00
YSH        DW 00
XSHL       DW 00
Xcenter    dw 00
Shapes1    db 03
ShapeOut1  db 00
;;data for shapes of second player
YUP1       dw 357D
YDOwn1     dw 357D
XSHH1      dw 150D
YUP2       dw 282D
YDOWN2     dw 282D
XSHH2      dw 150D
YUP3       dw 207D
YDOWN3     dw 207D
XSHH3      dw 150D
YUP        dw 00D
YDown      dw 00D
XSHH       dw 00D
Ycenter    dw 00D 
color      db 00D
Shapes2    db 03
ShapeOut2  db 00 
;;FOR marking Grid
XBegin     dw 100D
XEnd       dw 400D
YBegin     dw 470D
YEnd       dw 170D
XClicked   dw 00
YClicked   dw 00 
temp       dw 00 
;;GETTING NAMES DATA
MessageName      db    'Please Enter Your names','$'
name1            db    '?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','$'
name2            db    '?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','$' 
MessageRound     db    'Please Enter Number Of Rounds (Maximum:5>','$'
Round            db    'Round','$'
MesEndGame       db    'End Game','$'
MesWinner        db    'The Winner is ','$' 
MesMoves         db    'Moves','$'
;;SCore DATA
score1digits     db 00 
score1tenth      db 00
score1Hundreds   db 00
score2digits     db 00
score2tenth      db 00
score2Hundreds   db 00
Rounds           db 00
CurrentRound     db 01D
Moves1digits     db 00 
Moves1tenth      db 00
Moves1Hundreds   db 00
Moves2digits     db 00 
Moves2tenth      db 00
Moves2Hundreds   db 00 
winner           db 00 
digits           db 00
tenth            db 00
hundreds         db 00
score1           db 0D
score2           db 0D
Moves1           db 0
Moves2           db 0
Moves            db 0
Score            db 0
;;FOR MOVEMENT
;;ClickedKEy db 00 ;;FOR SCANCODE OF PRESSED KEY OF FIRST PLAYER
;;========================================CODE SEGMENT======================================== 
.code 
main proc far 
mov ax,@data
mov ds,ax 
mov es, ax

;;Clear Screen
mov ax,0600h       
mov bh,07         
mov cx,0       
mov dx,184FH      
int 10h
   
;Display Message        
mov cx, 23D  ;cx now has the 2nd byte value in the string, ie the length
mov ah, 13h  ; int 13h of 10h, print a string
mov al, 1H   ; write mode: colour on bl    
mov bh, 0    ; video page zero
mov bl, 0EH  ; colour attribute
mov dx, 0B10h
mov bp, offset MessageName ; es:bp needs to point at string..this points to string but includes its max and length at the start
int 10h
;Getting names of players    
mov ah,2
mov dx,0B30h
int 10H
mov ah,0AH
mov dx,offset name1
int 21H
mov ah,2
mov dx,0C30h
int 10H
int 21h
mov ah,0AH
mov dx,offset name2
int 21h
;;Getting Number of Rounds
mov cx, 41D  ;cx now has the 2nd byte value in the string, ie the length
mov ah, 13h  ; int 13h of 10h, print a string
mov al, 1H   ; write mode: colour on bl    
mov bh, 0    ; video page zero
mov bl, 0EH  ; colour attribute
mov dx, 0D10h
mov bp, offset MessageRound ; es:bp needs to point at string..this points to string but includes its max and length at the start
int 10h
mov ah,2
mov dx,0D10h
add dl,45D
int 10H
mov ah,07
int 21h
sub al,48D
mov Rounds,al
;;Video Mode

NextRound:
mov al,Rounds
cmp CurrentRound,al
js  Game
jz  Game

;;Clear Screen and display who is the winner 
mov ah,0
mov al,13h 
int 10h

;;Display'End Game' and 'The winner is'

mov cx, 8D  
mov ah, 13h  
mov al, 1H       
mov bh, 0    
mov bl, 0BH  
mov dx, 0B10h
mov bp, offset MesEndGame 
int 10h

mov cx, 14D  
mov ah, 13h  
mov al, 1H       
mov bh, 0    
mov bl, 0BH  
mov dx, 0C0Ah
mov bp, offset MesWinner 
int 10h

mov cl,Score1
cmp cl,Score2
js  win2
jns win1
;mov al,score1Hundreds
;cmp score2Hundreds,al
;jz  Comparetenth
;jns win2
;js  win1
;
;Comparetenth:
;mov al,score1tenth
;cmp score2tenth,al
;jz  CompareDigit
;jns win2
;js  win1
;        
;CompareDigit: 
;mov al,score1digits
;cmp score2digits,al
;jns win2
;js  win1

;;the first player is the winner
win1:

mov dx,0C0AH
add dx,14D
mov al,1h
mov ah,13h 
mov bp,offset name1[2]
mov bh,0 
mov bl,09h
mov cl,name1[1]
mov ch,0h 
int 10h
jmp Endgame

;;the second player is the winner
win2:
mov dx,0C0AH
add dx,14D
mov al,1h
mov ah,13h 
mov bp,offset name2[2]
mov bh,0 
mov bl,0Ch
mov cl,name2[1]
mov ch,0h 
int 10h


Endgame:
mov ah,4CH
int 21H
;;hlt system here 
jmp Endgame      



Game:  
mov ah,0
mov al,13h 
int 10h
mov cx, 5D  ;cx now has the 2nd byte value in the string, ie the length
mov ah, 13h  ; int 13h of 10h, print a string
mov al, 1H   ; write mode: colour on bl    
mov bh, 0    ; video page zero
mov bl, 06H  ; colour attribute
mov dx, 0B10h
mov bp, offset Round ; es:bp needs to point at string..this points to string but includes its max and length at the start
int 10h

mov ah,2
mov dx,0B17H
int 10H

mov ah,2
mov dl,CurrentRound
add dl,48D
int 21H 

call beep

mov  ah,0
int  16h

mov ah,0
mov al,12h 
int 10h
;;Reseting Some Values before Round
mov ShapeOut1,0
mov ShapeOut2,0
mov winner,0
mov Moves,0
mov Moves1,0
mov Moves2,0
mov Score,200D

mov Moves1digits,0
mov Moves1tenth,0
mov Moves1Hundreds,0

mov Moves2digits,0
mov Moves2tenth,0
mov Moves2Hundreds,0
;;;;;;;;;;===============DRAWING grid 
call WriteScore
call DrawVer
call DrawHor
;drawing filled white Square
mov dx,469D
backLine:
mov cx,100D
mov al,0FH
mov ah,0ch
backSq:
      mov bx,0
      int 10h
      inc cx
      cmp cx,175D 
      jnz backSq
      dec dx
      cmp dx,395D  
      jnz backLine
;;;======================Fisrt player Shapes
;first shape
mov  dx,YSH1
mov  cx,XSHR1;; X
mov  YSH,dx
mov  XSHR,cx
mov  XSHL,cx 
mov  Xcenter,cx
mov  al,09H
call drawShape
;Second shape
mov dx,YSH2
mov cx,XSHR2
mov YSH,dx
mov XSHR,cx
mov XSHL,cx
mov Xcenter,cx 
mov  al,09H
call drawShape
;;Third Shape
mov dx,YSH3
mov cx,XSHR3
mov YSH,dx
mov XSHR,cx
mov XSHL,cx
mov Xcenter,cx  
mov  al,09H
call drawshape

;======================Second player shapes
;;;first shape
mov  dx,YUP1
mov  cx,XSHH1
mov  YUP,dx
mov  Ydown,dx
mov  XSHH,cx
mov  Ycenter,dx  
mov  al,0CH
call drawshape2
;;;Second Shape
mov  dx,YUP2
mov  cx,XSHH2
mov  YUP,dx
mov  Ydown,dx
mov  XSHH,cx
mov  Ycenter,dx
mov  al,0CH
call drawshape2

;;;Third Shape 
mov  dx,YUP3
mov  cx,XSHH3
mov  YUP,dx
mov  Ydown,dx
mov  XSHH,cx
mov  Ycenter,dx
mov  al,0CH
call drawshape2

;;;=====================The GAME ^^

;;;;;;;=========First Player Roll


salma:
;;;===Checks if there is a winner
cmp  Winner,1
jz   Winner1
cmp  winner,2
jz   winner2
jmp  NotWinner


;;=========Player1 wins the round
winner1:

mov cl,Score1digits
mov digits,cl
mov cl,Score1tenth
mov tenth,cl
mov cl,Score1hundreds
mov hundreds,cl
mov cl,Moves1
mov Moves,cl
mov cl,Score1
mov Score,cl
call IncrementScore
mov cl,digits
mov Score1digits,cl
mov cl,tenth
mov Score1tenth,cl
mov cl,hundreds
mov Score1hundreds,cl
mov cl,Score
mov Score1,cl

call WriteScore
mov ah,0
int 16H

inc CurrentRound
jmp NextRound

 
;==========Player2 wins the round
winner2:
mov cl,Score2digits
mov digits,cl
mov cl,Score2tenth
mov tenth,cl
mov cl,Score2hundreds
mov hundreds,cl
mov cl,Moves2
mov Moves,cl
mov cl,Score2
mov Score,cl
call IncrementScore
mov cl,digits
mov Score2digits,cl
mov cl,tenth
mov Score2tenth,cl
mov cl,hundreds
mov Score2hundreds,cl
mov cl,Score
mov Score2,cl

call WriteScore
mov ah,0
int 16H


inc CurrentRound
jmp NextRound

;==========There is no winner Yet for the Round
NotWinner: 
mov  bx,0   
mov  XClicked,0
mov  YClicked,0
mov  temp,0

Mouse:
mov ax,1
int 33H
GetClick: 
mov  ah,1
int  16H
jz   ShowMouse
mov  ah,0
int  16H
ShowMouse:
mov  ax,3 
int  33h
cmp  bx,1
jz   Clicked
cmp  bx,2
jnz  GetClick  ;;;don't forget to check for the limits of X and Y   
Clicked: 
mov  ax, 2 
int  33h

;Checking for the limits of grid
;XBegin     dw 100D
;XEnd       dw 400D
;YBegin     dw 470D
;YEnd       dw 170D

;cmp cx,Xbegin
;js  Mouse
;cmp cx,XEnd
;jns Mouse
;mov dx,Ybegin
;jns Mouse
;mov dx,YEnd
;js  Mouse
;
mov ax,cx
sub ax,100D  
mov SI,1
ContSubtractX:
cmp ax,75D
jns INCRESQX

mov bx,dx              
sub bx,170D
mov BP,1              
ContSubtractY:
cmp bx,75D
jns INCRESQY

jmp drawClickedSquare


INCRESQY:
inc bp
sub bx,75D
jmp ContSubtractY:           
           
           
INCRESQX:
inc si
sub ax,75D
jmp ContSubtractX



drawClickedSquare:
dec SI
jz  FirstSqX 
mov cx,100D
GETXpos:
add cx,75D
dec SI
jnz GetXpos 
jz  GetYPos

FirstSqX:
mov cx,100D

GetYPos:
dec BP
jz  FirstSqY
mov dx,170D
YY:
add dx,75D
dec BP
jnz YY
jz  PosReady


FirstSqY:
mov dx,170D


PosReady:
mov XClicked,cx
mov YClicked,dx 

mov ah,0DH
MOV BH,0
add cx,40
add dx,40
int 10H
cmp al,0
jz  salma 

sub cx,40
sub dx,40
;;===============highlighting the Selected Square
mov SI,75D
mov al,0AH
mov ah,0ch
FirstHorline:
       mov bx,0
       int 10h
       inc cx
       dec SI
       jnz FirstHorLine

mov cx,XClicked
mov dx,YClicked
add dx,75D        
mov SI,75D
mov al,0AH
mov ah,0ch
SecondHorline:
       mov bx,0
       int 10h
       inc cx
       dec SI
       jnz SecondHorLine
       
mov cx,XClicked
mov dx,YClicked       
mov SI,75D
mov al,0AH
mov ah,0ch
FirstVerline:
       mov bx,0
       int 10h
       inc dx
       dec SI
       jnz FirstVerLine
       
mov cx,XClicked
mov dx,YClicked
add cx,75D        
mov SI,75D
mov al,0AH
mov ah,0ch
SecondVerline:
       mov bx,0
       int 10h
       inc dx
       dec SI
       jnz SecondVerLine 
       
       
       
;;=====================Moving Selected Shape

mov  cx,XClicked
mov  dx,YClicked 

mov  ah,0DH
MOV  BH,0
add  cx,40
add  dx,40
int  10H
cmp  al,09
jz   MoveFirstShape
cmp  al,0CH
jz   MoveSecondShape
jmp  salma

;;=====================First Shape Move
MoveFirstShape:
mov  ah,1h                 ; check if key pressed 
int  16h  
jz   MoveFirstShape
call WhitenSquare
mov  ah,0
int  16H
cmp  ah,1D
je   salma
cmp  ah,72D
je   MoveUp
cmp  ah,80D
je   MoveDown
cmp  ah,75D
je   MoveLeft
cmp  ah,77D
je   MoveRight
cmp  ah,1D
je   salma 
mov  ax,0604h
int  16h
jmp  salma 



MoveUp:
mov  cx,XClicked
add  cx,38D
mov  dx,YClicked
sub  dx,50D 
jmp  continue

MoveDown:
mov  cx,XClicked
add  cx,38D
mov  dx,YClicked
add  dx,100D 
jmp  Continue


MoveLeft: 
mov  cx,XClicked
sub  cx,37D
mov  dx,YClicked
add  dx,25D 
jmp  Continue



MoveRight:
mov  cx,XClicked
add  cx,113D
mov  dx,YClicked
add  dx,25D 
jmp  Continue

continue: 
mov  XSHL,cx
mov  XSHR,cx
mov  Xcenter,cx 
mov  YSH,dx
;;Get Pixel Color 
mov  ah,0DH
MOV  BH,0 
add  cx,12D
int  10H
cmp  al,0 
jnz  salma
cmp  XSHL,100D  ;;to not get out from Grid from left side
js   salma  
cmp  YSH,470D   ;;to not get out from Grid from down
jns  salma 
mov  bx,XEnd
cmp  XSHL,bx    ;;to not get out from grid from Right
jns  salma
mov  cx,YEnd
cmp  YSH,cx
jns  NoOut1
inc  ShapeOut1
mov  bl,ShapeOut1
cmp  bl,shapes1
jnz  NoOut1
mov  winner,1

NoOut1: 
call RemoveShape
;;don't forget to make harder level here
mov  al,09D  
call DrawShape

mov  cl,Moves1digits
mov  digits,cl
mov  cl,Moves1tenth
mov  tenth,cl
mov  cl,Moves1Hundreds
mov  hundreds,cl
mov  cl,Score1
mov  Score,cl
call IncrementMoves
mov  cl,digits
mov  Moves1digits,cl
mov  cl,tenth
mov  Moves1tenth,cl
mov  cl,hundreds
mov  Moves1Hundreds,cl
mov  cl,Score
mov  Score1,cl
call WriteScore
inc  Moves1 
 
jmp  salma
;;;==============================SECOND PLAYER'S TURN

MoveSecondShape: 
mov  ah,1h                 ; check if key pressed 
int  16h  
jz   MoveSecondShape
call WhitenSquare 
mov  ah,0
int  16H
cmp  ah,72D
je   MoveUp2
cmp  ah,80D
je   MoveDown2
cmp  ah,75D
je   MoveLeft2
cmp  ah,77D
je   MoveRight2
cmp  ah,1D
je   salma 
mov  ax,0604h
int  16h
jmp salma 


MoveUp2:
mov cx,XClicked
mov dx,YClicked
sub dx,38D
add cx,50D
jmp Continue2

MoveDown2:
mov cx,XClicked
mov dx,YClicked
add dx,112D
add cx,50D 
jmp Continue2


MoveRight2:
mov cx,XClicked
mov dx,YClicked
add dx,37D
add cx,125D
jmp Continue2


MoveLeft2:
mov cx,XClicked
mov dx,YClicked
sub cx,25D
add dx,37D
jmp continue2


Continue2:
mov YUP,dx
mov Ydown,dx
mov YCenter,dx
mov XSHH,cx 


mov  ah,0DH
MOV  BH,0 
sub  cx,5D
int  10H
cmp  al,0 
jnz  salma
cmp  XSHH,100
js   salma
cmp  YUP,470
jns  salma
mov  bx,YEnd
cmp  YUP,bx
js   salma

mov  cx,XEnd
cmp  XSHH,cx
js   NoOut2
inc  ShapeOut2
mov  bl,ShapeOut2
cmp  bl,Shapes2
jnz  NoOut2
mov  winner,2
NoOut2: 
call RemoveShape
;;don't forget to make harder level here  

mov  al,0CH 
call DrawShape2
;;Decrement Score
;mov  cl,score2digits
;mov  digits,cl
;mov  cl,score2tenth
;mov  tenth,cl
;mov  cl,score2Hundreds
;mov  hundreds,cl
;call DecermentScore
;mov  cl,digits
;mov  score2digits,cl
;mov  cl,tenth
;mov  score2tenth,cl
;mov  cl,hundreds
;mov  score2Hundreds,cl
;;Incrmenting Moves
mov  cl,Moves2digits
mov  digits,cl
mov  cl,Moves2tenth
mov  tenth,cl
mov  cl,Moves2Hundreds
mov  hundreds,cl
mov  cl,score2
mov  score,cl
call IncrementMoves
mov  cl,digits
mov  Moves2digits,cl
mov  cl,tenth
mov  Moves2tenth,cl
mov  cl,hundreds
mov  Moves2Hundreds,cl
mov  cl,Score
mov  Score2,cl
call WriteScore
;dec  Score2
inc  Moves2
jmp  salma
hlt
main endp
 ;;########################################################################################################

 ;;======================##################PROCS#################===================================
DrawHor proc near
mov si,5H
mov dx,470D
NextHorline:
mov cx,100D
mov al,0FH
mov ah,0ch
backHL:mov bx,0
       int 10h                  
       inc cx
       cmp cx,400D
       jnz backHL
       sub dx,75D
       dec si
       jnz NextHorLine
       ret
DrawHor   endp  
;##################
DrawVer proc near
mov cx,100D
mov si,5H
NextVerline:
mov Dx,470D
mov al,0FH
mov ah,0ch
backVL:mov bx,0
       int 10H
       dec dx
       cmp dx,170D
       jnz backVL
       add cx,75D
       dec si 
       jnz NextVerline
       ret
DrawVer   endp   
;#################
DrawShape proc near
;mov al,09H
mov ah,0ch
mov bx,0
int 10H
mov SI,YSH
sub SI,16D 
Next:
inc XSHR
dec XSHL
dec YSH
cmp YSH,SI
jz  HorLineL
mov cx,XSHR
mov dx,YSH
;mov al,09H
mov ah,0ch
mov bx,0
int 10H
mov cx,XSHL
mov dx,YSH
;mov al,09H
mov ah,0ch
mov bx,0
int 10H 
jmp Next
 
 
 
;;;drawing left part of shape      
HorLineL:
mov DI,XSHL
mov SI,XSHL
sub SI,21D
dec XSHR
inc XSHL
inc YSH
mov dx,YSH
mov bp,16D
LLL: 
mov cx,DI
NextHorLineL:
;mov al,09H
mov ah,0ch
mov bx,0
int 10H
dec cx
cmp cx,SI
jnz NextHorlineL 
dec bp
jz  LL
inc DI
inc dx
inc SI
jmp LLL

;;;filling left part of shape after "\/"
LL:
mov cx,Xcenter
RestHorL:
;mov al,09H
mov ah,0ch
mov bx,0
int 10H
dec cx
cmp cx,SI
jnz RestHorL
inc dx
inc si
cmp SI,Xcenter
jnz LL 


;;;drawing Right part of shape      
HorLineR:
mov DI,XSHR
mov SI,XSHR
add SI,21D
mov dx,YSH
mov bp,16D
RR: 
mov cx,DI
NextHorLineR:
;mov al,09H
mov ah,0ch
mov bx,0
int 10H
inc cx
cmp cx,SI
jnz NextHorlineR 
dec bp
jz  RRR
dec DI
inc dx
dec SI
jmp RR

;;;filling left part of shape after "\/"
RRR:
mov cx,Xcenter
RestHorR:
;mov al,09H
mov ah,0ch
mov bx,0
int 10H
inc cx
cmp cx,SI
jnz RestHorR
inc dx
dec si
cmp SI,Xcenter
jnz RRR 
ret  
DrawShape endp
;;#############################

DrawShape2 proc near
;mov al,0CH
mov ah,0ch
mov bx,0
int 10H
mov SI,XSHH
add SI,16D 
Nextt:
inc Ydown
dec Yup
inc XSHH
cmp XSHH,SI
jz  VerLineUp
mov cx,XSHH
mov dx,Yup
;mov al,0CH
mov ah,0ch
mov bx,0
int 10H
mov cx,XSHH
mov dx,Ydown
;mov al,0CH
mov ah,0ch
mov bx,0
int 10H 
jmp Nextt


             
VerLineUp:
mov DI,Yup
mov SI,yup
sub SI,21D
inc Yup
dec Ydown
dec XSHH
mov cx,XSHH
mov bp,16D
UP: 
mov dx,DI

NextVerLineUp:
;mov al,0CH
mov ah,0ch
mov bx,0
int 10H
dec dx
cmp dx,SI
jnz LightMagenta
jmp cont

LightMagenta:
;mov al,0CH
mov ah,0ch
mov bx,0
int 10H
dec dx
cmp dx,SI
jnz NextVerLineUp

cont: 
dec bp
jz  VerLine
inc DI
dec cx
inc SI
jmp UP

;;;filling up part of shape after "\/"
VerLine:
mov dx,Ycenter
NextVerLin:
;mov al,0CH
mov ah,0ch
mov bx,0
int 10H
dec dx
cmp dx,SI
jnz LightYellow
jmp contt

LightYellow:
;mov al,0CH
mov ah,0ch
mov bx,0
int 10H
dec dx
cmp dx,SI
jnz NextVerLin

contt:
dec cx
inc si
cmp SI,Ycenter
jnz VerLine


VerLinedown:
mov DI,Ydown
mov SI,ydown
add SI,21D
mov cx,XSHH
mov bp,16D
Down: 
mov dx,DI 

NextVerLineDown:
;mov al,0CH
mov ah,0ch
mov bx,0
int 10H
inc dx
cmp dx,SI
jnz Yellow 
jmp conttt


Yellow:
;mov al,0CH
mov ah,0ch
mov bx,0
int 10H
inc dx
cmp dx,SI
jnz NextVerLineDown

conttt:
dec bp
jz  VerLinee
dec DI
dec cx
dec SI
jmp Down

;;;filling down part of shape after "\/"
VerLinee:
mov dx,Ycenter
NextVerLinee:
;mov al,0CH
mov ah,0ch
mov bx,0
int 10H
inc dx
cmp dx,SI
jnz Yell
jmp connt

Yell: 
;mov al,0CH
mov ah,0ch
mov bx,0
int 10H
inc dx
cmp dx,SI
jnz NextVerLinee


connt:
dec cx
dec si
cmp SI,Ycenter
jnz VerLinee              
    ret
DrawShape2 endp  
;#################################
WhitenSquare proc near
mov cx,XClicked
mov dx,YClicked
mov SI,75D
mov al,0FH
mov ah,0ch
FirstHorlineW:
       mov bx,0
       int 10h
       inc cx
       dec SI
       jnz FirstHorLineW

mov cx,XClicked
mov dx,YClicked
add dx,75D        
mov SI,75D
mov al,0FH
mov ah,0ch
SecondHorlineW:
       mov bx,0
       int 10h
       inc cx
       dec SI
       jnz SecondHorLineW
       
mov cx,XClicked
mov dx,YClicked       
mov SI,75D
mov al,0FH
mov ah,0ch
FirstVerlineW:
       mov bx,0
       int 10h
       inc dx
       dec SI
       jnz FirstVerLineW
       
mov cx,XClicked
mov dx,YClicked
add cx,75D        
mov SI,75D
mov al,0FH
mov ah,0ch
SecondVerlineW:
       mov bx,0
       int 10h
       inc dx
       dec SI
       jnz SecondVerLineW 
    
    
    
ret
whitenSquare endp
;############################################3
RemoveShape proc near
mov cx,XClicked
mov dx,YClicked
add dx,2D
add cx,2D
mov SI,71D
MOV BP,71D


mov al,0
mov ah,0ch
HORBACK:
mov bh,0
int 10H
inc cx
dec SI
cmp SI,0
jnz HORBACK
mov cx,XClicked
add cx,2D
inc dx
dec bp
mov SI,71D
cmp bp,0
jnz HORBACK



;;;X-->177-->249 ;;82
;;;Y-->404-->470 ;;66
ret
RemoveShape endp
;;;#############################################
WriteScore proc near
;;draw horizontal
mov cx,0
mov dx,15D
mov SI,280H 
mov al,0DH
mov ah,0Ch
BACKS:
mov bh,0
int 10H
inc cx
dec Si
jnz backS

;;Write FirstName
mov dx,0
mov al,1h
mov ah,13h 
mov bp,offset name1[2]
mov bh,0 
mov bl,09h
mov cl,name1[1]
mov ch,0h
int 10h

mov ah,2
mov dh,0
mov dl,name1[1]
add dl,2D
int 10H

mov ah,9
mov bh,0
mov al,Score1Hundreds
add al,48D
mov cx,1H
mov bl,0FH
int 10h
       
mov ah,2
mov dh,0
mov dl,name1[1]
add dl,3D
int 10H

mov ah,9
mov bh,0
mov al,Score1tenth
add al,48D
mov cx,1H
mov bl,0FH
int 10h


mov ah,2
mov dh,0
mov dl,name1[1]
add dl,4D
int 10H

mov ah,9
mov bh,0
mov al,Score1digits
add al,48D
mov cx,1H
mov bl,0FH
int 10h

;;Writing Moves


mov dx,0
mov dl,name1[1]
add dx,10D
mov al,1h
mov ah,13h 
mov bp,offset MesMoves 
mov bh,0 
mov bl,0Bh
mov cl,5
mov ch,0h
int 10h


mov ah,2
mov dh,0
mov dl,name1[1]
add dl,17D
int 10H

mov ah,9
mov bh,0
mov al,Moves1Hundreds
add al,48D
mov cx,1H
mov bl,0FH
int 10h
       
mov ah,2
mov dh,0
mov dl,name1[1]
add dl,18D
int 10H

mov ah,9
mov bh,0
mov al,Moves1tenth
add al,48D
mov cx,1H
mov bl,0FH
int 10h


mov ah,2
mov dh,0
mov dl,name1[1]
add dl,19D
int 10H

mov ah,9
mov bh,0
mov al,Moves1digits
add al,48D
mov cx,1H
mov bl,0FH
int 10h


       

;;Write SecondName
mov dx,00BBH
mov al,1h
mov ah,13h 
mov bp,offset name2[2]
mov bh,0 
mov bl,0Ch
mov cl,name2[1]
mov ch,0h 
int 10h

mov ah,2
mov dh,0
mov dl,0BBH
add dl,name2[1]
add dl,2D
int 10H

mov ah,9
mov bh,0
mov al,Score2Hundreds
add al,48D
mov cx,1H
mov bl,0FH
int 10h
       
mov ah,2
mov dh,0
mov dl,0BBH
add dl,name2[1]
add dl,3D
int 10H

mov ah,9
mov bh,0
mov al,Score2tenth
add al,48D
mov cx,1H
mov bl,0FH
int 10h


mov ah,2
mov dh,0
mov dl,0BBH
add dl,name2[1]
add dl,4D
int 10H


mov ah,9
mov bh,0
mov al,Score2digits
add al,48D
mov cx,1H
mov bl,0FH
int 10h

;;;Writing Moves

mov dx,00BBH
add dl,name2[1]
add dx,10D
mov al,1h
mov ah,13h 
mov bp,offset MesMoves 
mov bh,0 
mov bl,0Bh
mov cl,5
mov ch,0h
int 10h


mov ah,2
mov dx,00BBH
add dl,name2[1]
add dl,17D
int 10H

mov ah,9
mov bh,0
mov al,Moves2Hundreds
add al,48D
mov cx,1H
mov bl,0FH
int 10h
       
mov ah,2
mov dx,00BBH
add dl,name2[1]
add dl,18D
int 10H

mov ah,9
mov bh,0
mov al,Moves2tenth
add al,48D
mov cx,1H
mov bl,0FH
int 10h


mov ah,2
mov dx,00BBH
add dl,name2[1]
add dl,19D
int 10H

mov ah,9
mov bh,0
mov al,Moves2digits
add al,48D
mov cx,1H
mov bl,0FH
int 10h

    ret
WriteScore endp  
;;###########################################
DecermentScore proc near
cmp digits,0
jz  dectenth
dec digits
jmp return
dectenth:
mov digits,9D
cmp tenth,0
jz  dechundred
dec tenth
jmp return
dechundred:
mov tenth,9D
dec hundreds    
return:ret
DecermentScore endp 
;;##########################################
IncrementScore proc near
mov cl,Moves
cmp cl,10
js  bet0And10
jz  bet0And10
cmp cl,15
js  bet10And15
jz  bet10And15
cmp cl,20
js  bet15And20
jz  bet15And20
cmp cl,25
js  bet20And25
jz  bet20And25
cmp cl,30
js  bet25And30
jz  bet25And30
cmp cl,35
js  bet30And35
jz  bet30And35
jmp GreaterThan35


bet0And10:
add Score,60
add tenth,6D
cmp tenth,0AH
js  rett
sub tenth,10D
add hundreds,1D
jmp rett
bet10And15:
add Score,50
add tenth,5D
cmp tenth,0AH
js  rett
sub tenth,10D
add hundreds,1D
jmp rett
;jmp INCScore1
bet15And20:
add Score,40
;jmp INCScore1
add tenth,4D
cmp tenth,0AH
js  rett
sub tenth,10D
add hundreds,1D
jmp rett
bet20And25:
add Score,30
add tenth,3D
cmp tenth,0AH
js  rett
sub tenth,10D
add hundreds,1D
jmp rett
;jmp INCScore1
bet25And30:
add Score,20
add tenth,2D
cmp tenth,0AH
js  rett
sub tenth,10D
add hundreds,1D
jmp rett
;jmp INCScore1
bet30And35:
add Score,10
add tenth,1D
cmp tenth,0AH
js  rett
sub tenth,10D
add hundreds,1D
jmp rett
;jmp INCScore1
GreaterThan35:
add Score,5
add digits,5D
cmp digits,0AH
js  rett
sub digits,10D
add tenth,1D
    
rett:ret
IncrementScore endp

;;###########################################
IncrementMoves proc near
cmp digits,9
jns INCtenth
inc digits
jmp retturn    
;;Increment Tenth
INCtenth:
mov digits,0
cmp tenth,9
jns IncHundreds
inc tenth
jmp retturn 
;;Increment Hundreds
IncHundreds:
inc Hundreds
mov tenth,0   
retturn:ret
IncrementMoves endp 
;;###########################################
Beep PROC near
mov al,182
out 43h,al
mov ax,4560

out 42h,al
mov al,ah
out 42h,al
in  al,61h

or  al,00000011b
out 61h,al
mov bx,25
pause1:
mov cx,65535
pause2:
dec cx
jne pause2
dec bx
jne pause1
in  al,61h
and al,11111100b
out 61h,al
    ;IN AL, 61h  ;Save state
;    PUSH AX  
;    MOV BX, 6818; 1193180/175
;    MOV AL, 6Bh  ; Select Channel 2, write LSB/BSB mode 3
;    OUT 43h, AL 
;    MOV AX, BX 
;    OUT 24h, AL  ; Send the LSB
;    MOV AL, AH  
;    OUT 42h, AL  ; Send the MSB
;    IN AL, 61h   ; Get the 8255 Port Contence
;    OR AL, 3h      
;    OUT 61h, AL  ;End able speaker and use clock channel 2 for input
;    MOV CX, 03h ; High order wait value
;    MOV DX, 0D04h; Low order wait value
;    MOV AX, 86h;Wait service
;    INT 15h        
;    POP AX;restore Speaker state
;    OUT 61h, AL
    RET
BEEP ENDP






;################################======================END OF CODE======================#########################