@echo off

:loop
wildrig.exe --print-full --algo phi5 --url stratum+tcp://stratum-eu.rplant.xyz:7055 --user CYc9adyF7SB3L7u2vrPph5mPM6EfMcdZJe --pass x

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop