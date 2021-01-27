@echo off

:loop
wildrig.exe --print-full --algo minotaur --url stratum+tcp://stratum-eu.rplant.xyz:7018 --user Zq4Qy3txJozx7Qr7ngJ9xLnyG4pzcREaie --pass x

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop