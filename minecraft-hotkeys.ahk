#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; ATTENTION YOU!!!
;
; THESE CONSTANTS MAY NEED TO BE MODIFIED DEPENDING ON YOUR SETTINGS
;
; If the script does not work, take a screenshot of the crafting menu 
; and open it in paint. Check the coordinates of the locations listed
; below and correct any discrepencies.
;
; *note: coordinates are take from the center of the squares.

INV_X 			= 675 	; x-value of the top-left inventory slot
INV_Y 			= 575 	; y-value of the top-left inventory slot
CRAFT_X 		= 760 	; x-value of the top-left crafting bench slot
CRAFT_Y 		= 310 	; y-value of the top-left crafting bench slot
CRAFT_I_X		= 1030	; x-value of the 2x2 crafting slot 
CRAFT_I_Y 		= 310	; y-value of the 2x2 crafting slot
CRAFT_OUT_X 	= 1130 	; x-value of crafting bench output slot
CRAFT_OUT_Y 	= 380 	; y-value of crafting bench output slot
CRAFT_I_OUT_X	= 1250 	; x-value of the 2x2 crafting output slot
CRAFT_I_OUT_Y	= 350 	; y-value of the 2x2 crafting output slot
SQUARE_SIZE 	= 70	; The width of a inventory square


!1:: ; Craft top 9 inventory slots into a 3x3 recipe

	Sleep 50 				; Delay to make the hotkey less jarring
	Craft3x3(0)
	Sleep 50 				; Delay to make the hotkey less jarring
	Send {Esc}
	Return

!2:: ; Craft all rows of inventory besides hotbar into a 3x3 recipe
	
	index = 0

	Sleep 50 				; Delay to make the hotkey less jarring
	Loop, 3
	{
		Craft3x3(index)
		index := index + 1
	}	
	Sleep 50 				; Delay to make the hotkey less jarring
	Send {Esc}
	Return

!3:: ; Craft first eight slots in the first row into a 2x2 recipe

	Sleep 50 				; Delay to make the hotkey less jarring
	Craft2x2(0)
	Sleep 50 				; Delay to make the hotkey less jarring
	Send {Esc}
	Return

!r:: ; Craft first eight slots from top 3 rows into a 2x2 recipe

	index = 0

	Sleep 50 				; Delay to make the hotkey less jarring
	Loop, 3
	{
		Craft2x2(index)
		index := index + 1
	}
	Sleep 50 				; Delay to make the hotkey less jarring
	Send {Esc}
	Return

; Moves item from start coords to destination cords
MoveTo(start_x, start_y, dest_x, dest_y)
{
	Click, %start_x%, %start_y%
	Sleep, 10
	Click, %dest_x%, %dest_y%
	Sleep, 10
}

; Completes a crafting action, given the location of the output slot
FinishCraft(x, y)
{
	Mousemove, %x%, %y%
	Sleep 100
	Send {Shift down}{LButton down}
	Sleep 125
	Send {Shift up}{LButton up}
}

; Crafts a 3x3 recipe from a row at 'row_index'
Craft3x3(row_index)
{
	global INV_X, INV_Y, CRAFT_X, CRAFT_Y, SQUARE_SIZE
	global CRAFT_OUT_X, CRAFT_OUT_Y

	_inv_x 		:= INV_X
	_inv_y 		:= INV_Y + SQUARE_SIZE * row_index
	_craft_x	:= CRAFT_X
	_craft_y 	:= CRAFT_Y

	Loop, 3
	{
		Loop, 3
		{
			MoveTo(_inv_x, _inv_y, _craft_x, _craft_y)

			_inv_x 		:= _inv_x + SQUARE_SIZE
			_craft_x 	:= _craft_x + SQUARE_SIZE
		} 
		_craft_x := CRAFT_X 
		_craft_y := _craft_y + SQUARE_SIZE 
	}
	FinishCraft(CRAFT_OUT_X, CRAFT_OUT_Y)
}

; Crafts a 2x2 recipe from a row at 'row_endex'
Craft2x2(row_index)
{
	global INV_X, INV_Y, SQUARE_SIZE, CRAFT_I_X, CRAFT_I_Y
	global CRAFT_I_OUT_X, CRAFT_I_OUT_Y

	_inv_x 		:= INV_X
	_inv_y 		:= INV_Y + SQUARE_SIZE * row_index
	_craft_x 	:=
	_craft_y 	:= CRAFT_I_Y

	Loop, 2
	{
		_craft_x	:= CRAFT_I_X
		Loop, 2
		{
			MoveTo(_inv_x, _inv_y, _craft_x, _craft_y)
			_inv_x 		:= _inv_x + SQUARE_SIZE

			MoveTo(_inv_x, _inv_y, _craft_x, _craft_y + SQUARE_SIZE)
			_inv_x 		:= _inv_x + SQUARE_SIZE

			_craft_x	:= _craft_x + SQUARE_SIZE
		}
		FinishCraft(CRAFT_I_OUT_X, CRAFT_I_OUT_Y)
	}
}
