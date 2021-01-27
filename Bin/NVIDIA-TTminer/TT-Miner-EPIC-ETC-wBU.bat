@echo off

:loop

TT-Miner.exe -coin EPIC -poolinfo -luck -log -logpool -P <USER>.<PWD>@127.0.0.1:3416 -P <USER>.<WORKER>:<PWD>@epic.icemining.ca:4000 -coinalt etc -PALT <ETC-WALLET>.<WORKER>@eu1-etc.ethermine.org:4444 -coinalt clo -PALT stratum1+tcp://<WALLET>.<WORKER>@solo.clopool.pro:2565

echo restart miner...
goto loop

