@echo off

:loop
wildrig.exe --print-full --algo lyra2vc0ban --url stratum+tcp://eu.gos.cx:4650 --user 8J1i7WJYiTbb92AcRjzfX1Pob6jiN1kJEG --pass c=RYO

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop