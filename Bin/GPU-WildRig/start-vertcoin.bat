@echo off

:loop
wildrig.exe --print-full --algo lyra2v3 --url stratum+tcp://vtc.f2pool.com:5810 --user VpFak1DnfAMUKEosDmzAxZFACvKtndVxbi --pass c=VTC

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop