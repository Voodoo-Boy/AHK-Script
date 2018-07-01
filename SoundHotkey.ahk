;;;; Customized AHK script for sound hotkey based on "Volume On-Screen-Display (OSD) by Rajat"
;;;; Date: 2018/07/01
;;;; Author: Han Wang

;; Customized Settings.
; The percentage by which to raise or lower the volume each time.
VolStep = 1
; Voluem info bar display time(ms).
VolDisplayTime = 1100

; Hotkey to adjust volume.
Hotkey, #PgUp, MasterVolUp		; Win+PageUp
Hotkey, #PgDn, MasterVolDown	; Win+PageDown

; Execution Part.
; AHK Script Settings.
#SingleInstance	Force		; Display dialog when the script is launched while a previous instance of itself is already running.
SetBatchLines, 10ms		; Script loop sleep time.
Return

; Vol up and show vol status bar.
MasterVolUp:
SoundSet, +%VolStep%
Gosub, ShowMasterVolBar
return

; Vol down and show vol status bar.
MasterVolDown:
SoundSet, -%VolStep%
Gosub, ShowMasterVolBar
return

ShowMasterVolBar:
; To prevent the "flashing" effect, only create the bar window if it doesn't already exist.
IfWinNotExist, MasterVolBar
{
	MasterVolBarParam = B W200 H26 ZX0 ZY0 ZW200 ZH14 CBTeal CTBlack CWSilver FS10
	Progress, %MasterVolBarParam%, %MasterVolValue%, , MasterVolBar, Lucida Console
}
; Get current volume.
SoundGet, MasterVolValue, Master
MasterVolValue := Floor(MasterVolValue)
; Display volume info.
Progress, %MasterVolValue%, %MasterVolValue%, , MasterVolBar
; Set timer to turn off the volume display bar.
SetTimer, MasterVolBarOff, %VolDisplayTime%
return

; Display bar timer.
MasterVolBarOff:
SetTimer, MasterVolBarOff, Off
Progress, Off
return