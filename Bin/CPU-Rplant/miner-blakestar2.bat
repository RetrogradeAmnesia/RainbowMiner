rem
rem Choose nearest stratum:
rem       stratum-ru.rplant.xyz   /Moscow/
rem       stratum-eu.rplant.xyz   /London/
rem       stratum-asia.rplant.xyz /Singapore/
rem       stratum-na.rplant.xyz   /Toronto/
rem
:start
"%~dp0"cpuminer-sse2.exe -a x22 -o stratum+tcps://stratum-eu.rplant.xyz:17065 -u WALLET_ADDRESS.WORKER_NAME
pause 5
goto start
