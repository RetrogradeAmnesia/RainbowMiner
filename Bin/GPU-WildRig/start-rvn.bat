@echo off

:loop
wildrig.exe --print-full --algo kawpow --url stratum+tcp://rvn.woolypooly.com:55555 --worker test --user RJjr1sMM2uVsiBpUN86vgbs3JnkPzwfWFD --pass x

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop