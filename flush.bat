@echo off
setlocal EnableDelayedExpansion

fltmc >nul 2>&1 || (
    echo(&echo   [33m# Administrator privileges are required.&echo([0m
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo   [33m# Right-click on the script and select "Run as administrator".[0m
        >nul pause&exit 1
    )
    exit 0
)

>nul 2>&1(
	ipconfig/release
	arp -d *
	nbtstat -R
	nbtstat -RR
	ipconfig/flushdns
	ipconfig/registerdns
	netsh winsock reset
	net stop dps
	del /f/s/q/a "%windir%\System32\sru\*"
	net start dps
	ipconfig/renew
)
