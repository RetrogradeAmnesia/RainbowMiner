:: Please check Help\Other\Eth-Etc-Zil.txt for an explanation of this example
:: This is an example you can edit and use
:: There are numerous parameters you can set, please check Help and Examples folder
:: Start miner with administrator privileges to enable gpu-boost

setx GPU_MAX_HEAP_SIZE 100
setx GPU_MAX_USE_SYNC_OBJECTS 1
setx GPU_SINGLE_ALLOC_PERCENT 100
setx GPU_MAX_ALLOC_PERCENT 100
setx GPU_MAX_SINGLE_ALLOC_PERCENT 100

@echo off
cd %~dp0
cls

::change --wallet ethereum-wallet.zilliqa-wallet;ethereum-wallet.zilliqa-wallet --worker ezil-worker-zil;ezil-worker-eth
::to your own wallet's and worker names

SRBMiner-MULTI.exe --disable-cpu --multi-algorithm-job-mode 3 --a0-is-zil --algorithm ethash;ethash --pool eu.ezil.me:5555;eu.ezil.me:5555 --wallet ethereum-wallet.zilliqa-wallet;ethereum-wallet.zilliqa-wallet --worker ezil-worker-zil;ezil-worker-eth --gpu-boost 3;0

pause