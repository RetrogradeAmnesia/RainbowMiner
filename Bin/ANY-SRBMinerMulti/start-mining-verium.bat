:: This is an example you can edit and use
:: There are numerous parameters you can set, please check Help and Examples folder

@echo off
cd %~dp0
cls

SRBMiner-MULTI.exe --disable-gpu --algorithm scryptn2 --pool london.blockbucket.net:3003 --wallet verium-wallet-here
pause