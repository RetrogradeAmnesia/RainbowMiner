@echo off

:loop

TT-Miner.exe -coin vbk -luck -log -logpool -P stratum+tcp://VC4kuYTFFs2tG9CeUGEkQhdEE9kKXE.:TT-DEV@bigshoots.net:8502

echo restart miner...
goto loop

