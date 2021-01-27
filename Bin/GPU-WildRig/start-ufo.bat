@echo off

:loop
wildrig.exe --print-full --algo x17r --url stratum+tcp://ufo.666pool.cn:7558 --user 10f970adcbb913b8d0fbff0d4e517190ec6dc1cffae3b6eb82356360f762a233b37.donate --pass x

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop