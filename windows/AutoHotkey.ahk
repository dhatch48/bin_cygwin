; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.

#z::Run https://www.autohotkey.com/docs/Hotkeys.htm

; Use Window Spy to get window/process info
;^!n::
;IfWinExist Untitled - Notepad
;	WinActivate
;else
;	Run Notepad
;return

; My quick VIM movement
;;;;;;;;;;;;;;;;;;;;;;;;
CapsLock & h::Left
CapsLock & l::Right
CapsLock & k::Up
CapsLock & j::Down
CapsLock & i::Home
CapsLock & n::End
CapsLock & b::PgUp
CapsLock & f::PgDn

; Others like POK3R keyboard https://github.com/davidjenni/pok3r-layouts
; Caps & ; = shift + insert
CapsLock & SC027::+Insert
CapsLock & '::Del
CapsLock & y::Run Calc
CapsLock & t::Run notepad++

; middle click to paste
;MButton::^v

; Hotstrings
;;;;;;;;;;;;;;;;;;;;;;;;
::btw::by the way
return
::gm::good morning
return
::idk::I don't know
return
::yw::you're welcome
return
::ty::thank you
return
::ct::cool, thanks
return
:*:dh@::david.hatch@carlsbadca.gov ; asterisk means an ending character isn not required
return

::]d::
FormatTime, CurrentDateTime,, MM/dd/yyyy
SendInput %CurrentDateTime%
return

::]dt::  ; This hotstring replaces "]d" with the current date and time via the commands below.
FormatTime, CurrentDateTime,, MM/dd/yyyy HH:mm:ss  ; It will look like 09/01/2005 13:53:48
SendInput %CurrentDateTime%
return

::]dtu::
FormatTime, CurrentDateTime,, yyyy-MM-dd_HH_mm_ss
SendInput %CurrentDateTime%
return

; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.
