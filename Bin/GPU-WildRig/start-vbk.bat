@echo off

:loop
wildrig.exe --print-full --algo vprogpow --url stratum+tcp://veriblock.luckypool.io:9501 --user VHoWCZrQB4kqLHm1EoNoU8rih7ohyG --pass x

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop