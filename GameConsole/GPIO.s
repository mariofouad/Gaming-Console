
	; SW0--> B0 --> GREEN BUTTON -->RIGHT
	; SW1--> B1 --> BLACK BUTTON --> LEFT
	; SW2--> C13 --> YELLOW BUTTON (THE ONE NEXT TO THE BLACK) --> UP
	; SW3--> B4 --> YELLOW BUTTON  (THE LAST ONE ) -->DOWN
	
	; SW4-->C14--> CHOSE MARIO (YELOOW BUTTON)
	; SW5-->C15--> CHOSE SNAKE (GREEN BUTTON)
	
	; Blue led--> B5
	; PIN B2 DOESN'T EXIST 
	; PIN A15 DOESN'T EXIST 
	
	INCLUDE DEFINITIONS.s
		
	AREA	GPIOCODE, CODE, READONLY
	
*****************************************************************************

CONFIGURE_OUTPUT_INPUT_PINS  FUNCTION
	PUSH {R0-R2, LR}
	
    ; ENABLE PORTB CLOCK
	;START
	LDR R0, =RCC_APB2ENR         ; Address of RCC_APB2ENR register
    LDR R1, [R0]                 ; load RCC_APB2ENR in R1
	MOV R2, #1                   ; mov 8 in R2 to enable the clock for PORTB (1000)
    ORR R1, R1, R2, LSL #3       ; Set bit 3 to enable PORTB clock
    STR R1, [R0]                 ; Write the updated value back to RCC_APB2ENR
	;END
	
	; ENABLE PORTC CLOCK
	;START
	LDR R0, =RCC_APB2ENR         ; Address of RCC_APB2ENR register
    LDR R1, [R0]                 ; load RCC_APB2ENR in R1
	MOV R2, #1                   ; mov (10000) in R2 to enable the clock for PORTB 
    ORR R1, R1, R2, LSL #4       ; Set bit 4 to enable PORTB clock
    STR R1, [R0]                 ; Write the updated value back to RCC_APB2ENR
	;END
	
	;CONFIGURE B0,B1,B3,B4 AS INPUT PINS
	;START
	LDR R0, =GPIOB_CRL           ; ADDRESS OF GPIOB_CRL REG
	LDR R1,[R0]                  ; LOAD GPIOB_CRL REGISTER IN R1
	MOVW R2, #0x0F00             ; LOAD THE LOWER TWO BYTES IN R2
    MOVT R2, #0xFFF0             ; LOAD THE UPPER TWO BYTES IN R2
	AND R1,R1,R2
	;mov zeros 
	; then orr with numbers 
	              
	MOVW R2, #0x8088
	MOVT R2, #0x0008
	
	ORR R1,R1,R2                 ; MASKING TO CHANGE ONLY IN THE BITS I NEED TO CHANGE AND NOT THE WHOLE REGISTER
	STR R1, [R0]                 ; STORE R1 IN THE REGISTER 
	
	LDR R0, =GPIOB_ODR           ; ADDRESS OF GPIOB_ODR REG
	LDR R1,[R0]                  ; LOAD GPIOB_ODR REGISTER IN R1
	MOV R2, #0x001B              ; PUT 1 IN BIT 0,1,3 AND 4 IN GPIOB_ODR FOR THE PIN TO BE PULLUP
	ORR R1, R1,R2                ; MASKING TO CHANGE ONLY IN THE BITS I NEED TO CHANGE AND NOT THE WHOLE REGISTER
	STR R1, [R0]                 ; STORE R1 IN THE REGISTER
	;END  
	
	;CONFIGURE C13,C14 AND C15 AS INPUT PINS
	;START
	LDR R0, =GPIOC_CRH           ; ADDRESS OF GPIOC_CRH REG
	LDR R1,[R0]                  ; LOAD GPIOC_CRH REGISTER IN R1
	MOVW R2, #0xFFFF             ; LOAD THE LOWER TWO BYTES IN R2
    MOVT R2, #0x000F             ; LOAD THE UPPER TWO BYTES IN R2
	AND R1,R1,R2
	              
	MOVW R2, #0x0000
	MOVT R2, #0x8880
	
	ORR R1,R1,R2                 ; MASKING TO CHANGE ONLY IN THE BITS I NEED TO CHANGE AND NOT THE WHOLE REGISTER
	STR R1, [R0]                 ; STORE R1 IN THE REGISTER 
	
	LDR R0, =GPIOC_ODR           ; ADDRESS OF GPIOC_ODR REG
	LDR R1,[R0]                  ; LOAD GPIOC_ODR REGISTER IN R1
	MOV R2, #0xE000              ; PUT 1 IN BIT 13,14,15 IN GPIOC_ODR FOR THE PIN TO BE PULLUP
	ORR R1, R1,R2                ; MASKING TO CHANGE ONLY IN THE BITS I NEED TO CHANGE AND NOT THE WHOLE REGISTER
	STR R1, [R0]                 ; STORE R1 IN THE REGISTER
	;END  
	
	
	
	
	;CONFIGURE B5 AS OUTPUT PINS 
	;START
	LDR R0, =GPIOB_CRL           ; ADDRESS OF GPIOB_CRL REG
	LDR R1,[R0]                  ; LOAD GPIOB_CRL REGISTER IN R1
	MOV R2, #0XFF0FFFFF          ; PUT ZEROS IN THE BITS WE WANT TO INSERT IN FOR THE MASKING TO BE CORRECT
	AND R1,R1,R2
	MOV R2, #0x00300000          ; PUT 1 IN BIT 20,21 IN GPIOB_CRL FOR THE MODE TO BE FAST AND CNF0,CNF1 ARE ZEROS TO BE OUTPUT
	ORR R1,R1,R2                 ; MASKING TO CHANGE ONLY IN THE BITS I NEED TO CHANGE AND NOT THE WHOLE REGISTER
	STR R1, [R0]                 ; PUT R1 DIRECTLY IN GPIOB_CRH REG,  [R0] RESEMBLES A POINTER TO ADDRESS 
	;END
	
	POP {R0-R2, PC}
	ENDFUNC
	
********************************************************
; THE RESULT OF THIS FUNCTION WILL BE STORED IN R3 
; AFTER CALLING THIS FUNCTION IN THE MAIN COMPARE R3 with 0 TO CHECK IF THE BUTTON IS PRESSED OR NOT 
; IF THE RESULT=0 THEN THE BUTTON IS PRESSED

CHECK_SW0_PRESSED	FUNCTION
	PUSH {R0-R2, LR}
	
	LDR R0, =GPIOB_IDR           ; ADDRESS OF GPIOB_IDR REG
	LDR R1, [R0]                 ; LOAD GPIOB_IDR IN R1
	MOV R2, #0x00000001          ; THE NUMBER TO BE ANDed WITH THE REGISTER TO CHECK ON BIT 0
	AND R3,R2,R1                 ; AND R1 WITH R2 AND PUT THE RESULT IN R3 
	
	
	POP {R0-R2, PC}
	ENDFUNC
*********************************************************
; THE RESULT OF THIS FUNCTION WILL BE STORED IN R3 
; AFTER CALLING THIS FUNCTION IN THE MAIN COMPARE R3 with 0 TO CHECK IF THE BUTTON IS PRESSED OR NOT 
; IF THE RESULT=0 THEN THE BUTTON IS PRESSED

CHECK_SW1_PRESSED	FUNCTION

	PUSH {R0-R2, LR}
	
	LDR R0, =GPIOB_IDR           ; ADDRESS OF GPIOB_IDR REG
	LDR R1, [R0]                 ; LOAD GPIOB_IDR IN R1
	MOV R2, #0x000000002        ; THE NUMBER TO BE ANDed WITH THE REGISTER TO CHECK ON BIT 1
	AND R3,R2,R1                 ; AND R1 WITH R2 AND PUT THE RESULT IN R3 

	POP {R0-R2, PC}
	ENDFUNC
	
********************************************************************************************8
; THE RESULT OF THIS FUNCTION WILL STORED IN R3 
; AFTER CALLING THIS FUNCTION IN THE MAIN COMPARE R3 with 0 TO CHECK IF THE BUTTON IS PRESSED OR NOT 
; IF THE RESULT=0 THEN THE BUTTON IS PRESSED

CHECK_SW2_PRESSED	FUNCTION

	PUSH {R0-R2, LR}
	
	LDR R0, =GPIOC_IDR           ; ADDRESS OF GPIOB_IDR REG
	LDR R1, [R0]                 ; LOAD GPIOB_IDR IN R1
	MOV R2, #0x000002000        ; THE NUMBER TO BE ANDed WITH THE REGISTER TO CHECK ON BIT 13
	AND R3,R2,R1                 ; AND R1 WITH R2 AND PUT THE RESULT IN R3 

	POP {R0-R2, PC}
	ENDFUNC
*********************************************************
; THE RESULT OF THIS FUNCTION WILL STORED IN R3 
; AFTER CALLING THIS FUNCTION IN THE MAIN COMPARE R3 with 0 TO CHECK IF THE BUTTON IS PRESSED OR NOT 
; IF THE RESULT=0 THEN THE BUTTON IS PRESSED

CHECK_SW3_PRESSED	FUNCTION

	PUSH {R0-R2, LR}
	
	LDR R0, =GPIOB_IDR           ; ADDRESS OF GPIOB_IDR REG
	LDR R1, [R0]                 ; LOAD GPIOB_IDR IN R1
	MOV R2, #0x000000010         ; THE NUMBER TO BE ANDed WITH THE REGISTER TO CHECK ON BIT 4
	AND R3,R2,R1                 ; AND R1 WITH R2 AND PUT THE RESULT IN R3 

	POP {R0-R2, PC}
	ENDFUNC
	
**************************************************************************************
CHECK_SW4_PRESSED	FUNCTION
	
	PUSH {R0-R2, LR}
	
	LDR R0, =GPIOC_IDR           ; ADDRESS OF GPIOB_IDR REG
	LDR R1, [R0]                 ; LOAD GPIOB_IDR IN R1
	MOV R2, #0x00004000          ; THE NUMBER TO BE ANDed WITH THE REGISTER TO CHECK ON BIT 0
	AND R3,R2,R1                 ; AND R1 WITH R2 AND PUT THE RESULT IN R3 
	
	
	POP {R0-R2, PC}
	ENDFUNC
***********************************************************************************
CHECK_SW5_PRESSED	FUNCTION
	
	PUSH {R0-R2, LR}
	
	LDR R0, =GPIOC_IDR           ; ADDRESS OF GPIOB_IDR REG
	LDR R1, [R0]                 ; LOAD GPIOB_IDR IN R1
	MOV R2, #0x00008000          ; THE NUMBER TO BE ANDed WITH THE REGISTER TO CHECK ON BIT 0
	AND R3,R2,R1                 ; AND R1 WITH R2 AND PUT THE RESULT IN R3 
	
	
	POP {R0-R2, PC}

	ENDFUNC
*********************************************************

BLUE_LED_ON		FUNCTION
	PUSH {R0-R2, LR}
	
	LDR R0,=GPIOB_ODR            ; ADDRESS OF GPIOB_ODR REG
	LDR R1, [R0]                 ; LOAD GPIOB_ODR IN R1
	MOV R2, #0x00000020          ; THIS IS THE NUMBER TO BE ORRed WITH THE REGISTER TO INSERT 1 IN BIT 5
	ORR R1,R1,R2                 ; ORR R1 WITH R2 AND PUT THE RESULT IN R1
	STR R1, [R0]                 ; STORE R1 IN THE REGISTER
	
	MOV R3,#1                    ;THIS LINE HAS NO EFFECT ON THE FUNCTION, JUST USED TO OVERCOME THE CMP BUG
	
	POP {R0-R2, PC}
	ENDFUNC
*********************************************************

**********************************************************
LEDS_OFF	FUNCTION
	PUSH {R0-R2, LR}
	
	LDR R0,=GPIOB_ODR           ; ADDRESS OF GPIOB_ODR REG 
	LDR	R1,[R0]
	MOV R2, #0xFFFFFFDF        ; THIS IS THE NUMBER TO BE ANDed WITH THE REGISTER TO INSERT 0 IN BTS 4 ,5    
	AND R1,R1,R2                ; AND R1 WITH R1 AND PUT THE RESULT IN R1
	STR R1, [R0]                ; STORE R1 IN THE REGISTER
	
	POP {R0-R2, PC}
	ENDFUNC
*********************************************************
	
	END
			
		
		
	