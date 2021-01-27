:: This is an example you can edit and use
:: There are numerous parameters you can set, please check Help and Examples folder
:: This setup primarily mines EpicCash, and when no 'randomepic' job is available it will automatically switch over to mining Monero, until EpicCash job is available again

@echo off
cd %~dp0
cls

SRBMiner-MULTI.exe --disable-gpu --multi-algorithm-job-mode 3 --algorithm randomepic;randomx --pool epic.hashrate.to:4000;monero.herominers.com:10190 --wallet epic-username-here;monero-wallet-here
pause