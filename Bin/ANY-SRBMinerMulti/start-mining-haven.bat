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

SRBMiner-MULTI.exe --algorithm cryptonight_xhv --pool haven.herominers.com:10450 --wallet hvs1cvNf6CSUkc24rDRyF1QS2bjsAt86CQvDAsejs3qUH6BGiUhgYUVHDsvHKoXAZo13AWiu8d1icMh9SGWUTopj8UbbR2NTZk --gpu-boost 3
pause