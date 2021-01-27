@echo off

:loop
wildrig.exe --print-full --algo sha256csm --url stratum+tcp://stratum-eu.rplant.xyz:7045 --user donate --pass x

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop