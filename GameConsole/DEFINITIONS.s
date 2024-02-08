	AREA MYDATA, DATA, READWRITE
		
;Clock Register (RCC)
RCC_BASE	    EQU		  0x40021000          ; base address
RCC_APB2ENR		EQU		  RCC_BASE + 0x18 

;Port B Registers

GPIOB_BASE      EQU       0x40010C00          ;Base address of port B
GPIOB_CRL       EQU       GPIOB_BASE+ 0X00 
GPIOB_CRH       EQU	      GPIOB_BASE+ 0X04
GPIOB_ODR       EQU       GPIOB_BASE+ 0X0C
GPIOB_IDR       EQU       GPIOB_BASE+ 0x08
	
; PORTA REGISTERS 	
GPIOA_BASE      EQU       0x40010800	     ;Base address of port A
GPIOA_CRL       EQU       GPIOA_BASE+ 0X00   ;CONGIGURE TYPE AND SPEED OF PINS 0->7
GPIOA_CRH       EQU	      GPIOA_BASE+ 0X04   ;CONFIGURE TYPE AND SPEED OF PINS 8->15
GPIOA_ODR       EQU       GPIOA_BASE+ 0X0C   ; REGISTER TO PUT YOUR DATA AS OUTPUT 
	
;PORTC REGISTERS
GPIOC_BASE      EQU       0x40011000         ;Base address of port c
GPIOC_CRL       EQU       GPIOC_BASE+ 0X00 
GPIOC_CRH       EQU	      GPIOC_BASE+ 0X04
GPIOC_ODR       EQU       GPIOC_BASE+ 0X0C
GPIOC_IDR       EQU       GPIOC_BASE+ 0x08
INTERVAL EQU 0x566004		;just a number to perform the delay. this number takes roughly 1 second to decrement until it reaches 0


;just some color codes, 16-bit colors coded in RGB 565
BLACK	      EQU   0x0000
BLUE 	      EQU  	0x001F
DARK_BLUE 	  EQU   0x5A73
RED  	      EQU  	0xF800
RED2   	      EQU 	0x4000
GREEN 	      EQU  	0x07E0
CYAN  	      EQU  	0x07FF
MAGENTA       EQU 	0xF81F
YELLOW	      EQU  	0xFFE0
WHITE 	      EQU  	0xFFFF
GREEN2 	      EQU 	0x2FA4
CYAN2 	      EQU  	0x07FF
BROWN         EQU	0xAB69
BEIGE	      EQU	0xF77C
GREY 		  EQU   0x9cf3
	
	


	
;HEAD_X	DCW		0x00
;HEAD_Y	DCW		0x00	
;TAIL_X	DCW		0x00
;TAIL_Y	DCW		0x00
EATENAPPLES      DCB        0
SNAKE_X DCW     140, 140, 500, 500, 500, 500, 500
SNAKE_Y DCW     40, 80, 500, 500, 500, 500, 500
DIRECTION DCB   2
	; up =2
	;down=3
	;right =0
	;left=1
LENGTH     DCB    2
GOOD_APPLE_X	 DCW	0x00
GOOD_APPLE_Y	 DCW	0x00
BAD_APPLE_X 	DCW		0x00
BAD_APPLE_Y 	DCW		0x00
GOOD_APPLE1_X	 DCW	    0x00
GOOD_APPLE1_Y	 DCW	    0x00

GOOD_APPLE2_X	 DCW	    0x00
GOOD_APPLE2_Y	 DCW	    0x00

GOOD_APPLE3_X	 DCW	    0x00
GOOD_APPLE3_Y	 DCW	    0x00

GOOD_APPLE4_X	 DCW	    0x00
GOOD_APPLE4_Y	 DCW	    0x00

GOOD_APPLE5_X	 DCW	    0x00
GOOD_APPLE5_Y	 DCW	    0x00

;=========================================== MARIO ADRESSEES =================================================================
MARIO_X1		    DCW 	   0X0A
MARIO_X2		    DCW		   0X31
MARIO_Y1		    DCW		   0X89
MARIO_Y2		    DCW		   0XC8

ENEMY_X1            DCW        0X0A
ENEMY_X2            DCW        0X3C
ENEMY_Y1            DCW        0XAF
ENEMY_Y2            DCW        0XD2

TURTLE_X1           DCW        0X0A
TURTLE_X2           DCW        0X3C
TURTLE_Y1           DCW        0XA0
TURTLE_Y2           DCW        0XD2

ENEMY_DIRECTION     DCW        0X00
LEVEL 		        DCB        0X01
;=====================================

	END