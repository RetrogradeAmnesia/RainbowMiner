@echo off

:loop
wildrig.exe --print-full --algo mtp-tcr --split-job 4 --url stratum+tcp://pool.tecracoin.io:4556 --user TQxTbiSoKS4xCtpkKWBM3LTUpiPLc4gRvz --pass x

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop