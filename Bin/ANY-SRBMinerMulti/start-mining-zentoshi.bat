:: This is an example you can edit and use
:: There are numerous parameters you can set, please check Help and Examples folder

@echo off
cd %~dp0
cls

SRBMiner-MULTI.exe --disable-gpu --algorithm balloon_zentoshi --pool pool.zentoshi.com:8444 --wallet zentoshi-wallet-here --password c=ZEN
pause