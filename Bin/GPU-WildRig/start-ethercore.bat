@echo off

:loop
wildrig.exe --print-full --algo progpow-ethercore --url stratum+tcp://pool.ethercore.io:8008 --worker test --user 0x1fbcc5d3b68c5c4b011a2bf561e7ff9ef984d331 --pass x

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop