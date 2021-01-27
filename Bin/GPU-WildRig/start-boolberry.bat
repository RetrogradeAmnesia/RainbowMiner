@echo off

:loop
wildrig.exe --print-full --algo wildkeccak --url stratum+tcp://bbr.luckypool.io:5577 --user 1C4mbAEKiVj4bNqijN6a7BFDUfGDL81CLUNsM2rkaF54Nqxaxo2jiHQPAY8GRcUrHPRK7rzvUShjo7y4AF7b4hrpSEVNGXb --pass x --scratchpad-url http://eu-bbr.luckypool.io/scratchpad.bin --scratchpad-file scratchpad.bin --scratchpad-safe-update

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop