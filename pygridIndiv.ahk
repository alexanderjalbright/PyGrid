#SingleInstance, force

; Set up variables to store the coordinates of the grid
grid_columns := 9
grid_rows := 6

; Set up a variable to store the number of key presses
num_presses := 0

; Set up a variable to store the coordinates of the grid
coords := ""

; Set up a hotkey to trigger when the Ctrl, Alt, Windows key, and number keys are pressed
^!#1::
^!#2::
^!#3::
^!#4::
^!#5::
^!#6::
^!#7::
^!#8::
^!#9::
^!#0::
  num_presses += 1
  coords .= A_ThisHotkey
  ; If 4 key presses have been made within 5 seconds, move the window
  if (num_presses = 1) {
    SetTimer, Reset, 5000
  }
  if (num_presses = 4) {
    SetTimer, MoveWindow, 200
  }
  return

Reset:
  ; MsgBox, , , "RESET",
  num_presses = 0
  coords := ""
  SetTimer, Reset, off
  return 

MoveWindow:
  SetTimer, MoveWindow, off
  
  ; Extract grid inputs from key presses
  x1 := SubStr(coords, 4, 1)
  y1 := SubStr(coords, 8, 1)
  x2 := SubStr(coords, 12, 1)
  y2 := SubStr(coords, 16, 1)
  
  ; Adjust for max grid size
  corrected_x1 := Min(x1, grid_columns) - 1
  corrected_y1 := Min(y1, grid_rows) - 1
  corrected_x2 := Min(x2, grid_columns)
  corrected_y2 := Min(y2, grid_rows)
  
  ; Calculate grid cell size
  grid_width := A_ScreenWidth / grid_columns
  grid_height := A_ScreenHeight / grid_rows
  
  ; Convert the coordinates from the key presses to actual pixel coordinates
  x := corrected_x1 * (grid_width)
  y := corrected_y1 * (grid_height)
  w := (corrected_x2 - corrected_x1)  * (grid_width)
  h := (corrected_y2 - corrected_y1) * (grid_height)
  
  ; Move the window to the new coordinates
  WinMove, A, , %x%, %y%, %w%, %h%
  
  ; Reset the variables
  SetTimer, Reset, 200
  return




