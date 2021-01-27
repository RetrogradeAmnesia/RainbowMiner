@echo off

:loop
wildrig.exe --print-full --algo mtp --url stratum+tcp://eu-zcoin.zellabs.net:7017 --user a8MjPUoCjm9pLvX4TRDRfTCA7wcNDa19cM --pass x

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop