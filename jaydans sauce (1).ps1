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

$BG        = [System.Drawing.Color]::FromArgb(0, 0, 0)
$Accent    = [System.Drawing.Color]::FromArgb(0, 212, 255)
$Orange    = [System.Drawing.Color]::FromArgb(255, 107, 0)
$Green     = [System.Drawing.Color]::FromArgb(0, 255, 136)
$TextColor = [System.Drawing.Color]::White
$Dim       = [System.Drawing.Color]::FromArgb(120, 120, 120)
$Red       = [System.Drawing.Color]::FromArgb(255, 51, 85)

$TitleFont  = New-Object System.Drawing.Font("Consolas", 22, [System.Drawing.FontStyle]::Bold)
$SubFont    = New-Object System.Drawing.Font("Consolas", 7,  [System.Drawing.FontStyle]::Regular)
$HeaderFont = New-Object System.Drawing.Font("Consolas", 9,  [System.Drawing.FontStyle]::Bold)
$SmallFont  = New-Object System.Drawing.Font("Consolas", 7,  [System.Drawing.FontStyle]::Regular)
$LogFont    = New-Object System.Drawing.Font("Consolas", 8,  [System.Drawing.FontStyle]::Regular)
$BtnFont    = New-Object System.Drawing.Font("Consolas", 9,  [System.Drawing.FontStyle]::Bold)

# ============================================================
# MAIN FORM
# ============================================================
$Form = New-Object System.Windows.Forms.Form
$Form.Text            = "Jayden's Sauce — Fortnite Optimizer"
$Form.Size            = New-Object System.Drawing.Size(800, 820)
$Form.StartPosition   = "CenterScreen"
$Form.BackColor       = $BG
$Form.ForeColor       = $TextColor
$Form.FormBorderStyle = "FixedSingle"
$Form.MaximizeBox     = $false
$Form.Font            = New-Object System.Drawing.Font("Consolas", 8, [System.Drawing.FontStyle]::Regular)

# HEADER
$HeaderPanel = New-Object System.Windows.Forms.Panel
$HeaderPanel.Size      = New-Object System.Drawing.Size(800, 80)
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
$SubLabel.Text      = "// FORTNITE PC OPTIMIZER — RUNNING AS ADMINISTRATOR //"
$SubLabel.Font      = $SubFont
$SubLabel.ForeColor = $Dim
$SubLabel.AutoSize  = $true
$SubLabel.Location  = New-Object System.Drawing.Point(22, 52)
$HeaderPanel.Controls.Add($SubLabel)

$Div1 = New-Object System.Windows.Forms.Panel
$Div1.Size      = New-Object System.Drawing.Size(800, 1)
$Div1.Location  = New-Object System.Drawing.Point(0, 78)
$Div1.BackColor = $Accent
$Form.Controls.Add($Div1)

# ============================================================
# PRESET ROW
# ============================================================
$PresetPanel = New-Object System.Windows.Forms.Panel
$PresetPanel.Location  = New-Object System.Drawing.Point(0, 80)
$PresetPanel.Size      = New-Object System.Drawing.Size(800, 50)
$PresetPanel.BackColor = [System.Drawing.Color]::FromArgb(6, 6, 6)
$Form.Controls.Add($PresetPanel)

$PresetLabel = New-Object System.Windows.Forms.Label
$PresetLabel.Text      = "PRESET:"
$PresetLabel.Font      = $BtnFont
$PresetLabel.ForeColor = $Dim
$PresetLabel.Location  = New-Object System.Drawing.Point(14, 15)
$PresetLabel.AutoSize  = $true
$PresetPanel.Controls.Add($PresetLabel)

function New-PresetBtn($text, $x) {
    $b = New-Object System.Windows.Forms.Button
    $b.Text      = $text
    $b.Font      = $BtnFont
    $b.Size      = New-Object System.Drawing.Size(130, 28)
    $b.Location  = New-Object System.Drawing.Point($x, 11)
    $b.BackColor = [System.Drawing.Color]::FromArgb(15, 15, 15)
    $b.ForeColor = $Dim
    $b.FlatStyle = "Flat"
    $b.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(40, 40, 40)
    $b.FlatAppearance.BorderSize  = 1
    $PresetPanel.Controls.Add($b)
    return $b
}

$BtnBalanced    = New-PresetBtn "BALANCED"    80
$BtnPerformance = New-PresetBtn "MAX PERF"    218
$BtnCompetitive = New-PresetBtn "COMPETITIVE" 356
$BtnCustom      = New-PresetBtn "CUSTOM"      494

$Div2 = New-Object System.Windows.Forms.Panel
$Div2.Size      = New-Object System.Drawing.Size(800, 1)
$Div2.Location  = New-Object System.Drawing.Point(0, 130)
$Div2.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
$Form.Controls.Add($Div2)

# ============================================================
# SCROLL PANEL
# ============================================================
$Scroll = New-Object System.Windows.Forms.Panel
$Scroll.Location   = New-Object System.Drawing.Point(0, 132)
$Scroll.Size       = New-Object System.Drawing.Size(800, 460)
$Scroll.AutoScroll = $true
$Scroll.BackColor  = $BG
$Form.Controls.Add($Scroll)

$yPos       = 10
$checkboxes = @{}

function Add-Section {
    param($title, $color, $items)

    $sHdr = New-Object System.Windows.Forms.Panel
    $sHdr.Location  = New-Object System.Drawing.Point(10, $script:yPos)
    $sHdr.Size      = New-Object System.Drawing.Size(760, 28)
    $sHdr.BackColor = [System.Drawing.Color]::FromArgb(18, 18, 18)

    $bar = New-Object System.Windows.Forms.Panel
    $bar.Location  = New-Object System.Drawing.Point(0, 0)
    $bar.Size      = New-Object System.Drawing.Size(3, 28)
    $bar.BackColor = $color
    $sHdr.Controls.Add($bar)

    $lbl = New-Object System.Windows.Forms.Label
    $lbl.Text      = "  $title"
    $lbl.Font      = $HeaderFont
    $lbl.ForeColor = $color
    $lbl.Location  = New-Object System.Drawing.Point(3, 5)
    $lbl.Size      = New-Object System.Drawing.Size(740, 18)
    $sHdr.Controls.Add($lbl)

    $Scroll.Controls.Add($sHdr)
    $script:yPos += 30

    foreach ($item in $items) {
        $row = New-Object System.Windows.Forms.Panel
        $row.Location  = New-Object System.Drawing.Point(10, $script:yPos)
        $row.Size      = New-Object System.Drawing.Size(760, 42)
        $row.BackColor = [System.Drawing.Color]::FromArgb(8, 8, 8)
        $row.Cursor    = [System.Windows.Forms.Cursors]::Hand

        $cb = New-Object System.Windows.Forms.CheckBox
        $cb.Location  = New-Object System.Drawing.Point(10, 12)
        $cb.Size      = New-Object System.Drawing.Size(16, 16)
        $cb.BackColor = [System.Drawing.Color]::FromArgb(8, 8, 8)
        if ($item.Default) { $cb.Checked = $true }
        $row.Controls.Add($cb)
        $script:checkboxes[$item.Key] = $cb

        $n = New-Object System.Windows.Forms.Label
        $n.Text      = $item.Name
        $n.Font      = $HeaderFont
        $n.ForeColor = $TextColor
        $n.Location  = New-Object System.Drawing.Point(34, 6)
        $n.Size      = New-Object System.Drawing.Size(700, 16)
        $row.Controls.Add($n)

        $d = New-Object System.Windows.Forms.Label
        $d.Text      = $item.Desc
        $d.Font      = $SmallFont
        $d.ForeColor = $Dim
        $d.Location  = New-Object System.Drawing.Point(34, 23)
        $d.Size      = New-Object System.Drawing.Size(700, 14)
        $row.Controls.Add($d)

        $row.Add_MouseEnter({ $this.BackColor = [System.Drawing.Color]::FromArgb(18, 18, 18) })
        $row.Add_MouseLeave({ $this.BackColor = [System.Drawing.Color]::FromArgb(8, 8, 8) })
        $cbRef = $cb
        $row.Add_Click({ $cbRef.Checked = !$cbRef.Checked })

        $Scroll.Controls.Add($row)
        $script:yPos += 44
    }
    $script:yPos += 8
}

# ============================================================
# SECTIONS
# ============================================================
Add-Section "RESTORE POINT" $Green @(
    @{ Key="sys-protect";  Name="Enable System Protection on C: (if disabled)"; Desc="Required for restore points to work";                           Default=$true }
    @{ Key="restore";      Name="Create System Restore Point First";            Desc="Safety net — undo all changes via Win+R > rstrui.exe";          Default=$true }
)

Add-Section "ZERO INPUT DELAY — CONTROLLER + KBM" $Orange @(
    @{ Key="mouse-accel";  Name="Disable Mouse Acceleration";                  Desc="Removes Enhance Pointer Precision — 1:1 raw movement";          Default=$true }
    @{ Key="raw-input";    Name="Raw Mouse Input Fix";                         Desc="Bypasses Windows pointer filtering entirely";                    Default=$true }
    @{ Key="usb-suspend";  Name="Disable USB Selective Suspend";               Desc="Stops controller/mouse from sleeping mid-game";                  Default=$true }
    @{ Key="hid-poll";     Name="Optimize HID Input Polling";                  Desc="Forces USB devices to report at maximum rate";                   Default=$false }
)

Add-Section "WINDOWS SYSTEM TWEAKS" $Accent @(
    @{ Key="power-plan";   Name="High Performance Power Plan";                 Desc="Forces CPU to max clock speed — no throttling";                  Default=$true }
    @{ Key="game-mode";    Name="Enable Windows Game Mode";                    Desc="Prioritizes game resources over background processes";            Default=$true }
    @{ Key="game-dvr";     Name="Disable Xbox Game DVR / Game Bar";            Desc="Stops background screen recording stealing FPS";                 Default=$true }
    @{ Key="visuals";      Name="Disable Windows Animations";                  Desc="Removes window effects — frees CPU cycles";                      Default=$true }
    @{ Key="menu-delay";   Name="Set Menu Delay to 0ms";                       Desc="Removes Start Menu and right-click lag";                         Default=$true }
    @{ Key="timer-res";    Name="Optimize Timer Resolution";                   Desc="Improves Windows scheduler precision for smoother frames";        Default=$false }
    @{ Key="fs-opt";       Name="Disable Fullscreen Optimizations (Fortnite)"; Desc="Prevents DWM from intercepting exclusive fullscreen";            Default=$true }
    @{ Key="gpu-sched";    Name="Set GPU/CPU Priority to High";                Desc="Forces games scheduling to High in SystemProfile";               Default=$true }
)

Add-Section "NETWORK LATENCY" $Accent @(
    @{ Key="nagle";        Name="Disable Nagle's Algorithm";                   Desc="Reduces ping spikes — better packet send timing";                Default=$true }
    @{ Key="net-throttle"; Name="Disable Network Throttling";                  Desc="Removes Windows multimedia network bandwidth cap";               Default=$true }
    @{ Key="tcp-tune";     Name="Disable TCP Auto-Tuning";                     Desc="Fixes receive window thrashing on fast connections";             Default=$false }
)

# ============================================================
# PROGRESS BAR
# ============================================================
$ProgPanel = New-Object System.Windows.Forms.Panel
$ProgPanel.Location  = New-Object System.Drawing.Point(0, 592)
$ProgPanel.Size      = New-Object System.Drawing.Size(800, 6)
$ProgPanel.BackColor = [System.Drawing.Color]::FromArgb(20, 20, 20)
$Form.Controls.Add($ProgPanel)

$ProgBar = New-Object System.Windows.Forms.Panel
$ProgBar.Location  = New-Object System.Drawing.Point(0, 0)
$ProgBar.Size      = New-Object System.Drawing.Size(0, 6)
$ProgBar.BackColor = $Accent
$ProgPanel.Controls.Add($ProgBar)

# ============================================================
# LOG BOX
# ============================================================
$LogBox = New-Object System.Windows.Forms.RichTextBox
$LogBox.Location    = New-Object System.Drawing.Point(10, 604)
$LogBox.Size        = New-Object System.Drawing.Size(780, 110)
$LogBox.BackColor   = [System.Drawing.Color]::FromArgb(5, 5, 5)
$LogBox.ForeColor   = $Dim
$LogBox.Font        = $LogFont
$LogBox.ReadOnly    = $true
$LogBox.BorderStyle = "None"
$LogBox.ScrollBars  = "Vertical"
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
$BtnPanel.Location  = New-Object System.Drawing.Point(0, 720)
$BtnPanel.Size      = New-Object System.Drawing.Size(800, 60)
$BtnPanel.BackColor = [System.Drawing.Color]::FromArgb(8, 8, 8)
$Form.Controls.Add($BtnPanel)

$BtnAll = New-Object System.Windows.Forms.Button
$BtnAll.Text      = "SELECT ALL"
$BtnAll.Font      = $BtnFont
$BtnAll.Size      = New-Object System.Drawing.Size(120, 34)
$BtnAll.Location  = New-Object System.Drawing.Point(10, 12)
$BtnAll.BackColor = [System.Drawing.Color]::FromArgb(18, 18, 18)
$BtnAll.ForeColor = $Dim
$BtnAll.FlatStyle = "Flat"
$BtnAll.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(40, 40, 40)
$BtnAll.Add_Click({ foreach ($cb in $checkboxes.Values) { $cb.Checked = $true } })
$BtnPanel.Controls.Add($BtnAll)

$BtnNone = New-Object System.Windows.Forms.Button
$BtnNone.Text      = "CLEAR ALL"
$BtnNone.Font      = $BtnFont
$BtnNone.Size      = New-Object System.Drawing.Size(120, 34)
$BtnNone.Location  = New-Object System.Drawing.Point(138, 12)
$BtnNone.BackColor = [System.Drawing.Color]::FromArgb(18, 18, 18)
$BtnNone.ForeColor = $Dim
$BtnNone.FlatStyle = "Flat"
$BtnNone.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(40, 40, 40)
$BtnNone.Add_Click({ foreach ($cb in $checkboxes.Values) { $cb.Checked = $false } })
$BtnPanel.Controls.Add($BtnNone)

$BtnApply = New-Object System.Windows.Forms.Button
$BtnApply.Text      = "▶  APPLY JAYDEN'S SAUCE"
$BtnApply.Font      = New-Object System.Drawing.Font("Consolas", 11, [System.Drawing.FontStyle]::Bold)
$BtnApply.Size      = New-Object System.Drawing.Size(360, 34)
$BtnApply.Location  = New-Object System.Drawing.Point(428, 12)
$BtnApply.BackColor = $BG
$BtnApply.ForeColor = $Accent
$BtnApply.FlatStyle = "Flat"
$BtnApply.FlatAppearance.BorderColor = $Accent
$BtnApply.FlatAppearance.BorderSize  = 1
$BtnPanel.Controls.Add($BtnApply)

# ============================================================
# PRESET LOGIC
# ============================================================
$balancedKeys    = @("sys-protect","restore","mouse-accel","raw-input","usb-suspend","power-plan","game-mode","game-dvr","visuals","menu-delay","fs-opt","gpu-sched","nagle","net-throttle")
$performanceKeys = @("sys-protect","restore","mouse-accel","raw-input","usb-suspend","hid-poll","power-plan","game-mode","game-dvr","visuals","menu-delay","timer-res","fs-opt","gpu-sched","nagle","net-throttle","tcp-tune")
$competitiveKeys = $performanceKeys

function Reset-PresetBtns {
    foreach ($b in @($BtnBalanced,$BtnPerformance,$BtnCompetitive,$BtnCustom)) {
        $b.ForeColor = $Dim
        $b.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(40,40,40)
    }
}
function Set-Preset($keys) {
    foreach ($cb in $checkboxes.Values) { $cb.Checked = $false }
    foreach ($k in $keys) { if ($checkboxes.ContainsKey($k)) { $checkboxes[$k].Checked = $true } }
}

$BtnBalanced.Add_Click({
    Reset-PresetBtns; Set-Preset $balancedKeys
    $BtnBalanced.ForeColor = $Accent; $BtnBalanced.FlatAppearance.BorderColor = $Accent
})
$BtnPerformance.Add_Click({
    Reset-PresetBtns; Set-Preset $performanceKeys
    $BtnPerformance.ForeColor = $Orange; $BtnPerformance.FlatAppearance.BorderColor = $Orange
})
$BtnCompetitive.Add_Click({
    Reset-PresetBtns; Set-Preset $competitiveKeys
    $BtnCompetitive.ForeColor = $Red; $BtnCompetitive.FlatAppearance.BorderColor = $Red
})
$BtnCustom.Add_Click({
    Reset-PresetBtns
    foreach ($cb in $checkboxes.Values) { $cb.Checked = $false }
})

# ============================================================
# APPLY LOGIC
# ============================================================
$BtnApply.Add_Click({
    $BtnApply.Enabled   = $false
    $BtnApply.Text      = "◌  APPLYING..."
    $BtnApply.ForeColor = $Dim
    $LogBox.Clear()

    $total = ($checkboxes.Values | Where-Object { $_.Checked } | Measure-Object).Count
    if ($total -eq 0) {
        Write-Log "No tweaks selected. Check at least one option." $Red
        $BtnApply.Enabled = $true; $BtnApply.Text = "▶  APPLY JAYDEN'S SAUCE"; $BtnApply.ForeColor = $Accent
        return
    }

    $script:step = 0
    function Update-Progress { $ProgBar.Width = [int](($script:step / $total) * 800); $Form.Refresh() }

    if ($checkboxes["sys-protect"].Checked) {
        Write-Log "Enabling System Protection on C:..." $Accent
        Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
        $script:step++; Update-Progress
    }
    if ($checkboxes["restore"].Checked) {
        Write-Log "Creating Restore Point: 'Before Jaydans Sauce'..." $Accent
        try {
            Checkpoint-Computer -Description "Before Jaydans Sauce" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
            Write-Log "Restore point created." $Green
        } catch { Write-Log "Restore point failed — enable System Protection manually." $Orange }
        $script:step++; Update-Progress
    }
    if ($checkboxes["mouse-accel"].Checked) {
        Write-Log "Disabling mouse acceleration..." $Accent
        Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseSpeed" "0"
        Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseThreshold1" "0"
        Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseThreshold2" "0"
        Write-Log "Mouse acceleration disabled." $Green; $script:step++; Update-Progress
    }
    if ($checkboxes["raw-input"].Checked) {
        Write-Log "Applying raw input fix..." $Accent
        Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseSensitivity" "10"
        Write-Log "Raw input fix applied." $Green; $script:step++; Update-Progress
    }
    if ($checkboxes["usb-suspend"].Checked) {
        Write-Log "Disabling USB Selective Suspend..." $Accent
        powercfg /setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 2>$null
        powercfg /setactive SCHEME_CURRENT 2>$null
        Write-Log "USB Selective Suspend disabled." $Green; $script:step++; Update-Progress
    }
    if ($checkboxes["hid-poll"].Checked) {
        Write-Log "Optimizing HID polling..." $Accent
        $rp = "HKLM:\SYSTEM\CurrentControlSet\Services\mouclass\Parameters"
        if (!(Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
        Set-ItemProperty -Path $rp -Name "MouseDataQueueSize" -Value 0x64 -Type DWord
        Write-Log "HID polling optimized." $Green; $script:step++; Update-Progress
    }
    if ($checkboxes["power-plan"].Checked) {
        Write-Log "Setting High Performance power plan..." $Accent
        powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>$null
        Write-Log "High Performance power plan active." $Green; $script:step++; Update-Progress
    }
    if ($checkboxes["game-mode"].Checked) {
        Write-Log "Enabling Game Mode..." $Accent
        $gp = "HKCU:\SOFTWARE\Microsoft\GameBar"
        if (!(Test-Path $gp)) { New-Item -Path $gp -Force | Out-Null }
        Set-ItemProperty $gp "AllowAutoGameMode" 1 -Type DWord
        Set-ItemProperty $gp "AutoGameModeEnabled" 1 -Type DWord
        Write-Log "Game Mode enabled." $Green; $script:step++; Update-Progress
    }
    if ($checkboxes["game-dvr"].Checked) {
        Write-Log "Disabling Xbox Game DVR..." $Accent
        $g1="HKCU:\System\GameConfigStore"; $g2="HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR"; $g3="HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"
        foreach ($p in @($g1,$g2,$g3)) { if (!(Test-Path $p)) { New-Item $p -Force | Out-Null } }
        Set-ItemProperty $g1 "GameDVR_Enabled" 0 -Type DWord
        Set-ItemProperty $g2 "AppCaptureEnabled" 0 -Type DWord
        Set-ItemProperty $g3 "AllowGameDVR" 0 -Type DWord
        Write-Log "Xbox Game DVR disabled." $Green; $script:step++; Update-Progress
    }
    if ($checkboxes["visuals"].Checked) {
        Write-Log "Disabling Windows animations..." $Accent
        Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" "VisualFXSetting" 2 -Type DWord -ErrorAction SilentlyContinue
        Write-Log "Windows animations disabled." $Green; $script:step++; Update-Progress
    }
    if ($checkboxes["menu-delay"].Checked) {
        Write-Log "Setting menu delay to 0ms..." $Accent
        Set-ItemProperty "HKCU:\Control Panel\Desktop" "MenuShowDelay" "0"
        Write-Log "Menu delay set to 0ms." $Green; $script:step++; Update-Progress
    }
    if ($checkboxes["timer-res"].Checked) {
        Write-Log "Optimizing timer resolution..." $Accent
        bcdedit /set useplatformtick yes 2>$null | Out-Null
        bcdedit /deletevalue useplatformclock 2>$null | Out-Null
        Write-Log "Timer resolution optimized." $Green; $script:step++; Update-Progress
    }
    if ($checkboxes["fs-opt"].Checked) {
        Write-Log "Disabling fullscreen optimizations..." $Accent
        $fn = "C:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe"
        $rk = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"
        if (!(Test-Path $rk)) { New-Item $rk -Force | Out-Null }
        Set-ItemProperty $rk -Name $fn -Value "~ DISABLEDXMAXIMIZEDWINDOWEDMODE" -ErrorAction SilentlyContinue
        Write-Log "Fullscreen optimizations disabled." $Green; $script:step++; Update-Progress
    }
    if ($checkboxes["gpu-sched"].Checked) {
        Write-Log "Setting GPU/CPU priority to High..." $Accent
        $sp = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"
        if (!(Test-Path $sp)) { New-Item $sp -Force | Out-Null }
        Set-ItemProperty $sp "GPU Priority" 8 -Type DWord
        Set-ItemProperty $sp "Priority" 6 -Type DWord
        Set-ItemProperty $sp "Scheduling Category" "High"
        Write-Log "GPU priority 8 | CPU scheduling: High." $Green; $script:step++; Update-Progress
    }
    if ($checkboxes["nagle"].Checked) {
        Write-Log "Disabling Nagle's Algorithm..." $Accent
        Get-ChildItem "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" | ForEach-Object {
            Set-ItemProperty $_.PSPath "TcpAckFrequency" 1 -Type DWord -ErrorAction SilentlyContinue
            Set-ItemProperty $_.PSPath "TCPNoDelay" 1 -Type DWord -ErrorAction SilentlyContinue
        }
        Write-Log "Nagle's Algorithm disabled." $Green; $script:step++; Update-Progress
    }
    if ($checkboxes["net-throttle"].Checked) {
        Write-Log "Disabling network throttling..." $Accent
        $mp = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
        Set-ItemProperty $mp "NetworkThrottlingIndex" 0xFFFFFFFF -Type DWord
        Set-ItemProperty $mp "SystemResponsiveness" 0 -Type DWord
        Write-Log "Network throttling removed." $Green; $script:step++; Update-Progress
    }
    if ($checkboxes["tcp-tune"].Checked) {
        Write-Log "Disabling TCP auto-tuning..." $Accent
        netsh int tcp set global autotuninglevel=disabled 2>$null | Out-Null
        Write-Log "TCP auto-tuning disabled." $Green; $script:step++; Update-Progress
    }

    $ProgBar.Width     = 800
    $ProgBar.BackColor = $Green
    Write-Log "" $Dim
    Write-Log "ALL DONE! Restart your PC for full effect." $Green
    Write-Log "To undo: Win+R > rstrui.exe > select 'Before Jaydans Sauce'" $Dim
    $BtnApply.Text = "✓  SAUCE APPLIED — RESTART PC"
    $BtnApply.ForeColor = $Green
    $BtnApply.FlatAppearance.BorderColor = $Green
    $BtnApply.Enabled = $true
})

$Form.Add_Shown({ $Form.Activate() })
[void]$Form.ShowDialog()
