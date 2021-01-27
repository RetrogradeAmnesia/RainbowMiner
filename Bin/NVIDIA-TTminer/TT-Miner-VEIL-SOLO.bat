@echo off

:loop

TT-Miner.exe -coin veil -luck -log -logpool -P http://TTx:tt@192.168.41.149:58812


echo restart miner...
goto loop
