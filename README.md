# Mute Microphone with AHK

This is an AutoHotkey script to mute or unmute microphone, using Media Pause button/event. This stops microphone input on any conferencing tools, like Zoom, Hangout, Messenger, MS Teams.

Media Pause is available as a shortcut on many keyboards and Bluetooth headphones (eg. Bose, Sony etc).

After starting the script an icon should be in the tray. 

Icon colors:
* Yellow icon means that script is suspended (temporarily deactivated, Media Button resumes it's normal functionality)
* Green icon when microphone is active
* Red icon when microphone is mute (not active).

Tooltip when hovering mouse over the icon will give the current microphone state.

Right click on the icon gives:
* Name of currently used capture device (microphone). Checked if microphone is active, unchecked if mute. Can be used to manualy mute/unmute the microphone. 
* Suspend to stop the script for intercepting Media Pause event
* Exit

When script is active (not suspended) a press on Media Pause button (or any other way to get the event) will mute/unmute microphone on the system level.
The script periodically (every 5 seconds) checks the status od capture device (microphone), and changes the icon color  

Installation: 
* AutoHotKey [https://www.autohotkey.com] (software tested on 1.1.33, AHK is avaliable as installable exe or standalone ZIP)
* Vista Audio Control Functions for AutoHotKey [https://github.com/ahkscript/VistaAudio] (VA.ahk is needed in the same directory as the files from this repository)

Note: you can AHK compile it, and have a standalone .exe file. Don't use compression when compiling as most antivirus software detects it as malware.

Reason for this script:<br />
After making the similar script for MS Teams [https://github.com/stajp/Teams_mute_AHK] (read more about the motivation for the script), I started to have inquires about other video/audio conference tools. As each is a little bit different, I decided to make it universal, and mute the microphone as is.
Two additional pluses after I've done this:
* I found out that I have a microphone turn on/off button on my laptop, and that it has a small signalling LED. Note that sometimes the LED doesn't follow the change in this script.
* I found out I can change this script to mute and unmute microphone with different key combinations, which is useful when macro keyboards are used.

Note2: there are applications which do not allow Media Button to be intercepted. One of them is Voice Recorder. Use manual mute/unmute (right click on tray icon, click on the name of the captue device).

Change script to suit your keyboard combination.

