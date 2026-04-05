# ============================================================
#         Jayden's Sauce — Fortnite PC Optimizer
#         Right-click > Run with PowerShell (as Admin)
# ============================================================

# Auto-elevate to Admin
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ============================================================
# THEME COLORS
# ============================================================
$BG        = [System.Drawing.Color]::FromArgb(0, 0, 0)
$Panel     = [System.Drawing.Color]::FromArgb(12, 12, 12)
$Border    = [System.Drawing.Color]::FromArgb(35, 35, 35)
$Accent    = [System.Drawing.Color]::FromArgb(0, 212, 255)
$Orange    = [System.Drawing.Color]::FromArgb(255, 107, 0)
$Green     = [System.Drawing.Color]::FromArgb(0, 255, 136)
$TextColor = [System.Drawing.Color]::White
$Dim       = [System.Drawing.Color]::FromArgb(120, 120, 120)
$Red       = [System.Drawing.Color]::FromArgb(255, 51, 85)

$TitleFont   = New-Object System.Drawing.Font("Consolas", 22, [System.Drawing.FontStyle]::Bold)
$SubFont     = New-Object System.Drawing.Font("Consolas", 7, [System.Drawing.FontStyle]::Regular)
$HeaderFont  = New-Object System.Drawing.Font("Consolas", 9, [System.Drawing.FontStyle]::Bold)
$NormalFont  = New-Object System.Drawing.Font("Consolas", 8, [System.Drawing.FontStyle]::Regular)
$SmallFont   = New-Object System.Drawing.Font("Consolas", 7, [System.Drawing.FontStyle]::Regular)
$LogFont     = New-Object System.Drawing.Font("Consolas", 8, [System.Drawing.FontStyle]::Regular)
$BtnFont     = New-Object System.Drawing.Font("Consolas", 9, [System.Drawing.FontStyle]::Bold)

# ============================================================
# MAIN FORM
# ============================================================
$Form = New-Object System.Windows.Forms.Form
$Form.Text              = "Jayden's Sauce — Fortnite Optimizer"
$Form.Size              = New-Object System.Drawing.Size(780, 740)
$Form.StartPosition     = "CenterScreen"
$Form.BackColor         = $BG
$Form.ForeColor         = $TextColor
$Form.FormBorderStyle   = "FixedSingle"
$Form.MaximizeBox       = $false
$Form.Font              = $NormalFont

# ============================================================
# HEADER
# ============================================================
$HeaderPanel = New-Object System.Windows.Forms.Panel
$HeaderPanel.Size      = New-Object System.Drawing.Size(780, 80)
$HeaderPanel.Location  = New-Object System.Drawing.Point(0, 0)
$HeaderPanel.BackColor = $BG
$Form.Controls.Add($HeaderPanel)

$TitleLabel = New-Object System.Windows.Forms.Label
$TitleLabel.Text      = "Jayden's Sauce"
$TitleLabel.Font      = $TitleFont
$TitleLabel.ForeColor = $Accent
$TitleLabel.AutoSize  = $true
$TitleLabel.Location  = New-Object System.Drawing.Point(20, 12)
$HeaderPanel.Controls.Add($TitleLabel)

$SubLabel = New-Object System.Windows.Forms.Label
$SubLabel.Text      = "// FORTNITE PC OPTIMIZER — RIGHT-CLICK > RUN AS ADMINISTRATOR //"
$SubLabel.Font      = $SubFont
$SubLabel.ForeColor = $Dim
$SubLabel.AutoSize  = $true
$SubLabel.Location  = New-Object System.Drawing.Point(22, 52)
$HeaderPanel.Controls.Add($SubLabel)

# Divider line
$Divider = New-Object System.Windows.Forms.Panel
$Divider.Size      = New-Object System.Drawing.Size(780, 1)
$Divider.Location  = New-Object System.Drawing.Point(0, 78)
$Divider.BackColor = $Accent
$Form.Controls.Add($Divider)

# ============================================================
# SCROLL PANEL (holds all sections)
# ============================================================
$Scroll = New-Object System.Windows.Forms.Panel
$Scroll.Location    = New-Object System.Drawing.Point(0, 80)
$Scroll.Size        = New-Object System.Drawing.Size(780, 450)
$Scroll.AutoScroll  = $true
$Scroll.BackColor   = $BG
$Form.Controls.Add($Scroll)

$yPos = 10
$checkboxes = @{}

function Add-Section {
    param($title, $color, $items)
    
    # Section header
    $sHdr = New-Object System.Windows.Forms.Panel
    $sHdr.Location  = New-Object System.Drawing.Point(10, $script:yPos)
    $sHdr.Size      = New-Object System.Drawing.Size(740, 28)
    $sHdr.BackColor = [System.Drawing.Color]::FromArgb(18,18,18)
    
    $accentBar = New-Object System.Windows.Forms.Panel
    $accentBar.Location  = New-Object System.Drawing.Point(0, 0)
    $accentBar.Size      = New-Object System.Drawing.Size(3, 28)
    $accentBar.BackColor = $color
    $sHdr.Controls.Add($accentBar)
    
    $sLabel = New-Object System.Windows.Forms.Label
    $sLabel.Text      = "  $title"
    $sLabel.Font      = $HeaderFont
    $sLabel.ForeColor = $color
    $sLabel.Location  = New-Object System.Drawing.Point(3, 5)
    $sLabel.Size      = New-Object System.Drawing.Size(720, 18)
    $sHdr.Controls.Add($sLabel)
    
    $Scroll.Controls.Add($sHdr)
    $script:yPos += 30

    foreach ($item in $items) {
        $row = New-Object System.Windows.Forms.Panel
        $row.Location  = New-Object System.Drawing.Point(10, $script:yPos)
        $row.Size      = New-Object System.Drawing.Size(740, 42)
        $row.BackColor = [System.Drawing.Color]::FromArgb(8,8,8)
        $row.Cursor    = [System.Windows.Forms.Cursors]::Hand

        $cb = New-Object System.Windows.Forms.CheckBox
        $cb.Location  = New-Object System.Drawing.Point(10, 12)
        $cb.Size      = New-Object System.Drawing.Size(16, 16)
        $cb.BackColor = [System.Drawing.Color]::FromArgb(8,8,8)
        $cb.ForeColor = $Accent
        if ($item.Default) { $cb.Checked = $true }
        $row.Controls.Add($cb)
        $script:checkboxes[$item.Key] = $cb

        $nameLabel = New-Object System.Windows.Forms.Label
        $nameLabel.Text      = $item.Name
        $nameLabel.Font      = $HeaderFont
        $nameLabel.ForeColor = $TextColor
        $nameLabel.Location  = New-Object System.Drawing.Point(34, 6)
        $nameLabel.Size      = New-Object System.Drawing.Size(680, 16)
        $row.Controls.Add($nameLabel)

        $descLabel = New-Object System.Windows.Forms.Label
        $descLabel.Text      = $item.Desc
        $descLabel.Font      = $SmallFont
        $descLabel.ForeColor = $Dim
        $descLabel.Location  = New-Object System.Drawing.Point(34, 23)
        $descLabel.Size      = New-Object System.Drawing.Size(680, 14)
        $row.Controls.Add($descLabel)

        # Hover effect
        $row.Add_MouseEnter({ $this.BackColor = [System.Drawing.Color]::FromArgb(18,18,18) })
        $row.Add_MouseLeave({ $this.BackColor = [System.Drawing.Color]::FromArgb(8,8,8) })
        $row.Add_Click({ $cb.Checked = !$cb.Checked })

        $Scroll.Controls.Add($row)
        $script:yPos += 44
    }
    $script:yPos += 8
}

# ============================================================
# SECTIONS + OPTIONS
# ============================================================
Add-Section "RESTORE POINT" $Green @(
    @{ Key="restore";      Name="Create System Restore Point First";           Desc="Safety net — lets you undo all changes via rstrui.exe";              Default=$true }
    @{ Key="sys-protect";  Name="Enable System Protection on C: (if disabled)"; Desc="Required for restore points to work";                               Default=$true }
)

Add-Section "ZERO INPUT DELAY — CONTROLLER + KBM" $Orange @(
    @{ Key="mouse-accel";  Name="Disable Mouse Acceleration";                  Desc="Removes Enhance Pointer Precision — 1:1 raw movement";               Default=$true }
    @{ Key="raw-input";    Name="Raw Mouse Input Fix";                          Desc="Bypasses Windows pointer filtering entirely";                        Default=$true }
    @{ Key="usb-suspend";  Name="Disable USB Selective Suspend";                Desc="Stops controller/mouse sleeping mid-game";                           Default=$true }
    @{ Key="hid-poll";     Name="Optimize HID Input Polling";                   Desc="Forces USB devices to report at maximum rate";                       Default=$false }
)

Add-Section "WINDOWS SYSTEM TWEAKS" $Accent @(
    @{ Key="power-plan";   Name="High Performance Power Plan";                  Desc="Forces CPU to max clock speed — no throttling";                      Default=$true }
    @{ Key="game-mode";    Name="Enable Windows Game Mode";                     Desc="Prioritizes game resources over background processes";               Default=$true }
    @{ Key="game-dvr";     Name="Disable Xbox Game DVR / Game Bar";             Desc="Stops background screen recording stealing FPS";                     Default=$true }
    @{ Key="visuals";      Name="Disable Windows Animations";                   Desc="Removes window effects — frees CPU cycles";                          Default=$true }
    @{ Key="menu-delay";   Name="Set Menu Delay to 0ms";                        Desc="Removes Start Menu and right-click lag";                             Default=$true }
    @{ Key="timer-res";    Name="Optimize Timer Resolution";                    Desc="Improves Windows scheduler precision for smoother frames";           Default=$false }
    @{ Key="fs-opt";       Name="Disable Fullscreen Optimizations (Fortnite)";  Desc="Prevents DWM from intercepting exclusive fullscreen";                Default=$true }
    @{ Key="gpu-sched";    Name="Set GPU/CPU Priority to High";                 Desc="Forces games scheduling category to High in SystemProfile";          Default=$true }
)

Add-Section "NETWORK LATENCY" $Accent @(
    @{ Key="nagle";        Name="Disable Nagle's Algorithm";                    Desc="Reduces ping spikes — better packet send timing";                    Default=$true }
    @{ Key="net-throttle"; Name="Disable Network Throttling";                   Desc="Removes Windows multimedia network bandwidth cap";                    Default=$true }
    @{ Key="tcp-tune";     Name="Disable TCP Auto-Tuning";                      Desc="Fixes receive window thrashing on fast connections";                  Default=$false }
)

# ============================================================
# PROGRESS BAR AREA
# ============================================================
$ProgressPanel = New-Object System.Windows.Forms.Panel
$ProgressPanel.Location  = New-Object System.Drawing.Point(0, 530)
$ProgressPanel.Size      = New-Object System.Drawing.Size(780, 6)
$ProgressPanel.BackColor = [System.Drawing.Color]::FromArgb(20,20,20)
$Form.Controls.Add($ProgressPanel)

$ProgressBar = New-Object System.Windows.Forms.Panel
$ProgressBar.Location  = New-Object System.Drawing.Point(0, 0)
$ProgressBar.Size      = New-Object System.Drawing.Size(0, 6)
$ProgressBar.BackColor = $Accent
$ProgressPanel.Controls.Add($ProgressBar)

# ============================================================
# LOG OUTPUT
# ============================================================
$LogBox = New-Object System.Windows.Forms.RichTextBox
$LogBox.Location       = New-Object System.Drawing.Point(10, 542)
$LogBox.Size           = New-Object System.Drawing.Size(760, 100)
$LogBox.BackColor      = [System.Drawing.Color]::FromArgb(5,5,5)
$LogBox.ForeColor      = $Dim
$LogBox.Font           = $LogFont
$LogBox.ReadOnly       = $true
$LogBox.BorderStyle    = "None"
$LogBox.ScrollBars     = "Vertical"
$Form.Controls.Add($LogBox)

function Write-Log {
    param($msg, $color = $null)
    if ($null -eq $color) { $color = $Dim }
    $LogBox.SelectionStart  = $LogBox.TextLength
    $LogBox.SelectionLength = 0
    $LogBox.SelectionColor  = $color
    $LogBox.AppendText("> $msg`n")
    $LogBox.ScrollToCaret()
    $Form.Refresh()
}

# ============================================================
# BOTTOM BUTTONS
# ============================================================
$BtnPanel = New-Object System.Windows.Forms.Panel
$BtnPanel.Location  = New-Object System.Drawing.Point(0, 648)
$BtnPanel.Size      = New-Object System.Drawing.Size(780, 55)
$BtnPanel.BackColor = [System.Drawing.Color]::FromArgb(8,8,8)
$Form.Controls.Add($BtnPanel)

# Select All
$BtnAll = New-Object System.Windows.Forms.Button
$BtnAll.Text      = "SELECT ALL"
$BtnAll.Font      = $BtnFont
$BtnAll.Size      = New-Object System.Drawing.Size(120, 34)
$BtnAll.Location  = New-Object System.Drawing.Point(10, 10)
$BtnAll.BackColor = [System.Drawing.Color]::FromArgb(18,18,18)
$BtnAll.ForeColor = $Dim
$BtnAll.FlatStyle = "Flat"
$BtnAll.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(40,40,40)
$BtnAll.Add_Click({ foreach ($cb in $checkboxes.Values) { $cb.Checked = $true } })
$BtnPanel.Controls.Add($BtnAll)

# Select None
$BtnNone = New-Object System.Windows.Forms.Button
$BtnNone.Text      = "CLEAR ALL"
$BtnNone.Font      = $BtnFont
$BtnNone.Size      = New-Object System.Drawing.Size(120, 34)
$BtnNone.Location  = New-Object System.Drawing.Point(138, 10)
$BtnNone.BackColor = [System.Drawing.Color]::FromArgb(18,18,18)
$BtnNone.ForeColor = $Dim
$BtnNone.FlatStyle = "Flat"
$BtnNone.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(40,40,40)
$BtnNone.Add_Click({ foreach ($cb in $checkboxes.Values) { $cb.Checked = $false } })
$BtnPanel.Controls.Add($BtnNone)

# APPLY button
$BtnApply = New-Object System.Windows.Forms.Button
$BtnApply.Text      = "▶  APPLY JAYDEN'S SAUCE"
$BtnApply.Font      = New-Object System.Drawing.Font("Consolas", 11, [System.Drawing.FontStyle]::Bold)
$BtnApply.Size      = New-Object System.Drawing.Size(340, 34)
$BtnApply.Location  = New-Object System.Drawing.Point(420, 10)
$BtnApply.BackColor = $BG
$BtnApply.ForeColor = $Accent
$BtnApply.FlatStyle = "Flat"
$BtnApply.FlatAppearance.BorderColor = $Accent
$BtnApply.FlatAppearance.BorderSize  = 1
$BtnPanel.Controls.Add($BtnApply)

# ============================================================
# APPLY LOGIC
# ============================================================
$BtnApply.Add_Click({
    $BtnApply.Enabled   = $false
    $BtnApply.Text      = "◌  APPLYING..."
    $BtnApply.ForeColor = $Dim
    $LogBox.Clear()
    $total = ($checkboxes.Values | Where-Object { $_.Checked }).Count
    if ($total -eq 0) {
        Write-Log "No tweaks selected. Check at least one option." $Red
        $BtnApply.Enabled   = $true
        $BtnApply.Text      = "▶  APPLY JAYDEN'S SAUCE"
        $BtnApply.ForeColor = $Accent
        return
    }
    $step = 0

    function Update-Progress {
        param($n, $t)
        $pct = [int](($n / $t) * 760)
        $ProgressBar.Width = $pct
        $Form.Refresh()
    }

    # RESTORE POINT
    if ($checkboxes["sys-protect"].Checked) {
        Write-Log "Enabling System Protection on C:..." $Accent
        Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
        $step++; Update-Progress $step $total
    }
    if ($checkboxes["restore"].Checked) {
        Write-Log "Creating Restore Point: 'Before Jaydans Sauce'..." $Accent
        try {
            Checkpoint-Computer -Description "Before Jaydans Sauce" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
            Write-Log "Restore point created successfully." $Green
        } catch {
            Write-Log "Restore point failed — System Protection may be off." $Orange
        }
        $step++; Update-Progress $step $total
    }

    # MOUSE / INPUT
    if ($checkboxes["mouse-accel"].Checked) {
        Write-Log "Disabling mouse acceleration..." $Accent
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed"      -Value "0"
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value "0"
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value "0"
        Write-Log "Mouse acceleration disabled." $Green
        $step++; Update-Progress $step $total
    }
    if ($checkboxes["raw-input"].Checked) {
        Write-Log "Applying raw input fix..." $Accent
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSensitivity" -Value "10"
        Write-Log "Raw input pointer fix applied." $Green
        $step++; Update-Progress $step $total
    }
    if ($checkboxes["usb-suspend"].Checked) {
        Write-Log "Disabling USB Selective Suspend..." $Accent
        powercfg /setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 2>$null
        powercfg /setactive SCHEME_CURRENT 2>$null
        Write-Log "USB Selective Suspend disabled." $Green
        $step++; Update-Progress $step $total
    }
    if ($checkboxes["hid-poll"].Checked) {
        Write-Log "Optimizing HID polling rate..." $Accent
        $regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\mouclass\Parameters"
        if (!(Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }
        Set-ItemProperty -Path $regPath -Name "MouseDataQueueSize" -Value 0x64 -Type DWord
        Write-Log "HID polling optimized." $Green
        $step++; Update-Progress $step $total
    }

    # POWER PLAN
    if ($checkboxes["power-plan"].Checked) {
        Write-Log "Setting High Performance power plan..." $Accent
        powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>$null
        Write-Log "High Performance power plan active." $Green
        $step++; Update-Progress $step $total
    }

    # GAME MODE
    if ($checkboxes["game-mode"].Checked) {
        Write-Log "Enabling Game Mode..." $Accent
        $gp = "HKCU:\SOFTWARE\Microsoft\GameBar"
        if (!(Test-Path $gp)) { New-Item -Path $gp -Force | Out-Null }
        Set-ItemProperty -Path $gp -Name "AllowAutoGameMode"   -Value 1 -Type DWord
        Set-ItemProperty -Path $gp -Name "AutoGameModeEnabled" -Value 1 -Type DWord
        Write-Log "Game Mode enabled." $Green
        $step++; Update-Progress $step $total
    }

    # GAME DVR
    if ($checkboxes["game-dvr"].Checked) {
        Write-Log "Disabling Xbox Game DVR..." $Accent
        $gd1 = "HKCU:\System\GameConfigStore"
        $gd2 = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR"
        $gd3 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"
        if (!(Test-Path $gd1)) { New-Item -Path $gd1 -Force | Out-Null }
        if (!(Test-Path $gd2)) { New-Item -Path $gd2 -Force | Out-Null }
        if (!(Test-Path $gd3)) { New-Item -Path $gd3 -Force | Out-Null }
        Set-ItemProperty -Path $gd1 -Name "GameDVR_Enabled"    -Value 0 -Type DWord
        Set-ItemProperty -Path $gd2 -Name "AppCaptureEnabled"  -Value 0 -Type DWord
        Set-ItemProperty -Path $gd3 -Name "AllowGameDVR"       -Value 0 -Type DWord
        Write-Log "Xbox Game DVR disabled." $Green
        $step++; Update-Progress $step $total
    }

    # VISUALS
    if ($checkboxes["visuals"].Checked) {
        Write-Log "Disabling Windows animations..." $Accent
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Windows animations disabled." $Green
        $step++; Update-Progress $step $total
    }

    # MENU DELAY
    if ($checkboxes["menu-delay"].Checked) {
        Write-Log "Setting menu delay to 0ms..." $Accent
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "0"
        Write-Log "Menu delay set to 0ms." $Green
        $step++; Update-Progress $step $total
    }

    # TIMER RES
    if ($checkboxes["timer-res"].Checked) {
        Write-Log "Optimizing timer resolution..." $Accent
        bcdedit /set useplatformtick yes 2>$null | Out-Null
        bcdedit /deletevalue useplatformclock 2>$null | Out-Null
        Write-Log "Timer resolution optimized." $Green
        $step++; Update-Progress $step $total
    }

    # FULLSCREEN OPT
    if ($checkboxes["fs-opt"].Checked) {
        Write-Log "Disabling fullscreen optimizations for Fortnite..." $Accent
        $fnPath = "C:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe"
        $regKey = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"
        if (!(Test-Path $regKey)) { New-Item -Path $regKey -Force | Out-Null }
        Set-ItemProperty -Path $regKey -Name $fnPath -Value "~ DISABLEDXMAXIMIZEDWINDOWEDMODE" -ErrorAction SilentlyContinue
        Write-Log "Fullscreen optimizations disabled." $Green
        $step++; Update-Progress $step $total
    }

    # GPU PRIORITY
    if ($checkboxes["gpu-sched"].Checked) {
        Write-Log "Setting GPU/CPU priority to High..." $Accent
        $sp = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"
        if (!(Test-Path $sp)) { New-Item -Path $sp -Force | Out-Null }
        Set-ItemProperty -Path $sp -Name "GPU Priority"         -Value 8  -Type DWord
        Set-ItemProperty -Path $sp -Name "Priority"             -Value 6  -Type DWord
        Set-ItemProperty -Path $sp -Name "Scheduling Category"  -Value "High"
        Write-Log "GPU priority: 8 | CPU scheduling: High." $Green
        $step++; Update-Progress $step $total
    }

    # NAGLE
    if ($checkboxes["nagle"].Checked) {
        Write-Log "Disabling Nagle's Algorithm..." $Accent
        $nicPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
        Get-ChildItem $nicPath | ForEach-Object {
            Set-ItemProperty -Path $_.PSPath -Name "TcpAckFrequency" -Value 1 -Type DWord -ErrorAction SilentlyContinue
            Set-ItemProperty -Path $_.PSPath -Name "TCPNoDelay"      -Value 1 -Type DWord -ErrorAction SilentlyContinue
        }
        Write-Log "Nagle's Algorithm disabled." $Green
        $step++; Update-Progress $step $total
    }

    # NETWORK THROTTLE
    if ($checkboxes["net-throttle"].Checked) {
        Write-Log "Disabling network throttling..." $Accent
        $mp = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
        Set-ItemProperty -Path $mp -Name "NetworkThrottlingIndex" -Value 0xFFFFFFFF -Type DWord
        Set-ItemProperty -Path $mp -Name "SystemResponsiveness"   -Value 0          -Type DWord
        Write-Log "Network throttling removed." $Green
        $step++; Update-Progress $step $total
    }

    # TCP AUTO-TUNE
    if ($checkboxes["tcp-tune"].Checked) {
        Write-Log "Disabling TCP auto-tuning..." $Accent
        netsh int tcp set global autotuninglevel=disabled 2>$null | Out-Null
        Write-Log "TCP auto-tuning disabled." $Green
        $step++; Update-Progress $step $total
    }

    # DONE
    $ProgressBar.Width      = 760
    $ProgressBar.BackColor  = $Green
    Write-Log "" $Dim
    Write-Log "ALL DONE! Restart your PC for all changes to take effect." $Green
    Write-Log "To undo: press Win+R, type rstrui.exe, pick 'Before Jaydans Sauce'." $Dim

    $BtnApply.Text      = "✓  SAUCE APPLIED — RESTART PC"
    $BtnApply.ForeColor = $Green
    $BtnApply.FlatAppearance.BorderColor = $Green
    $BtnApply.Enabled   = $true
})

# ============================================================
# LAUNCH
# ============================================================
$Form.Add_Shown({ $Form.Activate() })
[void]$Form.ShowDialog()
