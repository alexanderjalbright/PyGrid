#SingleInstance, force

CenterWindow(WinTitle)
{
    WinGetPos,,, Width, Height, %WinTitle%
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
}

getX(gridNum)
{
    return A_ScreenWidth/12*gridNum
}

getY(gridNum)
{
    return (A_ScreenHeight-40)/6*gridNum
}

move(ahkClass, ahkExe, startX, startY, endX, endY)
{
    IfWinExist, ahk_class %ahkClass% ahk_exe %ahkExe%
    {
        WinActivate
        WinMove, ahk_class %ahkClass% ahk_exe %ahkExe%,, getX(startX), getY(startY), getX(endX-startX), getY(endY-startY)
        return
    }
}

#Tab::
    ; VS CODE
    move("Chrome_WidgetWin_1", "Code.exe", 0, 3, 7, 6 )
    ; Firefox
    move("MozillaWindowClass", "firefox.exe", 7, 3, 12, 6 )
    ; Explorer
    move("CabinetWClass", "explorer.exe", 5, 0, 7, 3 )
    
return

#`::
    WinGetActiveTitle, Title
    CenterWindow(Title)
return