:: This is an example you can edit and use
:: There are numerous parameters you can set, please check Help and Examples folder

@echo off
cd %~dp0
cls

SRBMiner-MULTI.exe --disable-gpu --algorithm randomhash2 --pool fastpool.xyz:3338 --wallet pascal-wallet-here
pause