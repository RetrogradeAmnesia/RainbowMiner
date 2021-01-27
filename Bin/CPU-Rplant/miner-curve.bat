rem
rem Choose nearest stratum:
rem       stratum-ru.rplant.xyz   /Moscow/
rem       stratum-eu.rplant.xyz   /London/
rem       stratum-asia.rplant.xyz /Singapore/
rem       stratum-na.rplant.xyz /Toronto/
rem
:start
"%~dp0"cpuminer-sse2.exe -a curvehash -o stratum+tcps://stratum-eu.rplant.xyz:17058 -u WALLET_ADDRESS.WORKER_NAME
goto start
