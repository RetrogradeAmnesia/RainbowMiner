@echo off

setlocal enableDelayedExpansion

lolMiner.exe --benchmark ETHASH --benchepoch 385 --longstats 120 --4g-alloc-size 4024 --keepfree 8
timeout 10

