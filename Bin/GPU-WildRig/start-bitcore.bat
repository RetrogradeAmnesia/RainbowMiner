@echo off

:loop
wildrig.exe --print-full --algo megabtx --url stratum+tcp://stratum-eu.rplant.xyz:7066 --user sY7v3ieNguMPRd8XkzGdUtASDZFrCvdAmn --pass x

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop