@echo off

:loop
wildrig.exe --print-full --algo progpow-veil --url veil.woolypooly.com:3098 --user VDwCE3LES8YtGq8rjxaQ52Qcy7hjcBsu1u --pass x

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop