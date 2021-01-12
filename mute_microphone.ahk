#Include VA.ahk
#Persistent

SetTimer, CheckCaptureStatus, 5000

Menu, Tray, NoStandard

;get capture device and status
VA_dev := VA_GetDevice("capture:1")
CaptureDeviceName := VA_GetDeviceName(VA_dev)
Menu, Tray, Add, %CaptureDeviceName%, CaptureDevice
muteStatus := VA_GetMute(1, VA_dev)
ObjRelease(VA_dev)

; set Menu in tray
Menu, Tray, Add, 
Menu, Tray, Add, &Suspend,ContextMenu
Menu, Tray, Add, E&xit,ContextMenu
Menu, Tray, Default, E&xit

; set icon according to current capture device status
setMenuIcon(muteStatus)
Return

ContextMenu:
If (A_ThisMenuItem = "&Suspend")
{
  If (A_IsSuspended)
  {
    Suspend, Off
    Menu, Tray, Uncheck, &Suspend
	VA_dev := VA_GetDevice("capture:1")
    muteStatus := VA_GetMute(1, VA_dev)
	ObjRelease(VA_dev)
    setMenuIcon(muteStatus)
  }
  Else
  {
    Menu, Tray, Check,&Suspend
    Menu, Tray, Icon, Mute_SUSPENDED.ico,,1
    Suspend,On
  }
  Return
}
If (A_ThisMenuItem="E&xit")
  ExitApp

Media_Play_Pause::                    ; QC35II middle button (between volume + and -)
  gosub Run_Mute_Toggle
  Return

CaptureDevice:
  gosub Run_Mute_Toggle
  Return

Run_Mute_Toggle:
  If (!A_IsSuspended) {
    ; get status currently active capture device
    VA_dev := VA_GetDevice("capture:1")
    muteStatus := VA_GetMute(1, VA_dev)
	
	; uncomment if you want sound warning when you're getting unmuted
	;if muteStatus {
	;  SoundBeep 500,750
    ;}
	
	; invert current status
	VA_SetMute(!muteStatus, 1, VA_dev)
	muteStatus := VA_GetMute(1, VA_dev)
	ObjRelease(VA_dev)

	; uncomment if you want sound warning when you're muted 
	;if muteStatus {
	;	SoundBeep 1200,750
	;}
	
	; set menu icon, tray text and tooltip
	setMenuIcon(muteStatus)
	Return
  }

CheckCaptureStatus:
  VA_dev := VA_GetDevice("capture:1")
  muteStatus := VA_GetMute(1, VA_dev)
  ObjRelease(VA_dev)
  setMenuIcon(muteStatus)
  Return

setMenuIcon(muteStatus) {
  Global CaptureDeviceName
  If muteStatus {
    If (!A_IsSuspended) {  
      Menu, Tray, Icon, Mike_OFF.ico
	}
	Menu, Tray, Tip, Microphone muted
	Menu,Tray, Uncheck, %CaptureDeviceName%
  }
  Else {
	If (!A_IsSuspended) {
	  Menu, Tray, Icon, Mike_ON.ico
	}
	Menu, Tray, Tip, Microphone online
	Menu, Tray, Check, %CaptureDeviceName%
  }
  ToolTip, % (muteStatus ? "Microphone muted" : "Microphone online")
  SetTimer, RemoveMuteMicTooltip, 700
  
  
  Return
}

RemoveMuteMicTooltip:
  SetTimer, RemoveMuteMicTooltip, Off
  ToolTip
  Return