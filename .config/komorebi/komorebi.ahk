#SingleInstance Force

; You can generate a fresh version of this file with "komorebic ahk-library"
#Include %A_ScriptDir%\komorebic.lib.ahk
; https://github.com/LGUG2Z/komorebi/#generating-common-application-specific-configurations
#Include %A_ScriptDir%\komorebi.generated.ahk

; Default to minimizing windows when switching workspaces
WindowHidingBehaviour("minimize")

; Set cross-monitor move behaviour to insert instead of swap
CrossMonitorMoveBehaviour("insert")

; Enable hot reloading of changes to this file
WatchConfiguration("enable")

; Ensure there is 1 workspace created on monitor 0
EnsureWorkspaces(0, 1)

; Configure the invisible border dimensions
InvisibleBorders(7, 0, 14, 7)

; Configure the 1st workspace
WorkspaceName(0, 0, "I")

; Uncomment the next two lines if you want a visual border drawn around the focused window
ActiveWindowBorderColour(66, 165, 245, "single") ; this is a nice blue colour
ActiveWindowBorder("enable")

; Allow komorebi to start managing windows
CompleteConfiguration()

; Change the focused window, LeftAlt + Vim direction keys (HJKL)
<!h::
Focus("left")
return

<!j::
Focus("down")
return

<!k::
Focus("up")
return

<!l::
Focus("right")
return

; Move the focused window in a given direction, LeftAlt + Shift + Vim direction keys (HJKL)
<!+h::
Move("left")
return

<!+j::
Move("down")
return

<!+k::
Move("up")
return

<!+l::
Move("right")
return

<!^l::
CycleWorkspace("next")
return

<!^p::
CycleWorkspace("previous")
return

<!^k::
CycleSendToWorkspace("next")
return

<!^j::
CycleSendToWorkspace("previous")
return

; Toggle focused window floatly, super + space
<!f::
ToggleFloat()
return

<!+f::
ToggleMaximize()
return

<!n::
CycleMonitor("next")
return

<!p::
CycleMonitor("previous")
return

<!^1::
SendToMonitor(1)
return

<!^2::
SendToMonitor(2)
return

<!^3::
SendToMonitor(3)
return

; Forcus workspace
<!1::
FocusWorkspace(1)
return

<!2::
FocusWorkspace(2)
return

<!3::
FocusWorkspace(3)
return

<!4::
FocusWorkspace(4)
return

<!5::
FocusWorkspace(5)
return

<!6::
FocusWorkspace(6)
return

<!7::
FocusWorkspace(7)
return

; Send window to workspace
<!+1::
SendToWorkspace(1)
return

<!+2::
SendToWorkspace(2)
return

<!+3::
SendToWorkspace(3)
return

<!+4::
SendToWorkspace(4)
return

<!+5::
SendToWorkspace(5)
return

<!+6::
SendToWorkspace(6)
return

<!+7::
SendToWorkspace(7)
return

; There are many more commands that you can bind to whatever keys combinations you want<!
;
; Have a look at the komorebic.lib.ahk file to see which arguments are required by different commands
;
; If you want more information about a command, you can run every komorebic command with "--help"
;
; For example, if you see this in komorebic.lib.ahk
;
; WorkspaceLayout(monitor, workspace, value) {
;    Run, komorebic.exe workspace-layout %monitor% %workspace% %value%, , Hide
; }
;
; Just run "komorebic.exe workspace-layout --help" and you'll get all the information you need to use the command
;
; komorebic.exe-workspace-layout
; Set the layout for the specified workspace
;
; USAGE:
;    komorebic.exe workspace-layout <MONITOR> <WORKSPACE> <VALUE>
;
; ARGS:
;    <MONITOR>      Monitor index (zero-indexed)
;    <WORKSPACE>    Workspace index on the specified monitor (zero-indexed)
;    <VALUE>        [possible values: bsp, columns, rows, vertical-stack, horizontal-stack, ultrawide-vertical-stack]
;
; OPTIONS:
;    -h, --help    Print help information
