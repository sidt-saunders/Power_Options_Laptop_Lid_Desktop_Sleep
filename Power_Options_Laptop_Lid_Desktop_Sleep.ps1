#Change power settings on laptops and desktops
#If device is a desktop, change sleep to never
#if device is a laptop, change closing the lid to do nothing, and change pressing sleep button to do nothing

#----------
#Functions
#-----------

Function ExitScript() { #Standard response for exiting script without running anything
    Write-Host "`n`tExiting Script.`n`tNo settings have been modified.`n" -ForegroundColor DarkGreen
    Start-Sleep -Seconds 5
    Exit
}

Function NotValidSelection() { #Standard response for not making a valid selection
    Write-Host "`n`tPlease enter a valid selection. Script will now exit.`n" -ForegroundColor DarkRed
    Start-Sleep -Seconds 3
    Exit
}

Function DeviceIsDesktop() { #Settings to change if device is desktop
    cmd /c powercfg /x standby-timeout-ac 0
    Write-Host "`n`tDesktop will no longer go to sleep.`n`tScript will exit in 5 seconds.`n" -ForegroundColor DarkGreen
    Start-Sleep -Seconds 5
    Exit-PSSession
}

Function DeviceIsLaptop() { #Settings to change if device is laptop
    cmd /c powercfg /setACvalueIndex scheme_current sub_buttons lidAction 0
    cmd /c powercfg /SetDCValueIndex scheme_current sub_buttons lidAction 0
    cmd /c powercfg /setACvalueIndex scheme_current sub_buttons sbuttonaction 0
    cmd /c powercfg /SetDCValueIndex scheme_current sub_buttons sbuttonaction 0
    Write-Host "`n`tLaptop will no longer go to sleep IMMEDIATELY when closing the lid.`n`tYou will have 15 minutes before laptop goes to sleep.`n`n`tScript will exit in 8 seconds.`n" -ForegroundColor DarkGreen
    Start-Sleep -Seconds 8
    Exit-PSSession
}

Function SwitchSelection() { #Change setting per type of device
    Switch ($DeviceType) {
        1 {DeviceIsDesktop}
        2 {DeviceIsLaptop}

        Default {Write-Host "Unknown Device. Power settings unchanged" -ForegroundColor DarkRed}
    }
}

Function ConfirmSelection() { #Check if user wants to go along with this
    $ConfirmProceed = Read-Host -Prompt "Please confirm you would like to continue with updating your power settings. (Y/N) "
    If ($ConfirmProceed -eq "n" -or $ConfirmProceed -eq "N") {
        ExitScript
    }
    If ($ConfirmProceed -eq "y" -or $ConfirmProceed -eq "Y") {
        SwitchSelection
    }
    Else {
        NotValidSelection
    }
}

#----------
#Script
#----------

Clear-Host

#Check if device is a laptop or desktop
$DeviceType = (Get-CimInstance -Class Win32_ComputerSystem -Property PCSystemType).PCSystemType

Write-Host "`n`tThis script will update the power settings on your laptop or desktop.`n"
Write-Host "`tOn your laptop, it will disable the laptop from going to sleep IMMEDIATELY when closing the lid.`n`tThe laptop will still go to sleep after 15 minutes.`n" -ForegroundColor Blue
Write-Host "`tOn your desktop, it will disable going to sleep at all.`n" -ForegroundColor Cyan
Start-Sleep -Seconds 5

ConfirmSelection

Exit