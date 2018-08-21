@echo off

SET ErrMsg=No Error
SET a=c:\temp

@echo ******* Creating %a%\Archer_PreUpgrade.log ******* 


if exist %a%\Archer_PreUpgrade.log (
	del %a%\Archer_PreUpgrade.log
)
md %a%
echo.>%a%\Archer_PreUpgrade.log


echo ******* Extracting Temp.exe to C:\Temp ******* >>%a%\Archer_PreUpgrade.log
SET ErrMsg=ERROR Extracting Temp.exe
start /wait Temp.exe /auto c:\temp
if not %errorlevel%==0 goto ERROR


echo ******* Running 260812.reg... ******* >>%a%\Archer_PreUpgrade.log
SET ErrMsg=ERROR Running 260812.reg
if not exist C:\Temp\260812.reg goto ERROR
start /wait regedit /s C:\Temp\260812.reg


echo ******* Installing Apache_OpenOffice_4.1.0... ******* >>%a%\Archer_PreUpgrade.log
SET ErrMsg=ERROR Installing Apache_OpenOffice_4.1.0
start /wait C:\Temp\Apache_OpenOffice_4.1.0_Win_x86_install_en-US.exe /S /v /qb
if not %errorlevel%==0 goto ERROR


echo ******* Extracting MBS.exe to C:\5300\Config ******* >>%a%\Archer_PreUpgrade.log
SET ErrMsg=ERROR Extracting MBS.exe
start /wait MBS.exe /auto c:\5300\Config
if not %errorlevel%==0 goto ERROR


@echo ******* PreUpgrade ended. Log is in %a%\Archer_PreUpgrade.log *******
echo ******* PreUpgrade ended ******* >>%a%\Archer_PreUpgrade.log
pause /s exit
exit 0


:ERROR
echo ******* ERROR Running PreUpgrade steps: %ErrMsg%******* >>%a%\Archer_PreUpgrade.log
echo.>>%a%\Archer_PreUpgrade.log
echo ******* Run PreUpgradeSteps.bat again after examining the error ******* >>%a%\Archer_PreUpgrade.log

@echo ******* ERROR Running PreUpgrade steps *******
@echo.
@echo ******* Run PreUpgradeSteps.bat again after examining the error *******

start notepad %a%\Archer_PreUpgrade.log
@echo.
pause /s exit
exit /b 1

