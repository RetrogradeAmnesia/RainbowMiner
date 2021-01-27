:: This is an example you can edit and use
:: There are numerous parameters you can set, please check Help and Examples folder
:: Start miner with administrator privileges to enable gpu-tweak-profile

setx GPU_MAX_HEAP_SIZE 100
setx GPU_MAX_USE_SYNC_OBJECTS 1
setx GPU_SINGLE_ALLOC_PERCENT 100
setx GPU_MAX_ALLOC_PERCENT 100
setx GPU_MAX_SINGLE_ALLOC_PERCENT 100

@echo off
cd %~dp0
cls

::The worlds first ever MMORPG that incorporates Crypto Mining into a medieval sci-fi Discord Game [ https://www.blockhunts.com ]

SRBMiner-MULTI.exe --disable-cpu --algorithm ethash --pool egem.blockhunts.com:8002 --wallet ethergem-wallet-here --gpu-boost 3
pause