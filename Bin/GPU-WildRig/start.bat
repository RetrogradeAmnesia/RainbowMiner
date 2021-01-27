@echo off

:loop

wildrig.exe --print-full --algo algo --opencl-threads auto --opencl-launch auto --url pool:port --user wallet --pass password

if ERRORLEVEL 1000 goto custom
timeout /t 5
goto loop

:custom
echo Some error happened, put custom command here
timeout /t 5
goto loop