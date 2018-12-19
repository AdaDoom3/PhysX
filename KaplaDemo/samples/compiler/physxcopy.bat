SETLOCAL

SET PXFROMDIR=%1
SET PXTODIR=%2
SET EXTERNALSFROMDIR=%3
SET GLUTFROMDIR=%4
SET CGFROMDIR=%5
SET PXSHAREDFROMDIR=%6
SET HBAODIR=%7

CALL :UPDATE_PX_TARGET PhysX3Cooking*_x86.dll
CALL :UPDATE_PX_TARGET PhysX3*_x86.dll
CALL :UPDATE_PX_TARGET PhysX3Gpu*_x86.dll
CALL :UPDATE_PX_TARGET PhysX3Common*_x86.dll
CALL :UPDATE_PX_TARGET PhysX3CharacterKinematic*_x86.dll
CALL :UPDATE_PXSHARED_TARGET PxFoundation*_x86.dll
CALL :UPDATE_PXSHARED_TARGET PxPvdSDK*_x86.dll

rem CALL :UPDATE_PX_TARGET nvToolsExt32_1.dll
rem CALL :UPDATE_PX_TARGET cudart32_*.dll
rem CALL :UPDATE_PX_TARGET glut32.dll

CALL :UPDATE_TARGET %CGFROMDIR% %PXTODIR% cg.dll
CALL :UPDATE_TARGET %CGFROMDIR% %PXTODIR% cgGL.dll
CALL :UPDATE_TARGET %CGFROMDIR% %PXTODIR% cgD3d9.dll

CALL :UPDATE_TARGET %EXTERNALSFROMDIR%/nvToolsExt/1/bin/Win32 %PXTODIR% nvToolsExt32_1.dll

CALL :UPDATE_TARGET %GLUTFROMDIR% %PXTODIR% glut32.dll

CALL :UPDATE_TARGET ../../../bin %PXTODIR% resourcePath.txt

IF "%7"=="" GOTO END

CALL :UPDATE_TARGET %HBAODIR% %PXTODIR% GFSDK_SSAO_GL.win32.dll

ENDLOCAL
GOTO END


REM ********************************************
REM NO CALLS TO :UPDATE*_TARGET below this line!!
REM ********************************************

:UPDATE_TARGET
IF NOT EXIST %1\%3 (
	rem echo File doesn't exist %1\%3
) ELSE (
    XCOPY "%1\%3" "%2" /R /C /Y > nul
)
GOTO END

:UPDATE_PX_TARGET
IF NOT EXIST %PXFROMDIR%\%1 (
	rem echo File doesn't exist %PXFROMDIR%\%1
) ELSE (
    XCOPY "%PXFROMDIR%\%1" "%PXTODIR%" /R /C /Y > nul
)
GOTO END


:UPDATE_PXSHARED_TARGET
IF NOT EXIST %PXSHAREDFROMDIR%\%1 (
	rem echo File doesn't exist %PXSHAREDFROMDIR%\%8
) ELSE (
    XCOPY "%PXSHAREDFROMDIR%\%1" "%PXTODIR%" /R /C /Y > nul
)
GOTO END

:END