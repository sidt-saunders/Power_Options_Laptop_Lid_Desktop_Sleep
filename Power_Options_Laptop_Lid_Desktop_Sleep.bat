@ECHO OFF
SET ThisScriptsDirectory=\\USALPLATP01\DropBox\Sidt_Saunders\Scripts\Script_Files\Power_Options_Laptop_Lid_Desktop_Sleep\
SET PowerShellScriptPath=%ThisScriptsDirectory%Power_Options_Laptop_Lid_Desktop_Sleep.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%PowerShellScriptPath%'";