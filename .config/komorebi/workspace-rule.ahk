; You can generate a fresh version of this file with "komorebic ahk-library"
#Include %A_ScriptDir%\komorebic.lib.ahk


SysGet, MonitorCount, MonitorCount
Loop MonitorCount
{
; Ensure there is 5 workspace created on each monitor
EnsureWorkspaces(A_Index-1, 5)
WorkspaceName(A_Index-1, 5*A_Index-5, "%A_Index%-code")
WorkspaceName(A_Index-1, 5*A_Index-4, "%A_Index%-browse")
WorkspaceName(A_Index-1, 5*A_Index-3, "%A_Index%-full")
WorkspaceName(A_Index-1, 5*A_Index-2, "%A_Index%-sns")
WorkspaceName(A_Index-1, 5*A_Index-1, "%A_Index%-media")
}

If (MonitorCount == 1)
{
WorkspaceRule("exe", "wezterm-gui.ex", 0, 0)

WorkspaceRule("exe", "vivaldi.exe", 0, 1)
WorkspaceRule("exe", "firefox.exe", 0, 1)

WorkspaceRule("exe", "krita.exe", 0, 2)
WorkspaceRule("exe", "blender.exe", 0, 2)
WorkspaceRule("exe", "Unity Hub.exe", 0, 2)
WorkspaceRule("exe", "Unity.exe", 0, 2)
WorkspaceRule("exe", "Steam.exe", 0, 2)
WorkspaceRule("exe", "obs64.exe", 0, 2)

WorkspaceRule("exe", "Discord.exe", 0, 3)
WorkspaceRule("exe", "slack.exe", 0, 3)
WorkspaceRule("exe", "Ferdium.exe", 0, 3)

WorkspaceRule("exe", "Spotify.exe", 0, 4)
}
