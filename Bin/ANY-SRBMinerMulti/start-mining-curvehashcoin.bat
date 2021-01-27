:: This is an example you can edit and use
:: There are numerous parameters you can set, please check Help and Examples folder

@echo off
cd %~dp0
cls

SRBMiner-MULTI.exe --disable-gpu --algorithm curvehash --pool stratum-eu.rplant.xyz:7058 --wallet curvehashcoin-wallet-here

pause