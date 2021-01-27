@echo off

:loop
wildrig.exe --print-full --algo x25x --url stratum+tcp://eupool.sinovate.io:3253 --user SauLQKggrWaAcFU8BvZCJ2bEHAYb8QdpQY --pass c=SIN

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop