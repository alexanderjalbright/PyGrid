from win32api import GetSystemMetrics
import time
from pynput import keyboard, mouse

# Config
grid = [12,6]

# Get monitor resolution
res = [GetSystemMetrics(0),GetSystemMetrics(1)]

def convertGridToPixel(grid_start_x, grid_start_y, grid_end_x, grid_end_y):    
    ratio_x = res[0]/grid[0]
    ratio_y = res[1]/grid[1]

    pix_start_x = (ratio_x*grid_start_x + 10)
    pix_start_y = (ratio_y*grid_start_y + 10)   
    pix_end_x = ((ratio_x*grid_end_x) + 10) 
    pix_end_y = (ratio_y*grid_end_y + 10)

    # print (f'[{pix_start_x},{pix_start_y}] -> [{pix_end_x},{pix_end_y}]')

    return [pix_start_x, pix_start_y, pix_end_x, pix_end_y]

class position:
    def __init__(self, start, end):
        pixels = convertGridToPixel(start[0], start[1], end[0], end[1])
        self.start_x = pixels[0]
        self.start_y = pixels[1]
        self.end_x = pixels[2] 
        self.end_y = pixels[3]

def do_position(pos):
    my_keyboard = keyboard.Controller()
    my_mouse = mouse.Controller()

    # Grab window
    my_mouse.press(mouse.Button.left)
    time.sleep(0.75)
    my_mouse.move(5,5)
    my_mouse.move(-5,-5)

    # Move to start
    my_mouse.position = (pos.start_x, pos.start_y)
    time.sleep(0.2)

    # Set start
    my_keyboard.press(keyboard.Key.space)
    my_keyboard.release(keyboard.Key.space)
    time.sleep(0.2)

    # Move to end
    my_mouse.position = (pos.end_x, pos.end_y)
    time.sleep(0.2)

    # Set end
    my_mouse.release(mouse.Button.left)

def switch(argument):
    switcher = {
        "1": position([0,0],[4,2]),
        "2": position([5,0],[6,2]),
        "3": position([7,0],[9,1]),
        "4": position([7,2],[9,2]),
        "5": position([10,0],[11,2]),        
        "6": position([0,3],[6,5]),
        "7": position([7,3],[12,5])
    }
    return switcher[argument]

        
def on_press(key):
    try:
        request_position = key.char
        if request_position is not None:
            do_position(switch(request_position))
    except AttributeError:
        print('special key {0} pressed'.format(
            key))

def on_release(key):
        # Stop listener
        return False

time.sleep(0.5)
# Collect events until released
with keyboard.Listener(
        on_press=on_press,
        on_release=on_release) as listener:
    listener.join()