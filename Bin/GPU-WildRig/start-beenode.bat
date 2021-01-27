@echo off

:loop
wildrig.exe --print-full --algo honeycomb --url stratum+tcp://pool.rplant.xyz:7018 --user B9Fc2oJMRyBMLTaJDEmsjPXZ7kHrfYcGMF.Donate --pass x

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Custom command here
timeout /t 5
goto loop