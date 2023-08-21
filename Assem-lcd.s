PORTB = $6000
PORTA = $6001
DDPB = $6002
DDPA = $6003

E = %10000000
RWB = %01000000
RS = %00100000

  .org $f800

reset:
  lda #%11111111 ; set all port B pins to output
  sta DDPB

  lda #%11100000 ; set top 3  port A pins to output
  sta DDPA

;command - set display to 8bit mode, 2lines and 5x8 font

  lda #%00111000 ; set display to 8bit mode, 2lines and 5x8 font
  sta PORTB

  ;sending command routine 

  lda #0
  sta PORTA ; clear E,RWB,RS 

  lda #E ; set E bit to send
  sta PORTA

  lda #0
  sta PORTA ; clear E,RWB,RS 

;command - set display on, cursor on, blink off

  lda #%00001110 ; set display on, cursor on, blink off
  sta PORTB

  ;sending command routine 

  lda #0
  sta PORTA ; clear E,RWB,RS 

  lda #E ; set E bit to send
  sta PORTA

  lda #0
  sta PORTA ; clear E,RWB,RS 

;command - shift cursor right when writing, no display shift 

  lda #%00000110 ; shift cursor right when writing, no display shift 
  sta PORTB

  ;sending command routine 

  lda #0
  sta PORTA ; clear E,RWB,RS 

  lda #E ; set E bit to send
  sta PORTA

  lda #0
  sta PORTA ; clear E,RWB,RS 

; writing letter - H
  lda #"H"
  sta PORTB

  ;sending letter routine
  ;keeping RS high while toggling E on/off
  lda #RS
  sta PORTA ;  

  lda #(E | RS) ;
  sta PORTA

  lda #RS
  sta PORTA ; 

; writing letter - e
  lda #"e"
  sta PORTB

  ;sending letter routine
  ;keeping RS high while toggling E on/off
  lda #RS
  sta PORTA ;  

  lda #(E | RS) ;
  sta PORTA

  lda #RS
  sta PORTA ;

; writing letter - l
  lda #"l"
  sta PORTB

  ;sending letter routine
  ;keeping RS high while toggling E on/off
  lda #RS
  sta PORTA ;  

  lda #(E | RS) ;
  sta PORTA

  lda #RS
  sta PORTA ;

; writing letter - l
  lda #"l"
  sta PORTB

  ;sending letter routine
  ;keeping RS high while toggling E on/off
  lda #RS
  sta PORTA ;  

  lda #(E | RS) ;
  sta PORTA

  lda #RS
  sta PORTA ;

; writing letter - o
  lda #"o"
  sta PORTB

  ;sending letter routine
  ;keeping RS high while toggling E on/off
  lda #RS
  sta PORTA ;  

  lda #(E | RS) ;
  sta PORTA

  lda #RS
  sta PORTA ;  

; writing letter - ,
  lda #","
  sta PORTB

  ;sending letter routine
  ;keeping RS high while toggling E on/off
  lda #RS
  sta PORTA ;  

  lda #(E | RS) ;
  sta PORTA

  lda #RS
  sta PORTA ; 

; writing letter - W
  lda #"W"
  sta PORTB

  ;sending letter routine
  ;keeping RS high while toggling E on/off
  lda #RS
  sta PORTA ;  

  lda #(E | RS) ;
  sta PORTA

  lda #RS
  sta PORTA ;

; writing letter - o
  lda #"o"
  sta PORTB

  ;sending letter routine
  ;keeping RS high while toggling E on/off
  lda #RS
  sta PORTA ;  

  lda #(E | RS) ;
  sta PORTA

  lda #RS
  sta PORTA ;

; writing letter - r
  lda #"r"
  sta PORTB

  ;sending letter routine
  ;keeping RS high while toggling E on/off
  lda #RS
  sta PORTA ;  

  lda #(E | RS) ;
  sta PORTA

  lda #RS
  sta PORTA ;     

; writing letter - l
  lda #"l"
  sta PORTB

  ;sending letter routine
  ;keeping RS high while toggling E on/off
  lda #RS
  sta PORTA ;  

  lda #(E | RS) ;
  sta PORTA

  lda #RS
  sta PORTA ;

; writing letter - d
  lda #"d"
  sta PORTB

  ;sending letter routine
  ;keeping RS high while toggling E on/off
  lda #RS
  sta PORTA ;  

  lda #(E | RS) ;
  sta PORTA

  lda #RS
  sta PORTA ;  

; writing letter - !
  lda #"!"
  sta PORTB

  ;sending letter routine
  ;keeping RS high while toggling E on/off
  lda #RS
  sta PORTA ;  

  lda #(E | RS) ;
  sta PORTA

  lda #RS
  sta PORTA ; 

loop:     ;infinite-loop (1)
  jmp loop
  
  .org $fffc
  .word reset
  .word $0000
