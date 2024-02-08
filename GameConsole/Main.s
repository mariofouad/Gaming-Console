	
	INCLUDE GPIO.s
	
;the following are pins connected from the TFT to BLUEPILL board
;RD = PB10		Read pin	--> to read from touch screen input 
;WR = PB11		Write pin	--> to write data/command to display
;RS = PB12		Command pin	--> to choose command or data to write
;CS = PB15		Chip Select	--> to enable the TFT, lol	(active low)
;RST= PB8		Reset		--> to reset the TFT (active low)
;D0-7 = PA 0-7	Data BUS	--> Put your command or data on this bus

	EXPORT __main
	
	IMPORT MARIO
	IMPORT COIN
	IMPORT ENEMY
	IMPORT TURTLE
		

	AREA	MYCODE, CODE, READONLY
	ENTRY
	
__main FUNCTION

	
	;CALL FUNCTION SETUP
	BL SETUP
	
	;CALL THE FUNCTION TO CONFIGURE THE OUTPUT AND INPUT PINS
	;BL CONFIGURE_OUTPUT_INPUT_PINS
	BL CONFIGURE_OUTPUT_INPUT_PINS
	BL DRAW_MAIN_MENU
	
MYWHILE               ; THE LOOP THAT THE CODE WILL BE RUNING IN

	;INTERFACE_FUNCTION
	
	BL CHECK_SW4_PRESSED ; MARIO BUTTON  (YELLOW)
	CMP R3,#0
	;BEQ BLUE_LED_ON
	BEQ START_SUPER_MARIO


	BL CHECK_SW5_PRESSED  ; SNAKE BUTTON (GREEN)
	CMP R3,#0
	;BEQ BLUE_LED_ON
	BEQ START_SNAKE

	B MYWHILE

	
	ENDFUNC


;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ FUNCTIONS' DEFINITIONS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



;/***************************************************************************************************************/

;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

START_SNAKE	    FUNCTION 
	PUSH {R0-R2,R4-R12, LR}
	
	BL INITIALZE_SNAKE_COORDINATES
	BL DRAW_BG_SNAKE
	BL DRAW_SNAKE
	BL DRAW_GOOD_APPLE1
	BL DRAW_GOOD_APPLE2
	BL DRAW_GOOD_APPLE3
	BL DRAW_GOOD_APPLE4
	BL DRAW_GOOD_APPLE5
	BL DRAW_POISONED_APPLE
	
	BL delay_1_second
	
SNAKE_LOOP
	BL DRAW_SNAKE_GAME
	
	BL delay_half_second
	B SNAKE_LOOP
	
	
	MOV R3,#1                   ;THIS LINE HAS NO EFFECT ON THE FUNCTION, JUST USED TO OVERCOME THE CMP BUG
	POP {R0-R2,R4-R12, PC}
	
		
	ENDFUNC

;##########################################################################################################
START_SUPER_MARIO  FUNCTION

	PUSH {R0-R2,R4-R12, LR}

	;LEVEL ONE FRAME ONE
	BL INITIALIZE_VARIABLES
	BL DRAW_MARIO_GAME
	BL READ_MARIO_INPUT
	
	
	
	MOV R3,#1                   ;THIS LINE HAS NO EFFECT ON THE FUNCTION, JUST USED TO OVERCOME THE CMP BUG
	POP {R0-R2,R4-R12, PC}
	
;======================================================================================================================================================

	
;###########################################################################################################
	LTORG
;==========================================================SCREENS===============================================
DRAW_MAIN_MENU
	PUSH {R0-R12, LR}
	MOV R0, #0
	MOV R1, #0
	MOV R3, #160
	MOV R4, #240
	LDR R10, =GREEN
	BL DRAW_RECTANGLE_FILLED
	MOV R0, #160
	MOV R1, #0
	MOV R3, #320
	MOV R4, #240
	LDR R10, =YELLOW
	BL DRAW_RECTANGLE_FILLED
	; SNAKE S

	MOV R0, #40
	MOV R1, #70
	MOV R3, #120
	MOV R4, #90
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #40
	MOV R1, #70
	MOV R3, #60
	MOV R4, #120
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #40
	MOV R1, #100
	MOV R3, #120
	MOV R4, #120
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #100
	MOV R1, #100
	MOV R3, #120
	MOV R4, #150
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #40
	MOV R1, #130
	MOV R3, #120
	MOV R4, #150
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	;M
	MOV R0, #200
	MOV R1, #70
	MOV R3, #280
	MOV R4, #90
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #200
	MOV R1, #70
	MOV R3, #220
	MOV R4, #170
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #230
	MOV R1, #70
	MOV R3, #250
	MOV R4, #170
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #260
	MOV R1, #70
	MOV R3, #280
	MOV R4, #170
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	POP {R0-R12, PC}
	
	
GAME_OVER_SCREEN
    PUSH {R0-R12, LR}
    ;MOUTH
    MOV R0,#80
    MOV R1,#160
    MOV R3,#240
    MOV R4,#180
    LDR R10,=WHITE
    BL DRAW_RECTANGLE_FILLED
    MOV R0,#80
    MOV R1,#160
    MOV R3,#100
    MOV R4,#210
    LDR R10,=WHITE
    BL DRAW_RECTANGLE_FILLED
    MOV R0,#220
    MOV R1,#160
    MOV R3,#240
    MOV R4,#210
    LDR R10,=WHITE
    BL DRAW_RECTANGLE_FILLED
    ;EYES
    MOV R0,#105
    MOV R1,#65
    MOV R3,#135
    MOV R4,#95
    LDR R10,=WHITE
    BL DRAW_RECTANGLE_FILLED

    MOV R0,#185
    MOV R1,#65
    MOV R3,#215
    MOV R4,#95
    LDR R10,=WHITE
    BL DRAW_RECTANGLE_FILLED

    POP {R0-R12, PC}

GG_SCREEN
    PUSH {R0-R12, LR}
    ;FIRST G
    MOV R0,#30
    MOV R1,#50
    MOV R3,#70
    MOV R4,#190
    LDR R10,=WHITE
    BL DRAW_RECTANGLE_FILLED
    MOV R0,#30
    MOV R1,#50
    MOV R3,#150
    MOV R4,#95
    LDR R10,=WHITE
    BL DRAW_RECTANGLE_FILLED
    MOV R0,#30
    MOV R1,#145
    MOV R3,#150
    MOV R4,#190
    LDR R10,=WHITE
    BL DRAW_RECTANGLE_FILLED
    MOV R0,#110
    MOV R1,#125
    MOV R3,#150
    MOV R4,#190
    LDR R10,=WHITE
    BL DRAW_RECTANGLE_FILLED

    ;SECOND G
    MOV R0,#170
    MOV R1,#50
    MOV R3,#210
    MOV R4,#190
    LDR R10,=WHITE
    BL DRAW_RECTANGLE_FILLED
    MOV R0,#170
    MOV R1,#50
    MOV R3,#290
    MOV R4,#95
    LDR R10,=WHITE
    BL DRAW_RECTANGLE_FILLED
    MOV R0,#170
    MOV R1,#145
    MOV R3,#290
    MOV R4,#190
    LDR R10,=WHITE
    BL DRAW_RECTANGLE_FILLED
    MOV R0,#250
    MOV R1,#125
    MOV R3,#290
    MOV R4,#190
    LDR R10,=WHITE
    BL DRAW_RECTANGLE_FILLED
    POP {R0-R12, PC}
;#####################################################################################################################################################################
LCD_WRITE
	;this function takes what is inside r2 and writes it to the tft
	;this function writes 8 bits only
	;later we will choose whether those 8 bits are considered a command, or just pure data
	;your job is to just write 8-bits (regardless if data or command) to PE0-7 and set WR appropriately
	;arguments: R2 = data to be written to the D0-7 bus

	;TODO: PUSH THE NEEDED REGISTERS TO SAVE THEIR CONTENTS. HINT: Push any register you will modify inside the function, and LR 
	 
	PUSH{R0-R12,LR}


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SETTING WR to 0 ;;;;;;;;;;;;;;;;;;;;;
	;TODO: RESET WR TO 0
	ldr r0,=GPIOB_ODR
	ldr r3,[r0]
	ldr r1,=1
	lsl r1,#11
    mvn R1,R1    ;ONES COMPLEMENT OF R1  
	AND r3,r3,r1
	str r3,[r0]

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	;;;;;;;;;;;;; HERE YOU PUT YOUR DATA which is in R2 TO PE0-7 ;;;;;;;;;;;;;;;;;
	;TODO: SET PE0-7 WITH THE LOWER 8-bits of R2
	;only write the lower byte to PE0-7
	 LDR  R0,=GPIOA_ODR
	 STRB R2,[R0]

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	;;;;;;;;;;;;;;;;;;;;;;;;;; SETTING WR to 1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;TODO: SET WR TO 1 AGAIN (ie make a rising edge)
	ldr r0,=GPIOB_ODR
	ldr r3,[r0]
	ldr r1,=1
	lsl r1,#0X0B
	ORR r3,r1
	str r3,[r0]
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	;TODO: POP THE REGISTERS YOU JUST PUSHED, and PC
	POP{R0-R12,PC}
	
;#####################################################################################################################################################################


;#####################################################################################################################################################################
LCD_COMMAND_WRITE
	;this function writes a command to the TFT, the command is read from R2
	;it writes LOW to RS first to specify that we are writing a command not data.
	;then it normally calls the function LCD_WRITE we just defined above
	;arguments: R2 = data to be written on D0-7 bus

	;TODO: PUSH ANY NEEDED REGISTERS
		PUSH{R0-R12,LR}
	

	;;;;;;;;;;;;;;;;;;;;;;;;;; SETTING RD to 1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;TODO: SET RD HIGH (we won't need reading anyways, but we must keep read pin to high, which means we will not read anything)
	ldr r0,=GPIOB_ODR
	ldr r3,[r0]
	ldr r1,=1
	lsl r1,#0X0A
	ORR r3,r1
	str r3,[r0]
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	;;;;;;;;;;;;;;;;;;;;;;;;; SETTING RS to 0 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;TODO: SET RS TO 0 (to specify that we are writing commands not data on the D0-7 bus)
	ldr r0,=GPIOB_ODR
	ldr r3,[r0]
	ldr r1,=1
	lsl r1,#0X0C
    MVN R1,R1;          ONES COMPLEMENT OF R1 
	AND r3,r1
	str r3,[r0]
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;TODO: CALL FUNCTION LCD_WRITE
	 BL LCD_WRITE


	;TODO: POP ALL REGISTERS YOU PUSHED
		POP{R0-R12,PC}
;#####################################################################################################################################################################






;#####################################################################################################################################################################
LCD_DATA_WRITE
	;this function writes Data to the TFT, the data is read from R2
	;it writes HIGH to RS first to specify that we are writing actual data not a command.
	;arguments: R2 = data

	;TODO: PUSH ANY NEEDED REGISTERS
		PUSH{R0-R12,LR}


	;;;;;;;;;;;;;;;;;;;;;;;;;; SETTING RD to 1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;TODO: SET RD HIGH (we won't need reading anyways, but we must keep read pin to high, which means we will not read anything)
	ldr r0,=GPIOB_ODR
	ldr r3,[r0]
	ldr r1,=1
	lsl r1,#0X0A
	ORR r3,r1
	str r3,[r0]
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	



	;;;;;;;;;;;;;;;;;;;; SETTING RS to 1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;TODO: SET RS TO 1 (to specify that we are sending actual data not a command on the D0-7 bus)
	ldr r0,=GPIOB_ODR
	ldr r3,[r0]
	ldr r1,=1
	lsl r1,#0X0C
	ORR r3,r1
	str r3,[r0]
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



	;TODO: CALL FUNCTION LCD_WRITE
	BL LCD_WRITE

	;TODO: POP ANY REGISTER YOU PUSHED
	POP{R0-R12,PC}
;#####################################################################################################################################################################




; REVISE WITH YOUR TA THE LAST 3 FUNCTIONS (LCD_WRITE, LCD_COMMAND_WRITE AND LCD_DATA_WRITE BEFORE PROCEEDING)




;#####################################################################################################################################################################
LCD_INIT
	;This function executes the minimum needed LCD initialization measures
	;Only the necessary Commands are covered
	;Eventho there are so many more in the DataSheet

	;TODO: PUSH ANY NEEDED REGISTERS
	PUSH{R0-R12,LR}

	;;;;;;;;;;;;;;;;; HARDWARE RESET (putting RST to high then low then high again) ;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;TODO: SET RESET PIN TO HIGH
	ldr r0,=GPIOB_ODR
	ldr r3,[r0]
	ldr r1,=1
	lsl r1,#8
	ORR r3,r1
	str r3,[r0]

	;TODO: DELAY FOR SOME TIME (USE ANY FUNCTION AT THE BOTTOM OF THIS FILE)
	BL delay_half_second

	;TODO: RESET RESET PIN TO LOW
	ldr r0,=GPIOB_ODR
	ldr r3,[r0]
	ldr r1,=1
	lsl r1,#8
    MVN R1,R1;          ONES COMPLEMENT OF R1 
	AND r3,r1
	str r3,[r0]

	;TODO: DELAY FOR SOME TIME (USE ANY FUNCTION AT THE BOTTOM OF THIS FILE)
	BL delay_half_second

	;TODO: SET RESET PIN TO HIGH AGAIN
	ldr r0,=GPIOB_ODR
	ldr r3,[r0]
	ldr r1,=1
	lsl r1,#8
	ORR r3,r1
	str r3,[r0]

	;TODO: DELAY FOR SOME TIME (USE ANY FUNCTION AT THE BOTTOM OF THIS FILE)
	BL delay_half_second
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






	;;;;;;;;;;;;;;;;; PREPARATION FOR WRITE CYCLE SEQUENCE (setting CS to high, then configuring WR and RD, then resetting CS to low) ;;;;;;;;;;;;;;;;;;
	;TODO: SET CS PIN HIGH
	ldr r0,=GPIOB_ODR
	ldr r3,[r0]
	ldr r1,=1
	lsl r1,#15
	ORR r3,r1
	str r3,[r0]

	;TODO: SET WR PIN HIGH
	ldr r0,=GPIOB_ODR
	ldr r3,[r0]
	ldr r1,=1
	lsl r1,#11
	ORR r3,r1
	str r3,[r0]

	;TODO: SET RD PIN HIGH
	ldr r0,=GPIOB_ODR
	ldr r3,[r0]
	ldr r1,=1
	lsl r1,#10
	ORR r3,r1
	str r3,[r0]

	;TODO: SET CS PIN LOW
	ldr r0,=GPIOB_ODR
	ldr r3,[r0]
	ldr r1,=1
	lsl r1,#15
    MVN R1,R1;          ONES COMPLEMENT OF R1 
	AND r3,r1
	str r3,[r0]
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	




	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SOFTWARE INITIALIZATION SEQUENCE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;ISSUE THE "SET CONTRAST" COMMAND, ITS HEX CODE IS 0xC5
	MOV R2, #0xC5
	BL LCD_COMMAND_WRITE

	;THIS COMMAND REQUIRES 2 PARAMETERS TO BE SENT AS DATA, THE VCOM H, AND THE VCOM L
	;WE WANT TO SET VCOM H TO A SPECIFIC VOLTAGE WITH CORRESPONDS TO A BINARY CODE OF 1111111 OR 0x7F HEXA
	;SEND THE FIRST PARAMETER (THE VCOM H) NEEDED BY THE COMMAND, WITH HEX 0x7F, PARAMETERS ARE SENT AS DATA BUT COMMANDS ARE SENT AS COMMANDS
	MOV R2, #0x7F
	BL LCD_DATA_WRITE

	;WE WANT TO SET VCOM L TO A SPECIFIC VOLTAGE WITH CORRESPONDS TO A BINARY CODE OF 00000000 OR 0x00 HEXA
	;SEND THE SECOND PARAMETER (THE VCOM L) NEEDED BY THE CONTRAST COMMAND, WITH HEX 0x00, PARAMETERS ARE SENT AS DATA BUT COMMANDS ARE SENT AS COMMANDS
	MOV R2, #0x00
	BL LCD_DATA_WRITE


	;MEMORY ACCESS CONTROL AKA MADCLT | DATASHEET PAGE 127
	;WE WANT TO SET MX (to draw from left to right) AND SET MV (to configure the TFT to be in horizontal landscape mode, not a vertical screen)
	;TODO: ISSUE THE COMMAND MEMORY ACCESS CONTROL, HEXCODE 0x36
	mov R2,#0x36
	BL LCD_COMMAND_WRITE
	

	;TODO: SEND ONE NEEDED PARAMETER ONLY WITH MX AND MV SET TO 1. HOW WILL WE SEND PARAMETERS? AS DATA OR AS COMMAND?
    mov R2,#0x28
	BL LCD_DATA_WRITE


	;COLMOD: PIXEL FORMAT SET | DATASHEET PAGE 134
	;THIS COMMAND LETS US CHOOSE WHETHER WE WANT TO USE 16-BIT COLORS OR 18-BIT COLORS.
	;WE WILL ALWAYS USE 16-BIT COLORS
	;TODO: ISSUE THE COMMAND COLMOD
	mov R2,#0x3A
	BL LCD_COMMAND_WRITE

	;TODO: SEND THE NEEDED PARAMETER WHICH CORRESPONDS TO 16-BIT RGB AND 16-BIT MCU INTERFACE FORMAT
	mov R2,#0x55
	BL LCD_DATA_WRITE
	
	
	;SLEEP OUT | DATASHEET PAGE 101
	;TODO: ISSUE THE SLEEP OUT COMMAND TO EXIT SLEEP MODE (THIS COMMAND TAKES NO PARAMETERS, JUST SEND THE COMMAND)
	mov R2,#0x11
	BL LCD_COMMAND_WRITE

	;NECESSARY TO WAIT 5ms BEFORE SENDING NEXT COMMAND
	;I WILL WAIT FOR 10MSEC TO BE SURE
	;TODO: DELAY FOR AT LEAST 10ms
	BL delay_10_milli_second


	;DISPLAY ON | DATASHEET PAGE 109
	;TODO: ISSUE THE COMMAND, IT TAKES NO PARAMETERS
    mov R2,#0x29
	BL LCD_COMMAND_WRITE	


	;COLOR INVERSION OFF | DATASHEET PAGE 105
	;NOTE: SOME TFTs HAS COLOR INVERTED BY DEFAULT, SO YOU WOULD HAVE TO INVERT THE COLOR MANUALLY SO COLORS APPEAR NATURAL
	;MEANING THAT IF THE COLORS ARE INVERTED WHILE YOU ALREADY TURNED OFF INVERSION, YOU HAVE TO TURN ON INVERSION NOT TURN IT OFF.
	;TODO: ISSUE THE COMMAND, IT TAKES NO PARAMETERS
	mov R2,#0x20
	BL LCD_COMMAND_WRITE



	;MEMORY WRITE | DATASHEET PAGE 245
	;WE NEED TO PREPARE OUR TFT TO SEND PIXEL DATA, MEMORY WRITE SHOULD ALWAYS BE ISSUED BEFORE ANY PIXEL DATA SENT
	;TODO: ISSUE MEMORY WRITE COMMAND
	mov R2,#0x2C
	BL LCD_COMMAND_WRITE


	;TODO: POP ALL PUSHED REGISTERS
	
	POP{R0-R12,PC}
;#####################################################################################################################################################################






; REVISE THE FUNCTION LCD_INIT WITH YOUR TA BEFORE PROCEEDING






;#####################################################################################################################################################################
ADDRESS_SET
	;THIS FUNCTION TAKES X1, X2, Y1, Y2
	;IT ISSUES COLUMN ADDRESS SET TO SPECIFY THE START AND END COLUMNS (X1 AND X2)
	;IT ISSUES PAGE ADDRESS SET TO SPECIFY THE START AND END PAGE (Y1 AND Y2)
	;THIS FUNCTION JUST MARKS THE PLAYGROUND WHERE WE WILL ACTUALLY DRAW OUR PIXELS, MAYBE TARGETTING EACH PIXEL AS IT IS.
	;R0 = X1
	;R1 = X2
	;R3 = Y1
	;R4 = Y2

	;PUSHING ANY NEEDED REGISTERS
	PUSH {R0-R4, LR}
	

	;COLUMN ADDRESS SET | DATASHEET PAGE 110
	MOV R2, #0x2A
	BL LCD_COMMAND_WRITE

	;TODO: SEND THE FIRST PARAMETER (HIGHER 8-BITS OF THE STARTING COLUMN, AKA HIGHER 8-BITS OF X1)
	MOV R2,R0,LSR#8
	BL LCD_DATA_WRITE

	;TODO: SEND THE SECOND PARAMETER (LOWER 8-BITS OF THE STARTING COLUMN, AKA LOWER 8-BITS OF X1)
	MOV R2,R0
	BL LCD_DATA_WRITE


	;TODO: SEND THE THIRD PARAMETER (HIGHER 8-BITS OF THE ENDING COLUMN, AKA HIGHER 8-BITS OF X2)
	MOV R2,R1,LSR#8
	BL LCD_DATA_WRITE


	;TODO: SEND THE FOURTH PARAMETER (LOWER 8-BITS OF THE ENDING COLUMN, AKA LOWER 8-BITS OF X2)
	MOV R2,R1
	BL LCD_DATA_WRITE



	;PAGE ADDRESS SET | DATASHEET PAGE 110
	MOV R2, #0x2B
	BL LCD_COMMAND_WRITE

	;TODO: SEND THE FIRST PARAMETER (HIGHER 8-BITS OF THE STARTING PAGE, AKA HIGHER 8-BITS OF Y1)
	MOV R2,R3,LSL#8
	BL LCD_DATA_WRITE

	;TODO: SEND THE SECOND PARAMETER (LOWER 8-BITS OF THE STARTING PAGE, AKA LOWER 8-BITS OF Y1)
	MOV R2,R3
	BL LCD_DATA_WRITE


	;TODO: SEND THE THIRD PARAMETER (HIGHER 8-BITS OF THE ENDING PAGE, AKA HIGHER 8-BITS OF Y2)
	MOV R2,R4,LSL#8
	BL LCD_DATA_WRITE

	;TODO: SEND THE FOURTH PARAMETER (LOWER 8-BITS OF THE ENDING PAGE, AKA LOWER 8-BITS OF Y2)
	MOV R2,R4
	BL LCD_DATA_WRITE
	

	;MEMORY WRITE
	MOV R2, #0x2C
	BL LCD_COMMAND_WRITE


	;POPPING ALL REGISTERS I PUSHED
	POP {R0-R4, PC}
;#####################################################################################################################################################################
	LTORG


;#####################################################################################################################################################################
DRAWPIXEL
	PUSH {R0-R4, r10, LR}
	;THIS FUNCTION TAKES X AND Y AND A COLOR AND DRAWS THIS EXACT PIXEL
	;NOTE YOU HAVE TO CALL ADDRESS SET ON A SPECIFIC PIXEL WITH LENGTH 1 AND WIDTH 1 FROM THE STARTING COORDINATES OF THE PIXEL, THOSE STARTING COORDINATES ARE GIVEN AS PARAMETERS
	;THEN YOU SIMPLY ISSUE MEMORY WRITE COMMAND AND SEND THE COLOR
	;R0 = X
	;R1 = Y
	;R10 = COLOR

	;CHIP SELECT ACTIVE, WRITE LOW TO CS
	LDR r3, =GPIOB_ODR
	LDR r4, [r3]
	AND r4, r4, #0xFFFF7FFF
	STR r4, [r3]

	;TODO: SETTING PARAMETERS FOR FUNC 'ADDRESS_SET' CALL, THEN CALL FUNCTION ADDRESS SET
	;NOTE YOU MIGHT WANT TO PERFORM PARAMETER REORDERING, AS ADDRESS SET FUNCTION TAKES X1, X2, Y1, Y2 IN R0, R1, R3, R4 BUT THIS FUNCTION TAKES X,Y IN R0 AND R1
	
	;R0 = X1
	;R1 = X2
	;R3 = Y1
	;R4 = Y2
	
	mov r5,r1
    add r1,r0,#1 ;R0=X1, R1=R0+1
	MOV R3,R5
	add R4,R3,#1 ;R3=Y1,R4=Y1+1
	
	BL ADDRESS_SET
	


	
	;MEMORY WRITE
	MOV R2, #0x2C
	BL LCD_COMMAND_WRITE


	;SEND THE COLOR DATA | DATASHEET PAGE 114
	;HINT: WE SEND THE HIGHER 8-BITS OF THE COLOR FIRST, THEN THE LOWER 8-BITS
	;HINT: WE SEND THE COLOR OF ONLY 1 PIXEL BY 2 DATA WRITES, THE FIRST TO SEND THE HIGHER 8-BITS OF THE COLOR, THE SECOND TO SEND THE LOWER 8-BITS OF THE COLOR
	;REMINDER: WE USE 16-BIT PER PIXEL COLOR
	;TODO: SEND THE SINGLE COLOR, PASSED IN R10
	  
	MOV R2,R10,LSR #8 ;SENDING HEIGHER 8 BITS
    BL LCD_DATA_WRITE
	
	MOV R2,R10        ;SENDING LOWER  8 BITS
	BL LCD_DATA_WRITE
	
	
	POP {R0-R4, r10, PC}
;#####################################################################################################################################################################


;##########################################################################################################################################
DRAW_RECTANGLE_FILLED
	;TODO: IMPLEMENT THIS FUNCTION ENTIRELY, AND SPECIFY THE ARGUMENTS IN COMMENTS, WE DRAW A RECTANGLE BY SPECIFYING ITS TOP-LEFT AND LOWER-RIGHT POINTS, THEN FILL IT WITH THE SAME COLOR
	;X1 = [] r0
	;Y1 = [] r1
	;X2 = [] r3
	;Y2 = [] r4
	;COLOR = [] r10
	 PUSH {R0-R6, r10, LR}
	 
		MOV R6,R0
	
INNER_RECT_FILLED1

		BL DRAWPIXEL
		ADD R0,R0,#1
		CMP R0,R3
		
		BLT INNER_RECT_FILLED1
		
		MOV R0,R6
		ADD R1,R1,#1
		CMP R1,R4
		BLT INNER_RECT_FILLED1
		
	POP {R0-R6, r10, PC}

DRAW_triangle  
	;TODO: IMPLEMENT THIS FUNCTION ENTIRELY, AND SPECIFY THE ARGUMENTS IN COMMENTS, WE DRAW A TRIANGLE  BY SPECIFYING ITS TOP AND LOWER POINTS, THEN FILL IT WITH THE SAME COLOR
	;X1 = [] r0
	;Y1 = [] r1
	;X2 = [] r3
	;Y2 = [] r4
	;COLOR = [] r10
	PUSH {R0-R4, r10, LR}
	
	MOV R7, R1
	
INNER_TRIANGLE_FILLED_1
	
	  BL DRAWPIXEL
	  
	  ADD R1, R1 ,#1
	  CMP R1, R4
	  BLT INNER_TRIANGLE_FILLED_1
 
	  ADD R7,#1


	
	  ADD R0, R0 , #1
	  MOV R1, R7
	  SUB R4, #1
	  BL DRAWPIXEL
	  
	  CMP R1, R4
	  
	  BLT INNER_TRIANGLE_FILLED_1
	
	POP {R0-R4, r10, PC}
;##########################################################################################################################################


;###############################################################################################################
	LTORG
;#############################################################################################################


;#####################################################################################################################################################################
SETUP
	;THIS FUNCTION ENABLES PORT E, MARKS IT AS OUTPUT, CONFIGURES SOME GPIO
	;THEN FINALLY IT CALLS LCD_INIT (HINT, USE THIS SETUP FUNCTION DIRECTLY IN THE MAIN)
	PUSH {R0-R12, LR}

	;Make the clock affect port B by enabling the corresponding bit (the third bit) in RCC_AHB1ENR register
	LDR R0, =RCC_APB2ENR         ; Address of RCC_APB2ENR register
    LDR R1, [R0]                 ; Read the current value of RCC_APB2ENR
	MOV R2, #3
    ORR R1, R1, R2, LSL #2        ; Set bit 2 and 3 to enable GPIOA&B clock
    STR R1, [R0]                 ; Write the updated value back to RCC_APB2ENR
	
	
	;Make the GPIOA PINS 0->7 mode as output (0001 for each pin)
	LDR r0, =GPIOA_CRL
	mov r1, #0x33333333
	STR r1, [r0]
	;Make the GPIOB PINS 8->15 mode as output (0001 for each pin)
	LDR r0, =GPIOB_CRH
	mov r1, #0x33333333
	STR r1, [r0]
	
	

	BL LCD_INIT

	POP {R0-R12, PC}
;#####################################################################################################################################################################
	LTORG
;####################################################################################################
DRAW_SNAKE  FUNCTION
	PUSH {R0-R12, LR}
;	BL INITIALZE_SNAKE_COORDINATES
    LDR  R5,=SNAKE_X
	LDR R6, =SNAKE_Y	
	LDR R9,=LENGTH
	LDRB R9,[R9]
	LDR R10,=BLUE
LOOP2
;MOV IN R0 FIRST X AND EXACTLY THE SAME IN Y
	LDRH R0,[R5]
	LDRH R1,[R6]
    ADD R3, R0, #40
	ADD R4, R1, #40
	
   
   BL DRAW_RECTANGLE_FILLED
    
    ADD R5,R5,#2 ; ADD TWO TO GET THE NEXT HALF WORD
	ADD R6,R6,#2
	SUB R9,R9,#1
	CMP R9,#0
	BGT LOOP2


EXITDRAW	
	MOV R3,#1  
	POP {R0-R12, PC}
    ENDFUNC
	
		
DRAW_GOOD_APPLE1  FUNCTION
	PUSH {R0-R12, LR}
;FIRST APPLE
	LDR R5,=GOOD_APPLE1_X
	LDR R6,=GOOD_APPLE1_Y
	MOV R0,#40
	MOV R1,#20
	ADD R3,R0,#10
	ADD R4,R1,#10
	LDR R10,=RED
	STRH R0,[R5] 
	STRH R1,[R6]
    BL DRAW_RECTANGLE_FILLED
		
	
	MOV R3,#1  
	POP {R0-R12, PC}
	ENDFUNC
;SECOND APPLE	
DRAW_GOOD_APPLE2  FUNCTION
	PUSH {R0-R12, LR}
	LDR R5,=GOOD_APPLE2_X
	LDR R6,=GOOD_APPLE2_Y
	MOV R0,#80
	MOV R1,#80
	ADD R3,R0,#10
	ADD R4,R1,#10
	LDR R10,=RED
	STRH R0,[R5] 
	STRH R1,[R6]
    BL DRAW_RECTANGLE_FILLED
		
	
	MOV R3,#1  
	POP {R0-R12, PC}
	ENDFUNC
DRAW_GOOD_APPLE3  FUNCTION	
;THIRD APPLE	
	PUSH {R0-R12, LR}
	LDR R5,=GOOD_APPLE3_X
	LDR R6,=GOOD_APPLE3_Y
	MOV R0,#60
	MOV R1,#40
	ADD R3,R0,#10
	ADD R4,R1,#10
	LDR R10,=RED
	STRH R0,[R5] 
	STRH R1,[R6]
    BL DRAW_RECTANGLE_FILLED
		
	
	MOV R3,#1  
	POP {R0-R12, PC}
	ENDFUNC
DRAW_GOOD_APPLE4  FUNCTION	
;FOURTH APPLE	
	PUSH {R0-R12, LR}
	LDR R5,=GOOD_APPLE4_X
	LDR R6,=GOOD_APPLE4_Y
	MOV R0,#300
	MOV R1,#200
	ADD R3,R0,#10
	ADD R4,R1,#10
	LDR R10,=RED
	STRH R0,[R5] 
	STRH R1,[R6]
    BL DRAW_RECTANGLE_FILLED
	
		
	
	MOV R3,#1  
	POP {R0-R12, PC}
	ENDFUNC
	
DRAW_GOOD_APPLE5  FUNCTION	
;FIFTH APPLE	
	PUSH {R0-R12, LR}
	LDR R5,=GOOD_APPLE5_X
	LDR R6,=GOOD_APPLE5_Y
	MOV R0,#160
	MOV R1,#200
	ADD R3,R0,#10
	ADD R4,R1,#10
	LDR R10,=RED
	STRH R0,[R5] 
	STRH R1,[R6]
    BL DRAW_RECTANGLE_FILLED
	
	MOV R3,#1  
	POP {R0-R12, PC}
	ENDFUNC
	;DRAW POISONED APPLE
DRAW_POISONED_APPLE			FUNCTION
	PUSH {R0-R12, LR}
	LDR R0,=SNAKE_X
	LDR	R1,=SNAKE_Y
	LDR R5,=BAD_APPLE_X
	LDR R6,=BAD_APPLE_Y
	LDRH R0,[R0]
	LDRH R1,[R1]
	ADD R0,R0,#80
	ADD R1,R1,#80
	ADD R3,R0,#10
	ADD R4,R1,#10
	LDR R10,=MAGENTA
	STRH R0,[R5]
	STRH R1,[R6]
	  BL DRAW_RECTANGLE_FILLED
	MOV R3,#1  
	POP {R0-R12, PC}
		ENDFUNC
	
	
	

DRAW_BG_SNAKE FUNCTION
	PUSH {R0-R12, LR}

	MOV R0,#0
	MOV R1,#0
	MOV R3,#320
	MOV R4,#240
	LDR R10,=GREEN
    BL DRAW_RECTANGLE_FILLED
    MOV R3,#1  
	POP {R0-R12, PC}
	ENDFUNC
DRAW_SNAKE_GAME FUNCTION
	PUSH {R0-R12, LR}	
	BL MOVE_SNAKE
	BL delay_1_second
	LDR R0,=DIRECTION
	LDRB R0,[R0]
	CMP R0,#0
	BEQ MOVERIGHT
	CMP R0,#1
	BEQ MOVELEFT
	CMP R0,#2
	BEQ MOVEUP
	CMP R0,#3
	BEQ MOVEDOWN
	
	;BL SNAKE_GAME_CONDITION
MOVERIGHT BL MOVE_SNAKE_RIGHT 
	B EXIT_MOVE1
MOVELEFT BL MOVE_SNAKE_LEFT 
	B EXIT_MOVE1
MOVEUP BL MOVE_SNAKE_UP 
	B EXIT_MOVE1
MOVEDOWN BL MOVE_SNAKE_DOWN 	
	
EXIT_MOVE1	
	;BL EATUP
	BL SNAKE_EAT 
	BL SNAKE_GAME_CONDITION
	MOV R3,#1  
	POP {R0-R12, PC}
	ENDFUNC

;#################################################################################################

	LTORG
	
INITIALZE_SNAKE_COORDINATES	 FUNCTION
	PUSH {R0-R5, LR}
	;R0 = SX, R1 = SY
	LDR R0,=SNAKE_X
	LDR R1,=SNAKE_Y

	;USE R5 AS THE DATA REGISTER

	LDR R5,=0x8C  
	STRH R5,[R0]
	ADD R0,R0,#2

	LDR R5,=0x50
	STRH R5,[R1]
	ADD R1,R1,#2

	LDR R5,=0x8c
	STRH R5,[R0]
	LDR R5,=0x78
	STRH R5,[R1]
	ADD R0,R0,#2
	ADD R1,R1,#2	
;#######################################################
;	
;	LDR R5,=0x8c
;	STRH R5,[R0]
;	LDR R5,=0xA0
;	STRH R5,[R1]
;	ADD R0,R0,#2
;	ADD R1,R1,#2
;##########################################################################	
	LDR R5,=0x1F4
	LDR R3,=5
SNAKE_INIT_CORD_LOOP	
	STRH R5,[R0]
	STRH R5,[R1]
	ADD R0,R0,#2
	ADD R1,R1,#2
	SUB R3,R3,#1
	CMP R3,#0
	BNE SNAKE_INIT_CORD_LOOP

	LDR R0 ,=DIRECTION
	LDR R1,=2    ;orientation by default up
	STRB R1,[R0]
	LDR R0,=LENGTH
	LDR R1,=2
	STRB R1,[R0]
	MOV R3,#1  
	POP {R0-R5, PC}
	ENDFUNC
CHANGE_TO_RIGHT_DIRECTION FUNCTION	
	PUSH {R0,R1,LR}
	LDR R0,=DIRECTION
    LDR R1,=0
    STRB R1,[R0]
	MOV R3,#1  
	POP {R0,R1,PC}
	ENDFUNC
	
CHANGE_TO_LEFT_DIRECTION FUNCTION	
	PUSH {R0,R1,LR}
	LDR R0,=DIRECTION
    LDR R1,=1
    STRB R1,[R0]
	MOV R3,#1  
	POP {R0,R1,PC}
	ENDFUNC
	
CHANGE_TO_UP_DIRECTION FUNCTION
    PUSH {R0,R1,LR}
    LDR R0,=DIRECTION
    LDR R1,=2
    STRB R1,[R0]
	MOV R3,#1  
    POP {R0,R1,PC}
  ENDFUNC
CHANGE_TO_DOWN_DIRECTION FUNCTION
    PUSH {R0,R1,R3,LR}
    LDR R0,=DIRECTION
    LDR R1,=3
    STRB R1,[R0]
	MOV R3,#1  
    POP {R0,R1,R3,PC}
  ENDFUNC
	
MOVE_SNAKE FUNCTION
	PUSH {R0-R12,LR}
	BL CHECK_SW0_PRESSED
	CMP R3,#0
	BEQ RIGHT 
	
	BL CHECK_SW1_PRESSED
	CMP R3,#0
	BEQ LEFT  
	
	BL CHECK_SW2_PRESSED
	CMP R3,#0
	BEQ UP 
	
    BL CHECK_SW3_PRESSED	
	CMP R3,#0
	BEQ DOWN
	
	 B EXIT_MOVE
RIGHT
	LDR R0,=DIRECTION
	LDRB R0,[R0]
	CMP R0,#1
	BEQ EXIT_MOVE
	BL CHANGE_TO_RIGHT_DIRECTION 
	B EXIT_MOVE
LEFT 
	LDR R0,=DIRECTION
	LDRB R0,[R0]
	CMP R0,#0
	BEQ EXIT_MOVE
	BL CHANGE_TO_LEFT_DIRECTION 
	B EXIT_MOVE
UP 
	LDR R0,=DIRECTION
	LDRB R0,[R0]
	CMP R0,#3
	BEQ EXIT_MOVE
	BL CHANGE_TO_UP_DIRECTION 
	B EXIT_MOVE
DOWN 
	LDR R0,=DIRECTION
	LDRB R0,[R0]
	CMP R0,#2
	BEQ EXIT_MOVE
	BL CHANGE_TO_DOWN_DIRECTION 

EXIT_MOVE
	MOV R3,#1  
	POP {R0-R12, PC}
	ENDFUNC

MOVE_SNAKE_LEFT	FUNCTION
		PUSH {R0-R9, LR}
		
		LDR R0,=DIRECTION
		LDRB R0,[R0]
		CMP R0,#0
		BEQ MOVE_LEFT_END
		LDR R6,=LENGTH
		LDRB R6,[R6]
		SUB R6,R6,#1
		LDR R7,=2
		MUL R6,R6,R7
		LDR R7,=SNAKE_X
		LDR R8,=SNAKE_Y
		ADD R7,R7,R6
		ADD R8,R8,R6
		LDRH R0,[R7]
		LDRH R1,[R8]
	    ADD R3,R0,#40
	    ADD R4,R1,#40
	    LDR R10,=GREEN
		BL DRAW_RECTANGLE_FILLED	
		LDR R6,=LENGTH
		LDRB R6,[R6]
		
		SUB R6,R6,#1
WHILELOOP	
		SUB R0,R7,#2
		SUB R1,R8,#2		
		LDRH R0,[R0]
		LDRH R1,[R1]
		STRH R0,[R7]
		STRH R1,[R8]
		SUB R7,R7,#2
		SUB R8,R8,#2
		SUB R6,R6,#1
		CMP R6,#0
		BNE WHILELOOP
		;Hena tefre2 3laa 7asab left wala right wala up wala down
		LDR R0,=SNAKE_X
		LDRH R1,[R0]
		SUB R1,R1,#40
		STRH R1,[R0]
		BL DRAW_SNAKE
		CMP R1,#0
		BLE DUMMYLABEL
		
		;hena tfr2 3ala 7asab bardo nfs el 7aga
		
		
MOVE_LEFT_END
		;BL MOVE_SNAKE
		
		;BL MOVE_SNAKE_LEFT
		MOV R3,#1  
		POP {R0-R9, PC}
		ENDFUNC
	
	
MOVE_SNAKE_RIGHT FUNCTION
		PUSH {R0-R12, LR}
		LDR R0,=DIRECTION
		LDRB R0,[R0]
		CMP R0,#1
		BEQ MOVE_RIGHT_END
		LDR R6,=LENGTH
		LDRB R6,[R6]
		SUB R6,R6,#1
		LDR R7,=2
		MUL R6,R6,R7
		LDR R7,=SNAKE_X
		LDR R8,=SNAKE_Y
		ADD R7,R7,R6
		ADD R8,R8,R6
		LDRH R0,[R7]
		LDRH R1,[R8]
	    ADD R3,R0,#40
	    ADD R4,R1,#40
	    LDR R10,=GREEN
		BL DRAW_RECTANGLE_FILLED	
		LDR R6,=LENGTH
		LDRB R6,[R6]
		
		SUB R6,R6,#1
WHILELOOPRIGHT	
		SUB R0,R7,#2
		SUB R1,R8,#2		
		LDRH R0,[R0]
		LDRH R1,[R1]
		STRH R0,[R7]
		STRH R1,[R8]
		SUB R7,R7,#2
		SUB R8,R8,#2
		SUB R6,R6,#1
		CMP R6,#0
		BNE WHILELOOPRIGHT
		;Hena tefre2 3laa 7asab left wala right wala up wala down
		LDR R0,=SNAKE_X
		LDRH R1,[R0]
		ADD R1,R1,#40
		STRH R1,[R0]
		BL DRAW_SNAKE
		LDR R0,=SNAKE_X
		LDRH R1,[R0]
		CMP R1,#280
		BGE DUMMYLABEL		
MOVE_RIGHT_END
		;BL MOVE_SNAKE
		;BL MOVE_SNAKE_RIGHT
		MOV R3,#1  
		POP {R0-R12, PC}
	    ENDFUNC
		
		
DUMMYLABEL
	BL SNAKE_GAME_OVER
		
MOVE_SNAKE_UP	FUNCTION
		PUSH {R0-R12, LR}
		LDR R0,=DIRECTION
		LDRB R0,[R0]
		CMP R0,#3
		BEQ MOVE_UP_END
		LDR R6,=LENGTH
		LDRB R6,[R6]
		SUB R6,R6,#1
		LDR R7,=2
		MUL R6,R6,R7
		LDR R7,=SNAKE_X
		LDR R8,=SNAKE_Y
		ADD R7,R7,R6
		ADD R8,R8,R6
		LDRH R0,[R7]
		LDRH R1,[R8]
	    ADD R3,R0,#40
	    ADD R4,R1,#40
		LDR R10,=GREEN
		BL DRAW_RECTANGLE_FILLED	
		LDR R6,=LENGTH
		LDRB R6,[R6]
		
		SUB R6,R6,#1
WHILELOOPUP	
		SUB R0,R7,#2
		SUB R1,R8,#2		
		LDRH R0,[R0]
		LDRH R1,[R1]
		STRH R0,[R7]
		STRH R1,[R8]
		SUB R7,R7,#2
		SUB R8,R8,#2
		SUB R6,R6,#1
		CMP R6,#0
		BNE WHILELOOPUP
		;Hena tefre2 3laa 7asab left wala right wala up wala down
		LDR R0,=SNAKE_Y
		LDRH R1,[R0]
		SUB R1,R1,#40
		STRH R1,[R0] 
		BL DRAW_SNAKE
		LDR R0,=SNAKE_Y
		LDRH R1,[R0]
		CMP R1,#0
		BEQ DUMMYLABEL		
MOVE_UP_END
		;BL MOVE_SNAKE
		;BL MOVE_SNAKE_UP
		MOV R3,#1  
		POP {R0-R12, PC}
	ENDFUNC	
	LTORG
;###########################################################################################################################################
MOVE_SNAKE_DOWN	FUNCTION
		PUSH {R0-R12, LR}
		LDR R0,=DIRECTION
		LDRB R0,[R0]
		CMP R0,#2
		BEQ MOVE_DOWN_END
		LDR R6,=LENGTH
		LDRB R6,[R6]
		SUB R6,R6,#1
		LDR R7,=2
		MUL R6,R6,R7
		LDR R7,=SNAKE_X
		LDR R8,=SNAKE_Y
		ADD R7,R7,R6
		ADD R8,R8,R6
		LDRH R0,[R7]
		LDRH R1,[R8]
	    ADD R3,R0,#40
	    ADD R4,R1,#40
	    LDR R10,=GREEN
		BL DRAW_RECTANGLE_FILLED	
		LDR R6,=LENGTH
		LDRB R6,[R6]
		
		SUB R6,R6,#1
WHILELOOPDOWN	
		SUB R0,R7,#2
		SUB R1,R8,#2		
		LDRH R0,[R0]
		LDRH R1,[R1]
		STRH R0,[R7]
		STRH R1,[R8]
		SUB R7,R7,#2
		SUB R8,R8,#2
		SUB R6,R6,#1
		CMP R6,#0
		BNE WHILELOOPDOWN
		;Hena tefre2 3laa 7asab left wala right wala up wala down
		LDR R0,=SNAKE_Y
		LDRH R1,[R0]      ;NEW Y
		ADD R1,R1,#40
		STRH R1,[R0]
		BL DRAW_SNAKE
		CMP R1,#200
		BEQ DUMMYLABEL
		
		
		
MOVE_DOWN_END
		;BL MOVE_SNAKE
		;BL MOVE_SNAKE_DOWN
		MOV R3,#1  
		POP {R0-R12, PC}
	ENDFUNC	
	LTORG
	
	
	
	
SNAKE_GAME_CONDITION FUNCTION
	PUSH {R0-R12, LR}
	LDR R4,=LENGTH ;LOAD LENGTH OF SNAKE
	LDRB R4,[R4]
	LDR R5,=SNAKE_X
	LDR R6,=SNAKE_Y
	LDRH R0,[R5]
	LDRH R1,[R6]
CONDITION_LOOP
	SUB R4,R4,#1     ;DECREASE LENGTH TO KNOW THE REMAINING NO OF ITERATIONS
	CMP R4,#0
	BEQ EXIT_LOOP
	ADD R5,R5,#2
	ADD R6,R6,#2
	LDRH R7,[R5]     ;LOAD NEXT X POSITION
	LDRH R8,[R6]     ;LOAD NEXT Y POSITION
	
	CMP R0,R7        ;CHECK IF HEAD_X EQUALS ANY X    
	BNE CONDITION_LOOP
	
	CMP R1,R8             ;CHECK IF HEAD_Y EQUALS THE Y OF THE ABOVE X
	BNE CONDITION_LOOP
	BL SNAKE_GAME_OVER	
EXIT_LOOP
	MOV R3,#1
	POP {R0-R12, PC}
	ENDFUNC
	LTORG
;#####################################################################################################################################################################	


SNAKE_EAT   FUNCTION
	PUSH {R0-R12, LR}
	
	LDR R7,=DIRECTION	
	LDRB R7,[R7]
	CMP R7,#0 
	BEQ RIGHTORIENTATION
	CMP R7,#1
	BEQ LEFTORIENTATION
	CMP R7,#2
	BEQ UPORIENTATION
	CMP R7,#3
	BEQ DOWNORIENTATION
	
	
	
UPORIENTATION BL EATUP

DOWNORIENTATION BL EATDOWN

LEFTORIENTATION BL EATLEFT

RIGHTORIENTATION 
;BL EATRIGHT
	MOV R3,#1
	POP {R0-R12, PC}
	ENDFUNC
;#####################################################################################################################################################################

; EAT UP AND GROW
EATUP  FUNCTION 
	PUSH {R0-R12,LR}
	LDR R0,=SNAKE_X
	LDR R1,=SNAKE_Y
	LDRH R0,[R0]
	LDRH R1,[R1]
	;CHECK FIRST APPLE 
	LDR R5,=GOOD_APPLE1_X
	LDR R6,=GOOD_APPLE1_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	ADD R5,R5,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R5,R0
	BLE CHECKAPPLE2
	ADD R8,R0,#40         ;GET X2 OF SNAKE
	CMP R5,R8
	BGE CHECKAPPLE2
	ADD R6,R6,#10 ;;CHECK Y
	CMP R6,R1
	BLT CHECKAPPLE2
	ADD R1,R1,#40
	CMP R6,R1
	BLE TEMPGROWUP
	
	
CHECKAPPLE2	
	LDR R5,=GOOD_APPLE2_X
	LDR R6,=GOOD_APPLE2_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	ADD R5,R5,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R5,R0
	BLE CHECKAPPLE3
	ADD R8,R0,#40         ;GET X2 OF SNAKE
	CMP R5,R8
	BGE CHECKAPPLE3
	ADD R6,R6,#10 ;;CHECK Y
	CMP R6,R1
	BLT CHECKAPPLE3
	ADD R1,R1,#40
	CMP R6,R1
	BLE TEMPGROWUP
	
	
CHECKAPPLE3	

	LDR R5,=GOOD_APPLE3_X
	LDR R6,=GOOD_APPLE3_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	ADD R5,R5,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R5,R0
	BLE CHECKAPPLE4
	ADD R8,R0,#40         ;GET X2 OF SNAKE
	CMP R5,R8
	BGE CHECKAPPLE4
	ADD R6,R6,#10 ;;CHECK Y
	CMP R6,R1
	BLT CHECKAPPLE4
	ADD R1,R1,#40
	CMP R6,R1
	BLE TEMPGROWUP
	
CHECKAPPLE4	

	LDR R5,=GOOD_APPLE4_X
	LDR R6,=GOOD_APPLE4_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	ADD R5,R5,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R5,R0
	BLE CHECKAPPLE5
	ADD R8,R0,#40         ;GET X2 OF SNAKE
	CMP R5,R8
	BGE CHECKAPPLE5
	ADD R6,R6,#10 ;;CHECK Y
	CMP R6,R1
	BLT CHECKAPPLE5
	ADD R1,R1,#40
	CMP R6,R1
	BLE TEMPGROWUP
	
	
	
CHECKAPPLE5	

	LDR R5,=GOOD_APPLE5_X
	LDR R6,=GOOD_APPLE5_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	ADD R5,R5,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R5,R0
	BLE CHECKPOISONUP
	ADD R8,R0,#40         ;GET X2 OF SNAKE
	CMP R5,R8
	BGE CHECKPOISONUP
	ADD R6,R6,#10 ;;CHECK Y
	CMP R6,R1
	BLT CHECKPOISONUP
	ADD R1,R1,#40
	CMP R6,R1
	BLE TEMPGROWUP
	
CHECKPOISONUP	
	LDR R5,=BAD_APPLE_X
	LDR R6,=BAD_APPLE_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	ADD R5,R5,#5
	CMP R5,R0
	BLE EXITEATUP
	ADD R8,R0,#40         ;GET X2 OF SNAKE
	CMP R5,R8
	BGE EXITEATUP
	ADD R6,R6,#10
	CMP R6,R1
	BLT CHECKPOISONUP
	ADD R1,R1,#40
	CMP R6,R1
	BLE DUMMYLABEL
	
EXITEATUP
	MOV R3,#1
	POP {R0-R12,PC}
	ENDFUNC
	
	
TEMPGROWUP 
	PUSH {R0-R12,LR} 
	LDR R0,=EATENAPPLES
	LDRB R1,[R0]
	ADD R1,R1,#1
	STRB R1,[R0]
	BL GROW_UP	
	POP {R0-R12,PC}

;####################################################################################################################
GROW_UP	FUNCTION
		PUSH {R0-R12, LR}
		
		LDR R6,=LENGTH     ;LOAD LENGTH OF SNAKE
		LDRB R6,[R6]
		SUB R6,R6,#1
		LDR R7,=2
		MUL R6,R6,R7         
		LDR R7,=SNAKE_X
		LDR R8,=SNAKE_Y
		ADD R7,R7,R6                   ;TO GET THE LAST VALID ELEMENT IN THE ARRAY
		ADD R8,R8,R6
		LDRH R1,[R7]
		LDRH R0,[R8]    
	    ADD R3,R0,#40          
		ADD R7,R7,#2
		ADD R8,R8,#2
		STRH R3,[R8]				 ;SUB 40  AND STORE IT IN THE NEXT LOCATION
		STRH R1,[R7]				; STORE THE SAME X AS THIS GROWS DOWNWARDS
		LDR R6,=LENGTH
		ldrb r7,[r6]
		add r7,r7,#1             ;INCREMENT THE LENGTH AND STORE IT
		strb r7,[r6]
		CMP R7,#7               ;WIN IF THE SNAKE'S LENGTH IS 15 BOX
		BEQ WIN
		LDR R0,=SNAKE_Y
		LDRH R1,[R0]
		BL DRAW_SNAKE
		LDR R0,=SNAKE_Y
		LDRH R1,[R0]
		CMP R1,#0
		BEQ DUMMYLABEL		
		
		MOV R3,#1  
		POP {R0-R12, PC}
		ENDFUNC	

WIN BL WINSNAKE
	;EAT DOWN AND GROW
	
EATDOWN  FUNCTION 
	PUSH{R0-R12,LR}
	LDR R0,=SNAKE_X
	LDR R1,=SNAKE_Y
	LDRH R0,[R0]
	LDRH R1,[R1]
	;CHECK FIRST APPLE 
	LDR R5,=GOOD_APPLE1_X
	LDR R6,=GOOD_APPLE1_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	;CHECK X
	ADD R5,R5,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R5,R0
	BLE CHECKAPPLE2DOWN
	ADD R8,R0,#40         ;GET X2 OF SNAKE
	CMP R5,R8
	BGE CHECKAPPLE2DOWN
	;CHECK Y
	ADD R1,R1,#40
	CMP R6,R1
	BGT CHECKAPPLE2DOWN
	SUB R1,R1,#40
	CMP R6,R1
	BGE TEMPGROWDOWN
	
	
	
	
	
CHECKAPPLE2DOWN	
	LDR R5,=GOOD_APPLE2_X
	LDR R6,=GOOD_APPLE2_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	;CHECK X
	ADD R5,R5,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R5,R0
	BLE CHECKAPPLE3DOWN
	ADD R8,R0,#40         ;GET X2 OF SNAKE
	CMP R5,R8
	BGE CHECKAPPLE3DOWN
	;CHECK Y
	ADD R1,R1,#40
	CMP R6,R1
	BGT CHECKAPPLE3DOWN
	SUB R1,R1,#40
	CMP R6,R1
	BGE TEMPGROWDOWN
	
CHECKAPPLE3DOWN	

	LDR R5,=GOOD_APPLE3_X
	LDR R6,=GOOD_APPLE3_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	;CHECK X
	ADD R5,R5,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R5,R0
	BLE CHECKAPPLE4DOWN
	ADD R8,R0,#40         ;GET X2 OF SNAKE
	CMP R5,R8
	BGE CHECKAPPLE4DOWN
	;CHECK Y
	ADD R1,R1,#40
	CMP R6,R1
	BGT CHECKAPPLE4DOWN
	SUB R1,R1,#40
	CMP R6,R1
	BGE TEMPGROWDOWN
	
CHECKAPPLE4DOWN	

	LDR R5,=GOOD_APPLE4_X
	LDR R6,=GOOD_APPLE4_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	;CHECK X
	ADD R5,R5,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R5,R0
	BLE CHECKAPPLE5DOWN
	ADD R8,R0,#40         ;GET X2 OF SNAKE
	CMP R5,R8
	BGE CHECKAPPLE5DOWN
	;CHECK Y
	ADD R1,R1,#40
	CMP R6,R1
	BGT CHECKAPPLE5DOWN
	SUB R1,R1,#40
	CMP R6,R1
	BGE TEMPGROWDOWN
	
	
CHECKAPPLE5DOWN	

	LDR R5,=GOOD_APPLE5_X
	LDR R6,=GOOD_APPLE5_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	;CHECK X
	ADD R5,R5,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R5,R0
	BLE CHECKPOISONDOWN
	ADD R8,R0,#40         ;GET X2 OF SNAKE
	CMP R5,R8
	BGE CHECKPOISONDOWN
	;CHECK Y
	ADD R1,R1,#40
	CMP R6,R1
	BGT CHECKPOISONDOWN
	SUB R1,R1,#40
	CMP R6,R1
	BGE TEMPGROWDOWN
	
	
CHECKPOISONDOWN	
	LDR R5,=BAD_APPLE_X
	LDR R6,=BAD_APPLE_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	;CHECK X
	ADD R5,R5,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R5,R0
	BLE EXITEATDOWN
	ADD R8,R0,#40         ;GET X2 OF SNAKE
	CMP R5,R8
	BGE EXITEATDOWN
	;CHECK Y
	ADD R1,R1,#40
	CMP R6,R1
	BGT EXITEATDOWN
	SUB R1,R1,#40
	CMP R6,R1
	BGE TEMPGROWDOWN
	
	
EXITEATDOWN
	MOV R3,#1
	POP {R0-R12,PC}
	ENDFUNC
	
	
TEMPGROWDOWN 
	PUSH {R0-R12,LR} 
	LDR R0,=EATENAPPLES
	LDRB R1,[R0]
	ADD R1,R1,#1
	STRB R1,[R0]
	BL GROW_DOWN	
	POP {R0-R12,PC}
	LTORG
GROW_DOWN	FUNCTION
		PUSH {R0-R12, LR}
		
		LDR R6,=LENGTH     ;LOAD LENGTH OF SNAKE
		LDRB R6,[R6]
		SUB R6,R6,#1
		LDR R7,=2
		MUL R6,R6,R7         
		LDR R7,=SNAKE_X
		LDR R8,=SNAKE_Y
		ADD R7,R7,R6                   ;TO GET THE LAST VALID ELEMENT IN THE ARRAY
		ADD R8,R8,R6
		LDRH R1,[R7]
		LDRH R0,[R8]    
	    SUB R3,R0,#40          
		ADD R7,R7,#2
		ADD R8,R8,#2
		STRH R3,[R8]				 ;SUB 40  AND STORE IT IN THE NEXT LOCATION
		STRH R1,[R7]				; STORE THE SAME X AS THIS GROWS DOWNWARDS
		LDR R6,=LENGTH
		ldrb r7,[r6]
		add r7,r7,#1             ;INCREMENT THE LENGTH AND STORE IT
		strb r7,[r6]
		CMP R7,#7              ;WIN IF THE SNAKE'S LENGTH IS 15 BOX
		BEQ WIN
		LDR R0,=SNAKE_Y
		LDRH R1,[R0]
		BL DRAW_SNAKE
		LDR R0,=SNAKE_Y
		LDRH R1,[R0]
		CMP R1,#200
		BEQ DUMMYLABEL		
		
		MOV R3,#1  
		POP {R0-R12, PC}
		ENDFUNC	
		

	;EAT LEFT AND GROW
EATLEFT  FUNCTION 
	PUSH {R0-R12,LR}
	LDR R0,=SNAKE_X
	LDR R1,=SNAKE_Y
	LDRH R0,[R0]
	LDRH R1,[R1]
	;CHECK FIRST APPLE 
	LDR R5,=GOOD_APPLE1_X
	LDR R6,=GOOD_APPLE1_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	ADD R6,R6,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R6,R1
	;CHECK Y
	BLE CHECKAPPLE2LEFT
	ADD R8,R1,#40         
	CMP R6,R8
	BGE CHECKAPPLE2LEFT
	;CHECK X
	ADD R5,R5,#10              
	CMP R5,R0
	BLT CHECKAPPLE2LEFT
	ADD R0,R0,#40
	CMP R5,R0
	BLE TEMPGROWLEFT
	
CHECKAPPLE2LEFT	
	LDR R5,=GOOD_APPLE2_X
	LDR R6,=GOOD_APPLE2_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	ADD R6,R6,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R6,R1
	;CHECK Y
	BLE CHECKAPPLE3LEFT
	ADD R8,R1,#40         
	CMP R6,R8
	BGE CHECKAPPLE3LEFT
	;CHECK X
	ADD R5,R5,#10              
	CMP R5,R0
	BLT CHECKAPPLE3LEFT
	ADD R0,R0,#40
	CMP R5,R0
	BLE TEMPGROWLEFT
	
CHECKAPPLE3LEFT	

	LDR R5,=GOOD_APPLE3_X
	LDR R6,=GOOD_APPLE3_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	ADD R6,R6,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R6,R1
	;CHECK Y
	BLE CHECKAPPLE4LEFT
	ADD R8,R1,#40         
	CMP R6,R8
	BGE CHECKAPPLE4LEFT
	;CHECK X
	ADD R5,R5,#10              
	CMP R5,R0
	BLT CHECKAPPLE4LEFT
	ADD R0,R0,#40
	CMP R5,R0
	BLE TEMPGROWLEFT
	
CHECKAPPLE4LEFT

	LDR R5,=GOOD_APPLE4_X
	LDR R6,=GOOD_APPLE4_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	ADD R6,R6,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R6,R1
	;CHECK Y
	BLE CHECKAPPLE5LEFT
	ADD R8,R1,#40         
	CMP R6,R8
	BGE CHECKAPPLE5LEFT
	;CHECK X
	ADD R5,R5,#10              
	CMP R5,R0
	BLT CHECKAPPLE5LEFT
	ADD R0,R0,#40
	CMP R5,R0
	BLE TEMPGROWLEFT
	
	
CHECKAPPLE5LEFT

	LDR R5,=GOOD_APPLE5_X
	LDR R6,=GOOD_APPLE5_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	ADD R6,R6,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R6,R1
	;CHECK Y
	BLE CHECKPOISONLEFT
	ADD R8,R1,#40         
	CMP R6,R8
	BGE CHECKPOISONLEFT
	;CHECK X
	ADD R5,R5,#10              
	CMP R5,R0
	BLT CHECKPOISONLEFT
	ADD R0,R0,#40
	CMP R5,R0
	BLE TEMPGROWLEFT
	
CHECKPOISONLEFT	
	LDR R5,=BAD_APPLE_X
	LDR R6,=BAD_APPLE_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	ADD R6,R6,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R6,R1
	;CHECK Y
	BLE EXITEATLEFT
	ADD R8,R1,#40         
	CMP R6,R8
	BGE EXITEATLEFT
	;CHECK X
	ADD R5,R5,#10              
	CMP R5,R0
	BLT EXITEATLEFT
	ADD R0,R0,#40
	CMP R5,R0
	BLE DUMMYLABEL
	
	
EXITEATLEFT
	MOV R3,#1
	POP {R0-R12,PC}
	ENDFUNC
	
TEMPGROWLEFT 
	PUSH {R0-R12,LR} 
	LDR R0,=EATENAPPLES
	LDRB R1,[R0]
	ADD R1,R1,#1
	STRB R1,[R0]
	BL GROW_LEFT	
	POP {R0-R12,PC}
	LTORG
	
GROW_LEFT	FUNCTION
	
	PUSH {R0-R12, LR}
	
	LDR R6,=LENGTH     ;LOAD LENGTH OF SNAKE
	LDRB R6,[R6]
	SUB R6,R6,#1
	LDR R7,=2
	MUL R6,R6,R7         
	LDR R7,=SNAKE_X
	LDR R8,=SNAKE_Y
	ADD R7,R7,R6                   ;TO GET THE LAST VALID ELEMENT IN THE ARRAY
	ADD R8,R8,R6
	LDRH R1,[R7]
	LDRH R0,[R8]    
	ADD R3,R1,#40          
	ADD R7,R7,#2
	ADD R8,R8,#2
	STRH R3,[R7]				 ;ADD 40  AND STORE IT IN THE NEXT LOCATION
	STRH R0,[R8]				; STORE THE SAME Y AS THIS GROWS DOWNWARDS
	LDR R6,=LENGTH
	ldrb r7,[r6]
	add r7,r7,#1             ;INCREMENT THE LENGTH AND STORE IT
	strb r7,[r6]
	CMP R7,#7               ;WIN IF THE SNAKE'S LENGTH IS 15 BOX
	BEQ WIN
	LDR R0,=SNAKE_X
	LDRH R1,[R0]
	BL DRAW_SNAKE
	LDR R0,=SNAKE_X
	LDRH R1,[R0]
	CMP R1,#0
	BEQ DUMMYLABEL		
	
	MOV R3,#1  
	POP {R0-R12, PC}
	ENDFUNC	
	
		
;********************************************

EATRIGHT  FUNCTION 
	PUSH{R0-R12,LR}
	LDR R0,=SNAKE_X
	LDR R1,=SNAKE_Y
	LDRH R0,[R0]
	LDRH R1,[R1]
	;CHECK FIRST APPLE 
	LDR R5,=GOOD_APPLE1_X
	LDR R6,=GOOD_APPLE1_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	;CHECK Y
	ADD R6,R6,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R6,R1
	BLE CHECKAPPLE2RIGHT
	ADD R8,R1,#40         ;GET Y2 OF SNAKE
	CMP R6,R8
	BGE CHECKAPPLE2RIGHT
	;CHECK X
	ADD R0,R0,#40             
	CMP R5,R0
	BGT CHECKAPPLE2RIGHT
	SUB R0,R0,#40
	CMP R5,R0
	BGE TEMPGROWRIGHT
	
	
CHECKAPPLE2RIGHT	
	LDR R5,=GOOD_APPLE2_X
	LDR R6,=GOOD_APPLE2_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	;CHECK Y
	ADD R6,R6,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R6,R1
	BLE CHECKAPPLE3RIGHT
	ADD R8,R1,#40         ;GET Y2 OF SNAKE
	CMP R6,R8
	BGE CHECKAPPLE3RIGHT
	;CHECK X
	ADD R0,R0,#40             
	CMP R5,R0
	BGT CHECKAPPLE3RIGHT
	SUB R0,R0,#40
	CMP R5,R0
	BGE TEMPGROWRIGHT
	
CHECKAPPLE3RIGHT	

	LDR R5,=GOOD_APPLE3_X
	LDR R6,=GOOD_APPLE3_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	;CHECK Y
	ADD R6,R6,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R6,R1
	BLE CHECKAPPLE4RIGHT
	ADD R8,R1,#40         ;GET Y2 OF SNAKE
	CMP R6,R8
	BGE CHECKAPPLE4RIGHT
	;CHECK X
	ADD R0,R0,#40             
	CMP R5,R0
	BGT CHECKAPPLE4RIGHT
	SUB R0,R0,#40
	CMP R5,R0
	BGE TEMPGROWRIGHT
	
CHECKAPPLE4RIGHT	

	LDR R5,=GOOD_APPLE4_X
	LDR R6,=GOOD_APPLE4_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	;CHECK Y
	ADD R6,R6,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R6,R1
	BLE CHECKAPPLE5RIGHT
	ADD R8,R1,#40         ;GET Y2 OF SNAKE
	CMP R6,R8
	BGE CHECKAPPLE5RIGHT
	;CHECK X
	ADD R0,R0,#40             
	CMP R5,R0
	BGT CHECKAPPLE5RIGHT
	SUB R0,R0,#40
	CMP R5,R0
	BGE TEMPGROWRIGHT
	
	
CHECKAPPLE5RIGHT	

	LDR R5,=GOOD_APPLE3_X
	LDR R6,=GOOD_APPLE3_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	;CHECK Y
	ADD R6,R6,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R6,R1
	BLE CHECKPOISONRIGHT
	ADD R8,R1,#40         ;GET Y2 OF SNAKE
	CMP R6,R8
	BGE CHECKPOISONRIGHT
	;CHECK X
	ADD R0,R0,#40             
	CMP R5,R0
	BGT CHECKPOISONRIGHT
	SUB R0,R0,#40
	CMP R5,R0
	BGE TEMPGROWRIGHT
	
CHECKPOISONRIGHT	
	LDR R5,=BAD_APPLE_X
	LDR R6,=BAD_APPLE_Y
	LDRH R5,[R5]
	LDRH R6,[R6]
	;CHECK Y
	ADD R6,R6,#5          ;CHECK IF A POINT IN THE MIDDLE IS OUT OF RANGE
	CMP R6,R1
	BLE EXITEATRIGHT
	ADD R8,R1,#40         ;GET Y2 OF SNAKE
	CMP R6,R8
	BGE EXITEATRIGHT
	;CHECK X
	ADD R0,R0,#40             
	CMP R5,R0
	BGT EXITEATRIGHT
	SUB R0,R0,#40
	CMP R5,R0
	BGE TEMPGROWRIGHT
	
	
	
EXITEATRIGHT 
	MOV R3,#1
	POP {R0-R12,PC}
	ENDFUNC
	
	
TEMPGROWRIGHT 
	PUSH {R0-R12,LR} 
	LDR R0,=EATENAPPLES
	LDRB R1,[R0]
	ADD R1,R1,#1
	STRB R1,[R0]
	BL GROW_RIGHT	
	POP {R0-R12,PC}
	
	LTORG
	
GROW_RIGHT	FUNCTION
	PUSH {R0-R12, LR}
	
	LDR R6,=LENGTH     ;LOAD LENGTH OF SNAKE
	LDRB R6,[R6]
	SUB R6,R6,#1
	LDR R7,=2
	MUL R6,R6,R7         
	LDR R7,=SNAKE_X
	LDR R8,=SNAKE_Y
	ADD R7,R7,R6                   ;TO GET THE LAST VALID ELEMENT IN THE ARRAY
	ADD R8,R8,R6
	LDRH R1,[R7]
	LDRH R0,[R8]    
	SUB R3,R1,#40          
	ADD R7,R7,#2
	ADD R8,R8,#2
	STRH R3,[R7]				 ;SUB 40  AND STORE IT IN THE NEXT LOCATION
	STRH R0,[R8]				; STORE THE SAME X AS THIS GROWS DOWNWARDS
	LDR R6,=LENGTH
	ldrb r7,[r6]
	add r7,r7,#1             ;INCREMENT THE LENGTH AND STORE IT
	strb r7,[r6]
	CMP R7,#7               ;WIN IF THE SNAKE'S LENGTH IS 15 BOX
	BEQ WIN
	LDR R0,=SNAKE_Y
	LDRH R1,[R0]
	BL DRAW_SNAKE
	LDR R0,=SNAKE_Y
	LDRH R1,[R0]
	CMP R1,#200
	BEQ DUMMYLABEL		
	
	MOV R3,#1  
	POP {R0-R12, PC}
	ENDFUNC	
	
	; LAST THNG IN THE CODE
WINSNAKE FUNCTION
	BL DRAW_MAIN_MENU
	BL MYWHILE
	ENDFUNC

SNAKE_GAME_OVER	FUNCTION 
	BL GAME_OVER_SCREEN
	BL delay_1_second
	BL DRAW_MAIN_MENU
	BL MYWHILE
	ENDFUNC


	

;=======================================================================================================================================================
;=========================================================== SUPER MARIO GAME(START) ==========================================================================
;=======================================================================================================================================================


;======================================================================================================================================================
DRAW_MARIO_GAME
	PUSH {R0-R12, LR}
	
	BL Draw_MARIO_BG
	BL DRAW_FRAME1
	BL DRAW_CLOUDS
	;BL DRAW_IMAGE_ENEMY
	BL DRAW_MARIO_HEART_1
	BL DRAW_MARIO_HEART_2
	BL DRAW_MARIO_HEART_3
	BL DRAW_MARIO_SCORE
	BL DRAW_NUMBER_ZERO
	
	POP {R0-R12, PC}

;================================================================ READ INPUT ==========================================================================
MOVE_ENEMY FUNCTION
	PUSH {R0-R12, LR}

	LDR R0, =ENEMY_X1
	LDR R1, [R0]
	MOV R2, #0x00000FFF
	AND R1, R1, R2
	
	LDR R3, =ENEMY_X2
	LDR R4, [R3]
	MOV R2, #0x00000FFF
	AND R4, R4, R2
	
	LDR	R10, =ENEMY_Y1
	LDRB R11, [R10]
	
	
	LDR R12, =ENEMY_Y2
	LDRB R9, [R12]
	
	
	LDR R5, =ENEMY_DIRECTION
	LDR R6, [R5]
	MOV R2, #0X1
	AND R6, R6, R2
	
	;CMP R6, #0X1
	;BEQ MOVE_ENEMY_RIGHT


	SUB R7, R1, #10
	SUB R8, R4, #10
	
	CMP R7, #205
	BLE REVERSE_THE_MOVEMENT_TO_RIGHT

	;BL DELETE_ENEMY
	
	STRH R7, [R0]
	STRH R8, [R3]
	STRH R11,[R10]
	STRH R9, [R12]
	
	;BL DRAW_IMAGE_ENEMY

	B EXIT

;MOVE_ENEMY_RIGHT

	ADD R7, R1, #10
	ADD R8, R4, #10
	
	CMP R8, #320
	BGE REVERSE_THE_MOVEMENT_TO_LEFT
	
	;BL DELETE_ENEMY
	
	STRH R7, [R0]
	STRH R8, [R3]
	STRH R11,[R10]
	STRH R9, [R12]
	
	;BL DRAW_IMAGE_ENEMY

	B EXIT

REVERSE_THE_MOVEMENT_TO_RIGHT
	MOV R9, #0X1
	STR R9, [R5]
	
	B EXIT

REVERSE_THE_MOVEMENT_TO_LEFT
	MOV R9, #0X0
	STR R9, [R5]
	
EXIT

	POP {R0-R12, PC}
	ENDFUNC
	

DELETE_ENEMY FUNCTION
	PUSH {R0-R12, LR}
	
	LDR R7, =ENEMY_X1
	LDR R0, [R7]
	MOV R2, #0x00000FFF
	AND R0, R0, R2
	
	LDR R8, =ENEMY_Y1
	LDRB R1, [R8]
	
	LDR	R9, =ENEMY_X2
	LDR R3, [R9]
	MOV R2, #0x00000FFF
	AND R3, R3, R2
	LDR R11, =ENEMY_Y2
	LDRB R4, [R11]
	
	LDR R10, =CYAN2
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	ENDFUNC


READ_MARIO_INPUT FUNCTION
	
	;BL MOVE_ENEMY
	BL delay_10_milli_second
	
	BL CHECK_SW2_PRESSED
	CMP R3,#0
	BEQ MOVE_MARIO_UP_LABEL
	
JUMP_LABEL

	BL delay_10_milli_second
	BL CHECK_SW0_PRESSED
	CMP R3,#0
	BEQ MOVE_MARIO_RIGHT_LABEL
	
	BL delay_10_milli_second
	BL CHECK_SW1_PRESSED
	CMP R3,#0
	BEQ MOVE_MARIO_LEFT_LABEL
	
	BL delay_10_milli_second
	LDR R12, =MARIO_Y2
	LDRB R11, [R12]
	
	CMP R11, #200
	BLE GRAVITY_LABEL
	
RETURN_GRAVITY	

	BL READ_MARIO_INPUT

MOVE_MARIO_UP_LABEL
	BL MOVE_MARIO_UP
	BL JUMP_LABEL

MOVE_MARIO_RIGHT_LABEL
	BL MOVE_MARIO_RIGHT
	
	BL READ_MARIO_INPUT

MOVE_MARIO_LEFT_LABEL
	BL MOVE_MARIO_LEFT
	
	BL READ_MARIO_INPUT

GRAVITY_LABEL
	BL GRAVITY
	BL READ_MARIO_INPUT
	

	ENDFUNC
;======================================================================================================================================================
;================================================================= DRAW MARIO =========================================================================
DRAW_IMAGE_MARIO	FUNCTION
	PUSH {R0-R12, LR}
	
	LDR R8, =MARIO_X1
	LDRH R0, [R8]
	
	LDR R9, =MARIO_X2
	LDRH R1, [R9]
	
	LDR R10, =MARIO_Y1
	LDRH R3, [R10]
	
	LDR R11, =MARIO_Y2
	LDRH R4, [R11]
	
	bl ADDRESS_SET

	LDR R5, =MARIO
	MOV R7, #2120


	;MEMORY WRITE
	MOV R2, #0x2C
	BL LCD_COMMAND_WRITE
	
	LDRH R6, [R5]
	MOV R2, R6
	LSR R2, #8
	BL LCD_DATA_WRITE
	MOV R2, R6
	BL LCD_DATA_WRITE

	
IMAGE_LOOP_MARIO
    LDRH R6, [R5], #2
	;IF THERE'S A BLACK PIXEL AROUND THE PICTURE, REMOVE IT
	CMP R6, #0X0000
	BNE CONTINUE_LOOP
	LDR R6, =CYAN2
	
CONTINUE_LOOP
	MOV R2, R6
	LSR R2, #8
	BL LCD_DATA_WRITE
	MOV R2, R6
	BL LCD_DATA_WRITE

	SUBS R7, R7, #1
	CMP R7, #0
	BNE IMAGE_LOOP_MARIO



	POP {R0-R12, PC}
	
	ENDFUNC
	LTORG
;=====================================================================================================================================================
;========================================================= MOVE MARIO RIGHT ==========================================================================
MOVE_MARIO_RIGHT  FUNCTION
	PUSH {R0-R12, LR}
	
	LDR R7, =MARIO_X1
	LDR R0, [R7]
	
	MOV R2, #0x00000FFF
	AND R0, R0, R2
	
	LDR R8, =MARIO_X2
	LDR R1, [R8]
	
	MOV R2, #0x00000FFF
	AND R1, R1, R2
	
	LDR	R9, =MARIO_Y1
	LDRB R3, [R9]
	
	
	LDR R11, =MARIO_Y2
	LDRB R4, [R11]
	
	ADD R5, R0, #0X20                 ; ADD FOR EACH TIME
	ADD R6, R1, #0X20
	
	
	LDR R11, =LEVEL
	LDRB R12, [R11]
	LDR R11, =MARIO_Y2
	
	
	

	CMP R12, #0X0
	BEQ FRAME1_MOVE
	
	CMP R12, #0X0
	BEQ FRAME2_MOVE

FRAME1_MOVE
	CMP R1, #172
	BLT CONTINUE
	CMP R1, #213
	BGT CONTINUE
	CMP R4, #160
	BGT PIPE_COLLIDE_FRAME1_RIGHT
	
FRAME2_MOVE
	;CHECK FOR PIPE1
	CMP R1, #80
	BLT CHECK_PIPE2
	CMP R1, #126
	BGT CHECK_PIPE2
	CMP R4, #160
	BGT PIPE1_COLLIDE_FRAME2_RIGHT
	
CHECK_PIPE2
	CMP R1, #213
	BLT CONTINUE
	CMP R1, #253
	BGT CONTINUE
	CMP R4, #160
	BGT PIPE2_COLLIDE_FRAME2_RIGHT
	
CONTINUE	
	CMP R1, #288	                 ; COMPARE X2 WITH THE DIMENSION
	BGE DRAW_NEXT_FRAME					; RETURN BACK TO READ INPUT4
	
	LDR R0, =LEVEL
	LDRB R1, [R0]
	
	CMP R1,#0x3
	;BGE SET_DARKBLUE
	
	
	LDR R10, =CYAN2
CONTINUE_REMOVE_MARIO
	MOV R12,R3 ;R12 HAS Y1
	MOV R3, R1
	MOV R1, R12
	
	;R3 --> FEHA X2
	;R1 --> FEHA Y1
	
	;X1, Y1, X2, Y2

	BL DELETE_MARIO
 	MOV R12,R3 ;R12 HAS X2
	MOV R3, R1
	MOV R1, R12
	
	;R3 --> FEHA Y1
	;R1 --> FEHA X2
	
	;X1, X2, Y1, Y2
	
	STRH R5, [R7]
	STRH R6, [R8]
	STRH R3, [R9]
	STRH R4, [R11]
	
	LDR R0, =LEVEL
	LDRB R1, [R0]
	CMP R1,#0x3
	;BGE SET_DARKBLUE_MARIO
	
	BL DRAW_IMAGE_MARIO
	BL EXIT_MOVE_MARIO_RIGHT
	
PIPE_COLLIDE_FRAME1_RIGHT
	LDR R10, =CYAN2
	
	MOV R12,R3 ;R12 HAS Y1
	MOV R3, R1
	MOV R1, R12
	
	;R3 --> FEHA X2
	;R1 --> FEHA Y1
	
	;X1, Y1, X2, Y2

	BL DELETE_MARIO
	
	MOV R12,R3 ;R12 HAS X2
	MOV R3, R1
	MOV R1, R12
	
	MOV R5, #135
	MOV R6, #174
	STR R5, [R7]
	STR R6, [R8]
	STR R3, [R9]
	STR R4, [R11]
	
	BL DRAW_IMAGE_MARIO
	
	BL EXIT_MOVE_MARIO_RIGHT
	
PIPE1_COLLIDE_FRAME2_RIGHT
	LDR R10, =CYAN2
	
	MOV R12,R3 ;R12 HAS Y1
	MOV R3, R1
	MOV R1, R12
	
	;R3 --> FEHA X2
	;R1 --> FEHA Y1
	
	;X1, Y1, X2, Y2

	BL DELETE_MARIO
	
	MOV R12,R3 ;R12 HAS X2
	MOV R3, R1
	MOV R1, R12
	
	MOV R5, #45
	MOV R6, #84
	STR R5, [R7]
	STR R6, [R8]
	STR R3, [R9]
	STR R4, [R11]
	
	BL DRAW_IMAGE_MARIO
	
	BL EXIT_MOVE_MARIO_RIGHT


PIPE2_COLLIDE_FRAME2_RIGHT
	LDR R10, =CYAN2
	
	MOV R12,R3 ;R12 HAS Y1
	MOV R3, R1
	MOV R1, R12
	
	;R3 --> FEHA X2
	;R1 --> FEHA Y1
	
	;X1, Y1, X2, Y2

	BL DELETE_MARIO
	
	MOV R12,R3 ;R12 HAS X2
	MOV R3, R1
	MOV R1, R12
	
	MOV R5, #175
	MOV R6, #214
	STR R5, [R7]
	STR R6, [R8]
	STR R3, [R9]
	STR R4, [R11]
	
	BL DRAW_IMAGE_MARIO
	
	BL EXIT_MOVE_MARIO_RIGHT
	
	
	
DRAW_NEXT_FRAME
	LDR R0, =LEVEL
	LDRB R1, [R0]
	
	CMP R1,#0x1
	BEQ DRAW_FRAME2_LABEL
	
	
	CMP R1,#0x2
	BEQ DRAW_FRAME3_LABEL
	
	
	CMP R1,#0x3
	BEQ DRAW_FRAME1_LVL2_LABEL
	
	
	CMP R1,#0x4
	BEQ DRAW_FRAME2_LVL2_LABEL
	
	CMP R1,#0x5
	BEQ DRAW_FRAME3_LVL2_LABEL
	
	
	CMP R1,#0x6
	BEQ GG_SCREEN_LABEL

CONTINUE_INIT_NEXT_LEVEL	
	ADD R1, R1, #1
	STRB R1, [R0]
	
EXIT_MOVE_MARIO_RIGHT
	POP {R0-R12, PC}
	ENDFUNC

	LTORG
;===================================================================================================================================================
DRAW_FRAME2_LABEL
	BL RESET_MARIO
	BL DRAW_FRAME2
	BL CONTINUE_INIT_NEXT_LEVEL
	
DRAW_FRAME3_LABEL
	BL RESET_MARIO
	BL DRAW_FRAME3
	BL CONTINUE_INIT_NEXT_LEVEL
	
DRAW_FRAME1_LVL2_LABEL
	BL RESET_MARIO
	BL DRAW_FRAME1_LVL2
	BL CONTINUE_INIT_NEXT_LEVEL
	
DRAW_FRAME2_LVL2_LABEL
	BL RESET_MARIO
	BL DRAW_FRAME2_LVL2
	BL CONTINUE_INIT_NEXT_LEVEL
	
DRAW_FRAME3_LVL2_LABEL
	BL RESET_MARIO
	BL DRAW_FRAME3_LVL2
	BL CONTINUE_INIT_NEXT_LEVEL
	
GG_SCREEN_LABEL
	BL GG_SCREEN
	;BL CONTINUE_INIT_NEXT_LEVEL
	BL delay_1_second
	BL DRAW_MAIN_MENU
	BL MYWHILE
SET_DARKBLUE 
	LDR R10, =DARK_BLUE
	BL CONTINUE_REMOVE_MARIO
;============================================================== MOVE MARIO LEFT ====================================================================
MOVE_MARIO_LEFT  FUNCTION
	PUSH {R0-R12, LR}
	
	LDR R7, =MARIO_X1
	LDR R0, [R7]
	
	MOV R2, #0x00000FFF
	AND R0, R0, R2
	
	LDR R8, =MARIO_X2
	LDR R1, [R8]
	
	MOV R2, #0x00000FFF
	AND R1, R1, R2
	
	
	LDR	R9, =MARIO_Y1
	LDRB R3, [R9]
	
	LDR R11, =MARIO_Y2
	LDRB R4, [R11]
	
	SUB R5, R0, #0X20                 ; ADD FOR EACH TIME
	SUB R6, R1, #0X20
	
		LDR R11, =LEVEL
	LDRB R12, [R11]
	
	LDR R11, =MARIO_Y2


	CMP R1, #0X0
	BEQ FRAME1_MOVE
	
	CMP R1, #0X1
	BEQ FRAME2_MOVE




FRAME1_LEFT
	CMP R5, #200
	BGT CONTINUE_LEFT2
	CMP R5, #165
	BLT CONTINUE_LEFT2
	CMP R4, #142
	BGT PIPE_COLLIDE_FRAME1_LEFT
	
	
FRAME2_LEFT
	;CHECK PIPE1
	CMP R5, #114
	BGT CONTINUE_FRAME2
	CMP R5, #75
	BLT CONTINUE_FRAME2
	CMP R4, #142
	BGT PIPE1_COLLIDE_FRAME2_LEFT 
	
	;CHECK PIPE2
CONTINUE_FRAME2
	CMP R5, #244
	BGT CONTINUE_LEFT2
	CMP R5, #205
	BLT CONTINUE_LEFT2
	CMP R4, #142
	BGT PIPE2_COLLIDE_FRAME2_LEFT
	
	
CONTINUE_LEFT2
	
	CMP R5, #0X0                    ; COMPARE X2 WITH THE DIMENSION
	BLE EXIT_MOVE_MARIO_LEFT	      ; RETURN BACK TO READ INPUT4
	
	LDR R10, =CYAN2
	
	MOV R12,R3 ;R12 HAS Y1
	MOV R3, R1
	MOV R1, R12
	
	;R3 --> FEHA X2
	;R1 --> FEHA Y1
	
	;X1, Y1, X2, Y2

	BL DELETE_MARIO
 	MOV R12,R3 ;R12 HAS X2
	MOV R3, R1
	MOV R1, R12
	
	;R3 --> FEHA Y1
	;R1 --> FEHA X2
	
	;X1, X2, Y1, Y2
	
	STRH R5, [R7]
	STRH R6, [R8]
	STRH R3, [R9]
	STRH R4, [R11]
	
	BL DRAW_IMAGE_MARIO
	
PIPE_COLLIDE_FRAME1_LEFT
	LDR R10, =CYAN2
	
	MOV R12,R3 ;R12 HAS Y1
	MOV R3, R1
	MOV R1, R12
	
	;R3 --> FEHA X2
	;R1 --> FEHA Y1
	
	;X1, Y1, X2, Y2

	BL DELETE_MARIO
	
	MOV R12,R3 ;R12 HAS X2
	MOV R3, R1
	MOV R1, R12
	
	MOV R5, #202
	MOV R6, #241
	STR R5, [R7]
	STR R6, [R8]
	STR R3, [R9]
	STR R4, [R11]
	
	BL DRAW_IMAGE_MARIO
	
	BL EXIT_MOVE_MARIO_LEFT
	
	
PIPE1_COLLIDE_FRAME2_LEFT
	LDR R10, =CYAN2
	
	MOV R12,R3 ;R12 HAS Y1
	MOV R3, R1
	MOV R1, R12
	
	;R3 --> FEHA X2
	;R1 --> FEHA Y1
	
	;X1, Y1, X2, Y2

	BL DELETE_MARIO
	
	MOV R12,R3 ;R12 HAS X2
	MOV R3, R1
	MOV R1, R12
	
	MOV R5, #114
	MOV R6, #153
	STR R5, [R7]
	STR R6, [R8]
	STR R3, [R9]
	STR R4, [R11]
	
	BL DRAW_IMAGE_MARIO
	
	BL EXIT_MOVE_MARIO_LEFT
	
PIPE2_COLLIDE_FRAME2_LEFT
	LDR R10, =CYAN2
	
	MOV R12,R3 ;R12 HAS Y1
	MOV R3, R1
	MOV R1, R12
	
	;R3 --> FEHA X2
	;R1 --> FEHA Y1
	
	;X1, Y1, X2, Y2

	BL DELETE_MARIO
	
	MOV R12,R3 ;R12 HAS X2
	MOV R3, R1
	MOV R1, R12
	
	MOV R5, #244
	MOV R6, #283
	STR R5, [R7]
	STR R6, [R8]
	STR R3, [R9]
	STR R4, [R11]
	
	BL DRAW_IMAGE_MARIO
	
	BL EXIT_MOVE_MARIO_LEFT

	
EXIT_MOVE_MARIO_LEFT
	POP {R0-R12, PC}
	
	ENDFUNC

RESET_MARIO
	PUSH{R0-R12, LR}
	LDR R0, =MARIO_X1
	LDRH R1, [R0]
	MOV R1, #0X0A
	STRH R1, [R0]
	
	LDR R0, =MARIO_X2
	LDRH R1, [R0]
	MOV R1, #0X31
	STRH R1, [R0]
	
	
	LDR R0, =MARIO_Y1
	LDRH R1, [R0]
	MOV R1, #147
	STRH R1, [R0]
	
	
	LDR R0, =MARIO_Y2
	LDRH R1, [R0]
	MOV R1, #210
	STRH R1, [R0]
	
	POP {R0-R12, PC}
	
DRAW_IMAGE_COIN
	
	PUSH {R0-R12, LR}
	
	MOV R0, #129; X1
	MOV R1, #150 ;X2
	MOV R3, #184 ;Y1
	MOV R4, #205 ;Y2
	bl ADDRESS_SET

	LDR R5, =COIN
	MOV R7, #420


	;MEMORY WRITE
	MOV R2, #0x2C
	BL LCD_COMMAND_WRITE
	
	LDRH R6, [R5]
	MOV R2, R6
	LSR R2, #8
	BL LCD_DATA_WRITE
	MOV R2, R6
	BL LCD_DATA_WRITE

	
IMAGE_LOOP_COIN
    LDRH R6, [R5], #2
	;IF THERE'S A BLACK PIXEL AROUND THE PICTURE, REMOVE IT
	CMP R6, #0X0000
	BNE CONTINUE_LOOP_COINS
	LDR R6, =CYAN2
	
CONTINUE_LOOP_COINS
	MOV R2, R6
	LSR R2, #8
	BL LCD_DATA_WRITE
	MOV R2, R6
	BL LCD_DATA_WRITE

	SUBS R7, R7, #1
	CMP R7, #0
	BNE IMAGE_LOOP_COIN



	POP {R0-R12, PC}

;###############################################################################################################
;#############################################GRAVITY###########################################################
	LTORG
GRAVITY FUNCTION
	PUSH {R0-R12, LR}
	LDR R7, =MARIO_X1
	LDR R0, [R7]
	
	MOV R2, #0x00000FFF
	AND R0, R0, R2
	
	LDR R8, =MARIO_X2
	LDR R1, [R8]
	
	MOV R2, #0x00000FFF
	AND R1, R1, R2
	
	LDR	R9, =MARIO_Y1
	LDRB R3, [R9]
	
	
	LDR R11, =MARIO_Y2
	LDRB R4, [R11]
	
	
	LDR R11, =LEVEL
	LDRB R12, [R11]
	
	LDR R11, =MARIO_Y2


	CMP R1, #0X0
	BEQ FRAME1_MOVE
	
	CMP R1, #0X1
	BEQ FRAME2_MOVE
	
FRAME1_GRAVITY
	CMP R1, #175
	BLE CONTINUE_GRAVITY
	CMP R0, #206
	BGE CONTINUE_GRAVITY
	BL EXIT_GRAVITY
	
FRAME2_GRAVITY
	CMP R1, #85
	BLE CONTINUE_FRAME2_GRAVITY
	CMP R0, #116
	BGE CONTINUE_FRAME2_GRAVITY
	BL EXIT_GRAVITY
	
CONTINUE_FRAME2_GRAVITY
	CMP R1, #215
	BLE CONTINUE_GRAVITY
	CMP R0, #246
	BGE CONTINUE_GRAVITY
	BL EXIT_GRAVITY
	
CONTINUE_GRAVITY
	BL delay_10_milli_second
	BL DELETE_MARIO
	
	ADD	R3, R3, #0x0A
	ADD	R4, R4, #0x0A
	

	STRH R3, [R9]
	STRH R4, [R11]
	
	
	BL DRAW_IMAGE_MARIO
	BL delay_10_milli_second
	
	
EXIT_GRAVITY
	POP {R0-R12, PC}
	ENDFUNC
	

;############################################MARIO JUMP#########################################################


MOVE_MARIO_UP	FUNCTION
	PUSH {R0-R12, LR}
;	LDR R7, =MARIO_X1
;	LDRB R0, [R7]
;	
;	LDR R8, =MARIO_Y1
;	LDRB R1, [R8]
;	
;	LDR	R9, =MARIO_X2
;	LDRB R3, [R9]
;	
;	LDR R11, =MARIO_Y2
;	LDRB R4, [R11]
;	
;	LDR R10, =CYAN2
;	BL DRAW_RECTANGLE_FILLED
	
	
	LDR R7, =MARIO_X1
	LDR R0, [R7]
	
	MOV R2, #0x00000FFF
	AND R0, R0, R2
	
	LDR R8, =MARIO_X2
	LDR R1, [R8]
	
	MOV R2, #0x00000FFF
	AND R1, R1, R2
	
	LDR	R9, =MARIO_Y1
	LDRB R3, [R9]
	
	
	LDR R11, =MARIO_Y2
	LDRB R4, [R11]
 		
	CMP R4, #210
	BLT EXIT_JUMP
	MOV R12, #7
JUMP_LOOP
	
	BL delay_10_milli_second
	BL DELETE_MARIO


	SUB	R3, R3, #0x0A
	SUB	R4, R4, #0x0A
	

	STRH R3, [R9]
	STRH R4, [R11]
	
	
	BL DRAW_IMAGE_MARIO
	BL delay_10_milli_second
	SUB R12, #1
	CMP R12, #0
	BNE JUMP_LOOP
EXIT_JUMP
	POP {R0-R12, PC}
	ENDFUNC
	
;###############################################################################################################
;#######################################DELETE MARIO#############################################################
DELETE_MARIO FUNCTION
	PUSH {R0-R12, LR}
	LDR R7, =MARIO_X1
	LDR R0, [R7]
	MOV R2, #0x00000FFF
	AND R0, R0, R2
	
	LDR R8, =MARIO_Y1
	LDRB R1, [R8]
	
	LDR	R9, =MARIO_X2
	LDR R3, [R9]
	MOV R2, #0x00000FFF
	AND R3, R3, R2
	LDR R11, =MARIO_Y2
	LDRB R4, [R11]
	SUB R4, #10
	LDR R10, =CYAN2
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	ENDFUNC


;======================================================================================================================================================
;================================================================= DRAWING-SCORE  =====================================================================
DRAW_MARIO_SCORE FUNCTION
	PUSH {R0-R12, LR}
	
	;logo of the coin
	MOV R0,#20
	MOV R1,#10
	MOV R3,#40
	MOV R4,#35
	LDR R10,=YELLOW
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #45
	MOV R1, #15
	MOV R3, #50
	MOV R4, #20
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #45
	MOV R1, #25
	MOV R3, #50
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	ENDFUNC
	
DRAW_NUMBER_ZERO FUNCTION
	PUSH {R0-R12, LR}
	
	MOV R0, #59
	MOV R1, #10
	MOV R3, #71
	MOV R4, #15
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #59
	MOV R1, #15
	MOV R3, #62
	MOV R4, #25
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #68
	MOV R1, #15
	MOV R3, #71
	MOV R4, #25
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #59
	MOV R1, #25
	MOV R3, #71
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	
	ENDFUNC
	
	LTORG
	

DRAW_NUMBER_TEN FUNCTION
	
	PUSH {R0-R12, LR}
	
	MOV R0, #70
	MOV R1, #10
	MOV R3, #75
	MOV R4, #35
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #10
	MOV R3, #89
	MOV R4, #15
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #15
	MOV R3, #80
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	
	MOV R0, #86
	MOV R1, #15
	MOV R3, #89
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #30
	MOV R3, #89
	MOV R4, #35
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	ENDFUNC
	
	LTORG

DRAW_NUMBER_TWENTY FUNCTION
	PUSH {R0-R12, LR}
	
	MOV R0, #60
	MOV R1, #10
	MOV R3, #65
	MOV R4, #15
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #70
	MOV R1, #30
	MOV R3, #75
	MOV R4, #35
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #65
	MOV R1, #10
	MOV R3, #70
	MOV R4, #35
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #10
	MOV R3, #89
	MOV R4, #15
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #15
	MOV R3, #80
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	
	MOV R0, #86
	MOV R1, #15
	MOV R3, #89
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #30
	MOV R3, #89
	MOV R4, #35
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	ENDFUNC
	
	LTORG

DRAW_NUMBER_THIRTY FUNCTION
	PUSH {R0-R12, LR}
	
	MOV R0, #60
	MOV R1, #10
	MOV R3, #75
	MOV R4, #15
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #60
	MOV R1, #20
	MOV R3, #75
	MOV R4, #25
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #60
	MOV R1, #30
	MOV R3, #75
	MOV R4, #35
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #70
	MOV R1, #10
	MOV R3, #75
	MOV R4, #35
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #10
	MOV R3, #89
	MOV R4, #15
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #15
	MOV R3, #80
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	
	MOV R0, #86
	MOV R1, #15
	MOV R3, #89
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #30
	MOV R3, #89
	MOV R4, #35
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	ENDFUNC
	
	LTORG
	
DRAW_NUMBER_FOURTY FUNCTION
	PUSH {R0-R12, LR}
	
	MOV R0, #60
	MOV R1, #20
	MOV R3, #75
	MOV R4, #25
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #60
	MOV R1, #10
	MOV R3, #65
	MOV R4, #25
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #70
	MOV R1, #10
	MOV R3, #75
	MOV R4, #35
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #10
	MOV R3, #89
	MOV R4, #15
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #15
	MOV R3, #80
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #86
	MOV R1, #15
	MOV R3, #89
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #30
	MOV R3, #89
	MOV R4, #35
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	ENDFUNC
	
	LTORG

DRAW_NUMBER_FIFTY FUNCTION
	PUSH {R0-R12, LR}
	
	MOV R0, #60
	MOV R1, #10
	MOV R3, #75
	MOV R4, #15
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #60
	MOV R1, #20
	MOV R3, #75
	MOV R4, #25
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #60
	MOV R1, #30
	MOV R3, #75
	MOV R4, #35
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #60
	MOV R1, #10
	MOV R3, #65
	MOV R4, #25
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #70
	MOV R1, #20
	MOV R3, #75
	MOV R4, #35
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #10
	MOV R3, #89
	MOV R4, #15
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #15
	MOV R3, #80
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #86
	MOV R1, #15
	MOV R3, #89
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #30
	MOV R3, #89
	MOV R4, #35
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	ENDFUNC
	
	LTORG
	

DRAW_NUMBER_SIXTY FUNCTION
	PUSH {R0-R12, LR}
	
	MOV R0, #60
	MOV R1, #10
	MOV R3, #75
	MOV R4, #15
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #60
	MOV R1, #20
	MOV R3, #75
	MOV R4, #25
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #60
	MOV R1, #30
	MOV R3, #75
	MOV R4, #35
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #60
	MOV R1, #10
	MOV R3, #65
	MOV R4, #35
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #70
	MOV R1, #20
	MOV R3, #75
	MOV R4, #35
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #10
	MOV R3, #89
	MOV R4, #15
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #15
	MOV R3, #80
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #86
	MOV R1, #15
	MOV R3, #89
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #30
	MOV R3, #89
	MOV R4, #35
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	ENDFUNC
	
	LTORG

DRAW_NUMBER_SEVENTY FUNCTION
	
	PUSH {R0-R12, LR}
	
	MOV R0, #60
	MOV R1, #10
	MOV R3, #75
	MOV R4, #15
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #60
	MOV R1, #20
	MOV R3, #75
	MOV R4, #25
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #70
	MOV R1, #10
	MOV R3, #75
	MOV R4, #35
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #10
	MOV R3, #89
	MOV R4, #15
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #15
	MOV R3, #80
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	
	MOV R0, #86
	MOV R1, #15
	MOV R3, #89
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #30
	MOV R3, #89
	MOV R4, #35
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	ENDFUNC
	
	LTORG

DRAW_NUMBER_EIGHTY FUNCTION
	PUSH {R0-R12, LR}
	
	MOV R0, #60
	MOV R1, #10
	MOV R3, #75
	MOV R4, #15
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #60
	MOV R1, #20
	MOV R3, #75
	MOV R4, #25
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #60
	MOV R1, #30
	MOV R3, #75
	MOV R4, #35
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #70
	MOV R1, #10
	MOV R3, #75
	MOV R4, #35
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #60
	MOV R1, #10
	MOV R3, #65
	MOV R4, #35
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #10
	MOV R3, #89
	MOV R4, #15
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #15
	MOV R3, #80
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #86
	MOV R1, #15
	MOV R3, #89
	MOV R4, #30
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #77
	MOV R1, #30
	MOV R3, #89
	MOV R4, #35
	LDR R10, =BLACK
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	ENDFUNC
	
	LTORG
	
DRAW_MARIO_HEART_1 FUNCTION
	PUSH {R0-R12, LR}
	
	MOV R0, #275
	MOV R1, #10
	MOV R3, #285
	MOV R4, #20
	LDR R10, =RED
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #290
	MOV R1, #10
	MOV R3, #300
	MOV R4, #20
	LDR R10, =RED
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #275
	MOV R1, #15
	MOV R3, #300
	MOV R4, #20
	LDR R10, =RED
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #280
	MOV R1, #20
	MOV R3, #295
	MOV R4, #25
	LDR R10, =RED
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #285
	MOV R1, #25
	MOV R3, #290
	MOV R4, #30
	
	LDR R10, =RED
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	ENDFUNC
	
	LTORG
	
	;=============================DELETE FRAMES=============================
DELETE_LVL1
    PUSH{R0-R12, LR}

    MOV R0, #0
    MOV R1, #35
    MOV R3, #340
    MOV R4, #200
    LDR R10,  =CYAN2
    BL DRAW_RECTANGLE_FILLED

    POP{R0-R12, PC}

DELETE_LVL2_F1
    PUSH{R0-R12, LR}

    MOV R0, #0
    MOV R1, #35
    MOV R3, #340
    MOV R4, #200
    LDR R10,  =DARK_BLUE
    BL DRAW_RECTANGLE_FILLED

    POP{R0-R12, PC}

DELETE_LVL2_F2 FUNCTION
    PUSH{R0-R12, LR}

    MOV R0, #0
    MOV R1, #35
    MOV R3, #340
    MOV R4, #200
    LDR R10,  =DARK_BLUE
    BL DRAW_RECTANGLE_FILLED

    MOV R0, #100
    MOV R1, #200
    MOV R3, #150
    MOV R4, #240
    LDR R10,  =BROWN
    BL DRAW_RECTANGLE_FILLED

    POP{R0-R12, PC}
	ENDFUNC
	
DRAW_MARIO_HEART_2 FUNCTION
	PUSH {R0-R12, LR}
	
	MOV R0, #245
	MOV R1, #10
	MOV R3, #255
	MOV R4, #20
	LDR R10, =RED
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #260
	MOV R1, #10
	MOV R3, #270
	MOV R4, #20
	LDR R10, =RED
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #245
	MOV R1, #15
	MOV R3, #270
	MOV R4, #20
	LDR R10, =RED
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #250
	MOV R1, #20
	MOV R3, #265
	MOV R4, #25
	LDR R10, =RED
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #255
	MOV R1, #25
	MOV R3, #260
	MOV R4, #30
	
	LDR R10, =RED
	BL DRAW_RECTANGLE_FILLED
	POP {R0-R12, PC}
	ENDFUNC
	
	LTORG
DRAW_MARIO_HEART_3 FUNCTION
	PUSH {R0-R12, LR}
	
	MOV R0, #215
	MOV R1, #10
	MOV R3, #225
	MOV R4, #20
	LDR R10, =RED
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #230
	MOV R1, #10
	MOV R3, #240
	MOV R4, #20
	LDR R10, =RED
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #215
	MOV R1, #15
	MOV R3, #240
	MOV R4, #20
	LDR R10, =RED
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #220
	MOV R1, #20
	MOV R3, #235
	MOV R4, #25
	LDR R10, =RED
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0, #225
	MOV R1, #25
	MOV R3, #230
	MOV R4, #30
	
	LDR R10, =RED
	BL DRAW_RECTANGLE_FILLED
	POP {R0-R12, PC}
	ENDFUNC
	LTORG
;##########################################################################################################
;	LTORG




;#####################################################################################################################################################################

;#####################################################################################################################################################################




	

	LTORG
	
;#####################################################################################################################################################################
Draw_MARIO_BG
	PUSH {R0-R12, LR}
	MOV R0,#0
	MOV R1,#0
	MOV R3,#320
	MOV R4,#240
	LDR R10,=CYAN2
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#0
	MOV R1,#200
	MOV R3,#320
	MOV R4,#240
	LDR R10,=BROWN
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#0
	MOV R1,#200
	MOV R3,#320
	MOV R4,#210
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#40
	MOV R1,#200
	MOV R3,#60
	MOV R4,#240
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#100
	MOV R1,#200
	MOV R3,#120
	MOV R4,#240
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#160
	MOV R1,#200
	MOV R3,#180
	MOV R4,#240
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#220
	MOV R1,#200
	MOV R3,#240
	MOV R4,#240
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0,#280
	MOV R1,#200
	MOV R3,#300
	MOV R4,#240
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
DRAW_MARIO_PIPE_FrameOne
	PUSH {R0-R12, LR}
	MOV R0,#175
	MOV R1,#135
	MOV R3,#205
	MOV R4,#150
	LDR R10,=GREEN
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#175
	MOV R1,#150
	MOV R3,#205
	MOV R4,#160
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#175
	MOV R1,#160
	MOV R3,#205
	MOV R4,#200
	LDR R10,=GREEN
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}

DRAW_MARIO_PIPE_FrameTwo
	PUSH {R0-R12, LR}
	;PIPE ONE
	MOV R0,#85
	MOV R1,#135
	MOV R3,#115
	MOV R4,#150
	LDR R10,=GREEN
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#85
	MOV R1,#150
	MOV R3,#115
	MOV R4,#160
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#85
	MOV R1,#160
	MOV R3,#115
	MOV R4,#200
	LDR R10,=GREEN
	BL DRAW_RECTANGLE_FILLED
	;PIPE TWO
	MOV R0,#215
	MOV R1,#135
	MOV R3,#245
	MOV R4,#150
	LDR R10,=GREEN
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#215
	MOV R1,#150
	MOV R3,#245
	MOV R4,#160
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#215
	MOV R1,#160
	MOV R3,#245
	MOV R4,#200
	LDR R10,=GREEN
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	
DRAW_MARIO_Coins_FrameTwo
	PUSH {R0-R12, LR}
	;COIN ONE
	MOV R0,#160
	MOV R1,#175
	MOV R3,#180
	MOV R4,#195
	LDR R10,=YELLOW
	BL DRAW_RECTANGLE_FILLED
	;COIN TWO
	MOV R0,#280
	MOV R1,#175
	MOV R3,#300
	MOV R4,#195
	LDR R10,=YELLOW
	BL DRAW_RECTANGLE_FILLED
	
	
	POP {R0-R12, PC}
	
	
DRAW_MARIO_Coins_FrameThree
	PUSH {R0-R12, LR}
	;COIN ONE
	MOV R0,#150
	MOV R1,#175
	MOV R3,#170
	MOV R4,#195
	LDR R10,=YELLOW
	BL DRAW_RECTANGLE_FILLED
	;COIN TWO
	MOV R0,#70
	MOV R1,#175
	MOV R3,#90
	MOV R4,#195
	LDR R10,=YELLOW
	BL DRAW_RECTANGLE_FILLED
	;COIN TWO
	MOV R0,#240
	MOV R1,#175
	MOV R3,#260
	MOV R4,#195
	LDR R10,=YELLOW
	BL DRAW_RECTANGLE_FILLED
	
	
	POP {R0-R12, PC}
	
	


DRAW_MARIO_FLAG
	PUSH {R0-R12, LR}
	;POLE ROD
	MOV R0,#300
	MOV R1,#145
	MOV R3,#305
	MOV R4,#200
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	;FLAG
	MOV R0,#270
	MOV R1,#145
	MOV R3,#305
	MOV R4,#165
	LDR R10,=RED
	BL DRAW_RECTANGLE_FILLED
	POP{R0-R12, PC}
	
;===================================================MARIO LEVEL TWO==============================================
DRAW_LEVEL_TWO
	PUSH {R0-R12, LR}
	;BLACK BG
	MOV R0,#0
	MOV R1,#0
	MOV R3,#320
	MOV R4,#240
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	;L
	MOV R0,#30
	MOV R1,#70
	MOV R3,#50
	MOV R4,#170
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED
	
	
	MOV R0,#30
	MOV R1,#150
	MOV R3,#70
	MOV R4,#170
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED
	
	
	;V
	MOV R0,#80
	MOV R1,#70
	MOV R3,#100
	MOV R4,#170
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED
	
	
	MOV R0,#80
	MOV R1,#150
	MOV R3,#130
	MOV R4,#170
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0,#110
	MOV R1,#70
	MOV R3,#130
	MOV R4,#170
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED
	
	;L
	MOV R0,#140
	MOV R1,#70
	MOV R3,#160
	MOV R4,#170
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED
	
	
	MOV R0,#140
	MOV R1,#150
	MOV R3,#180
	MOV R4,#170
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED
	
	
	
	;II
	MOV R0,#210
	MOV R1,#70
	MOV R3,#290
	MOV R4,#90
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED
	
	
	MOV R0,#220
	MOV R1,#70
	MOV R3,#240
	MOV R4,#170
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED
	
	
	MOV R0,#210
	MOV R1,#150
	MOV R3,#290
	MOV R4,#170
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED
	
	
	MOV R0,#260
	MOV R1,#70
	MOV R3,#280
	MOV R4,#170
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED 
	
	
	POP {R0-R12, PC}
	
	
;========================================================SUPER MARIO LEVEL 2======================================================================
DRAW_MARIO_BG_LVL2
	PUSH {R0-R12, LR}
	MOV R0,#0
	MOV R1,#0
	MOV R3,#320
	MOV R4,#240
	LDR R10,=DARK_BLUE
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#0
	MOV R1,#200
	MOV R3,#320
	MOV R4,#240
	LDR R10,=GREY
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#0
	MOV R1,#200
	MOV R3,#320
	MOV R4,#210
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#40
	MOV R1,#200
	MOV R3,#60
	MOV R4,#240
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#100
	MOV R1,#200
	MOV R3,#120
	MOV R4,#240
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#160
	MOV R1,#200
	MOV R3,#180
	MOV R4,#240
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#220
	MOV R1,#200
	MOV R3,#240
	MOV R4,#240
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	MOV R0,#280
	MOV R1,#200
	MOV R3,#300
	MOV R4,#240
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	
	BL DRAW_STARS
	
	POP {R0-R12, PC}
	
DRAW_MARIO_PIPE_LVL2_FrameOne
	PUSH {R0-R12, LR}
	MOV R0,#70
	MOV R1,#135
	MOV R3,#140
	MOV R4,#150
	LDR R10,=MAGENTA
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#90
	MOV R1,#150
	MOV R3,#120
	MOV R4,#160
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#90
	MOV R1,#160
	MOV R3,#120
	MOV R4,#200
	LDR R10,=MAGENTA
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}

DRAW_MARIO_PIPE_LVL2_FRAME2
	
	PUSH{R0-R12,LR}
	MOV R0,#190
	MOV R1,#135
	MOV R3,#260
	MOV R4,#150
	LDR R10,=MAGENTA
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#210
	MOV R1,#150
	MOV R3,#240
	MOV R4,#160
	LDR R10,=BLACK
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#210
	MOV R1,#160
	MOV R3,#240
	MOV R4,#200
	LDR R10,=MAGENTA
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	
DRAW_MARIO_COINS_L2_F2
	PUSH {R0-R12, LR}
	;COIN ONE
	MOV R0,#75
	MOV R1,#175
	MOV R3,#95
	MOV R4,#195
	LDR R10,=YELLOW
	BL DRAW_RECTANGLE_FILLED
	;COIN TWO
	MOV R0,#215
	MOV R1,#110
	MOV R3,#235
	MOV R4,#130
	LDR R10,=YELLOW
	BL DRAW_RECTANGLE_FILLED
	
	
	POP {R0-R12, PC}
	
	LTORG	
	
DRAW_IMAGE_MARIO_LVL2    FUNCTION
    PUSH {R0-R12, LR}

    LDR R8, =MARIO_X1
    LDRH R0, [R8]

    LDR R9, =MARIO_X2
    LDRH R1, [R9]

    LDR R10, =MARIO_Y1
    LDRH R3, [R10]

    LDR R11, =MARIO_Y2
    LDRH R4, [R11]

    bl ADDRESS_SET

    LDR R5, =MARIO
    MOV R7, #2120


    ;MEMORY WRITE
    MOV R2, #0x2C
    BL LCD_COMMAND_WRITE

    LDRH R6, [R5]
    MOV R2, R6
    LSR R2, #8
    BL LCD_DATA_WRITE
    MOV R2, R6
    BL LCD_DATA_WRITE


IMAGE_LOOP_MARIO_LVL2
    LDRH R6, [R5], #2
    ;IF THERE'S A BLACK PIXEL AROUND THE PICTURE, REMOVE IT
    CMP R6, #0X0000
    BNE CONTINUE_LOOP_LVL2
    LDR R6, =DARK_BLUE

CONTINUE_LOOP_LVL2
    MOV R2, R6
    LSR R2, #8
    BL LCD_DATA_WRITE
    MOV R2, R6
    BL LCD_DATA_WRITE

    SUBS R7, R7, #1
    CMP R7, #0
    BNE IMAGE_LOOP_MARIO_LVL2



    POP {R0-R12, PC}

    ENDFUNC
	LTORG
DRAW_STARS
	PUSH {R0-R12,LR}
	;STAR 1
	MOV R0, #20
	MOV R1, #10
	MOV R3, #22
	MOV R4, #12
	LDR R10, =WHITE
	BL	DRAW_RECTANGLE_FILLED
	
	;STAR 2
	MOV R0, #80
	MOV R1, #20
	MOV R3, #82
	MOV R4, #22
	LDR R10, =WHITE
	BL	DRAW_RECTANGLE_FILLED
	
	;STAR 3
	MOV R0, #120
	MOV R1, #15
	MOV R3, #122
	MOV R4, #17
	LDR R10, =WHITE
	BL	DRAW_RECTANGLE_FILLED
	
	;STAR 4
	MOV R0, #200
	MOV R1, #38
	MOV R3, #202
	MOV R4, #40
	LDR R10, =WHITE
	BL	DRAW_RECTANGLE_FILLED
	
	;STAR 5
	MOV R0, #270
	MOV R1, #26
	MOV R3, #272
	MOV R4, #28
	LDR R10, =WHITE
	BL	DRAW_RECTANGLE_FILLED
	
	;STAR 4
	MOV R0, #310
	MOV R1, #10
	MOV R3, #312
	MOV R4, #12
	LDR R10, =WHITE
	BL	DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}
	
DRAW_HOLE 
	PUSH{R0-R12,LR}
	MOV R0, #100
	MOV R1, #200
	MOV R3, #150
	MOV R4, #240
	LDR R10, =DARK_BLUE
	BL DRAW_RECTANGLE_FILLED
	POP {R0-R12, PC}

DRAW_FRAME1_LVL2
	PUSH {R0-R12,LR}
	BL DRAW_LEVEL_TWO
	BL delay_10_milli_second
	BL DRAW_MARIO_BG_LVL2
	BL DRAW_MARIO_PIPE_LVL2_FrameOne
	BL DRAW_IMAGE_MARIO_LVL2
	;BL DRAW_IMAGE_TURTLE
	POP {R0-R12, PC}
	
DRAW_FRAME2_LVL2
	PUSH {R0-R12,LR}
	BL DELETE_LVL2_F1
	BL DRAW_MARIO_BG_LVL2
	BL DRAW_MARIO_PIPE_LVL2_FRAME2
	BL DRAW_HOLE
	BL DRAW_MARIO_COINS_L2_F2
	BL DRAW_IMAGE_MARIO_LVL2
	POP {R0-R12, PC}
	
DRAW_FRAME3_LVL2
	PUSH {R0-R12, LR}
	BL DELETE_LVL2_F2
	BL DRAW_MARIO_BG_LVL2
	BL DRAW_MARIO_FLAG
	BL DRAW_MARIO_Coins_FrameThree
	BL DRAW_IMAGE_MARIO_LVL2
	POP {R0-R12, PC}
	

;===============================================================================	
	
DRAW_CLOUDS
	PUSH {R0-R12, LR}
	MOV R0,#250
	MOV R1,#10
	MOV R3,#290
	MOV R4,#25
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#235
	MOV R1,#25
	MOV R3,#300
	MOV R4,#40
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#45
	MOV R1,#20
	MOV R3,#115
	MOV R4,#30
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#70
	MOV R1,#10
	MOV R3,#105
	MOV R4,#20
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED
	MOV R0,#60
	MOV R1,#30
	MOV R3,#95
	MOV R4,#40
	LDR R10,=WHITE
	BL DRAW_RECTANGLE_FILLED
	
	POP {R0-R12, PC}

DRAW_IMAGE_ENEMY    FUNCTION
    PUSH {R0-R12, LR}

    LDR R8, =ENEMY_X1
    LDRH R0, [R8]

    LDR R9, =ENEMY_X2
   LDRH R1, [R9]

    LDR R10, =ENEMY_Y1
    LDRH R3, [R10]

    LDR R11, =ENEMY_Y2
    LDRH R4, [R11]

    bl ADDRESS_SET

    LDR R5, =ENEMY
    MOV R7, #2500


    ;MEMORY WRITE
    MOV R2, #0x2C
    BL LCD_COMMAND_WRITE

    LDRH R6, [R5]
    MOV R2, R6
    LSR R2, #8
    BL LCD_DATA_WRITE
    MOV R2, R6
    BL LCD_DATA_WRITE


IMAGE_LOOP_ENEMY
    LDRH R6, [R5], #2
    ;IF THERE'S A BLACK PIXEL AROUND THE PICTURE, REMOVE IT
    MOV R2,#0xa51a
    CMP R6, R2
    ;BNE CONTINUE_LOOP_ENEMY
    LDR R6, =CYAN2

CONTINUE_LOOP_ENEMY
    MOV R2, R6
    LSR R2, #8
    BL LCD_DATA_WRITE
    MOV R2, R6
    BL LCD_DATA_WRITE

    SUBS R7, R7, #1
    CMP R7, #0
    ;BNE IMAGE_LOOP_ENEMY


    POP {R0-R12, PC}

    ENDFUNC
	LTORG



DRAW_FRAME1
	PUSH {R0-R12, LR}
	BL DRAW_MARIO_PIPE_FrameOne
	;BL DRAW_IMAGE_ENEMY
	BL DRAW_IMAGE_MARIO
	POP {R0-R12, PC}
	
DRAW_FRAME2
	PUSH {R0-R12, LR}
	BL DELETE_LVL1
	BL DRAW_MARIO_PIPE_FrameTwo
	BL DRAW_MARIO_Coins_FrameTwo
	;BL DRAW_IMAGE_ENEMY
	;BL DRAW_IMAGE_MARIO
	POP {R0-R12, PC}
	
DRAW_FRAME3
	PUSH {R0-R12, LR}
	BL DELETE_LVL1
	BL DRAW_MARIO_FLAG
	BL DRAW_MARIO_Coins_FrameThree
	;BL DRAW_IMAGE_ENEMY
	;BL DRAW_IMAGE_MARIO
	POP {R0-R12, PC}




   LTORG

;======================================================================================================================
;============================================== INITIALIZE VARIABLES ==================================================
;======================================================================================================================
INITIALIZE_VARIABLES	FUNCTION
	PUSH {R0-R12,LR}
	
	;INIT LEVEL
	LDR R0, =LEVEL
	LDRB R1, [R0]
	MOV R1, #0x1
	STRB R1, [R0]
	
	;INITIALIZE MARIO VARIABLES
	LDR R0, =MARIO_X1
	LDR R1, [R0]
	MOV R1, #0X0A
	STR R1, [R0]
	
	LDR R0, =MARIO_X2
	LDR R1, [R0]
	MOV R1, #0X31
	STR R1, [R0]
	
	
	LDR R0, =MARIO_Y1
	LDR R1, [R0]
	MOV R1, #147
	STR R1, [R0]
	
	
	LDR R0, =MARIO_Y2
	LDR R1, [R0]
	MOV R1, #210
	STR R1, [R0]

	;INITIALIZE ENEMY VARIABLES
	LDR R0, =ENEMY_X1
    LDR R1, [R0]
    MOV R1, #261
    STR R1, [R0]

    LDR R0, =ENEMY_X2
    LDR R1, [R0]
    MOV R1, #310
    STR R1, [R0]

    LDR R0, =ENEMY_Y1
    LDR R1, [R0]
    MOV R1, #150
    STR R1, [R0]

    LDR R0, =ENEMY_Y2
    LDR R1, [R0]
    MOV R1, #199
    STR R1, [R0]
	
	
	LDR R0, =ENEMY_DIRECTION
	LDR R1, [R0]
	MOV R1, #0X0
	STR R1, [R0]
	
	;INITIALIZE TURTULE VARIABLES
	LDR R0, =TURTLE_X1
    LDR R1, [R0]
    MOV R1, #10
    STR R1, [R0]

    LDR R0, =TURTLE_X2
    LDR R1, [R0]
    MOV R1, #59
    STR R1, [R0]


    LDR R0, =TURTLE_Y1
    LDR R1, [R0]
    MOV R1, #145
    STR R1, [R0]


    LDR R0, =TURTLE_Y2
    LDR R1, [R0]
    MOV R1, #209
    STR R1, [R0]
	
	POP {R0-R12,PC}
	ENDFUNC

;============================================== END OF INITIALIZATION =================================================


;=======================================================================================================================================================
;=========================================================== SUPER MARIO GAME(END) ==========================================================================
;=======================================================================================================================================================

;################################################################################################

	LTORG
	
;#####################################################################################################################################################################

  

;####################################################################################################


   LTORG

;####################################################################################################3
; HELPER DELAYS IN THE SYSTEM, YOU CAN USE THEM DIRECTLY


;##########################################################################################################################################
delay_1_second
	;this function just delays for 1 second
	PUSH {R8, LR}
	LDR r8, =INTERVAL
delay_loop
	SUBS r8, #1
	CMP r8, #0
	BGE delay_loop
	POP {R8, PC}
;##########################################################################################################################################




;##########################################################################################################################################
delay_half_second
	;this function just delays for half a second
	PUSH {R8, LR}
	LDR r8, =INTERVAL
delay_loop1
	SUBS r8, #2
	CMP r8, #0
	BGE delay_loop1

	POP {R8, PC}
;##########################################################################################################################################


;##########################################################################################################################################
delay_milli_second
	;this function just delays for a millisecond
	PUSH {R8, LR}
	LDR r8, =INTERVAL
delay_loop2
	SUBS r8, #1000
	CMP r8, #0
	BGE delay_loop2

	POP {R8, PC}
;##########################################################################################################################################



;##########################################################################################################################################
delay_10_milli_second
	;this function just delays for 10 millisecondS
	PUSH {R8, LR}
	LDR r8, =INTERVAL
delay_loop3
	SUBS r8, #100
	CMP r8, #0
	BGE delay_loop3

	POP {R8, PC}
;##########################################################################################################################################




	END