ccMiner-yescryptr for Koto Sapling support Version 5
2019-12-20

This software is modified ccMiner release 8.21(KlausT-mod) mod r18 for Koto Sapling support.

Built by –¼–³‚µ(Nanashi)
  BTC: 3NM7dNxUAJxLWeL2FAhtoGN6uZjqFKckfM
  MONA: P9jzrzq5BKASZim3F2ssq3Xdgme6EHNHDw

Compiled for Windows by minerx117@github.com

System requirements
  Windows 7,8,10 64bit
  NVIDIA graphic boards with CUDA 10.1

Operation checked graphic boards
  RTX 2080
  RTX 2060
  GTX 1660TI
  GTX 1070
  GTX 1060

latest Release/Source code
  ccminer-yescryptr
  https://github.com/Minerx117/ccminer

  sapling.diff (ccminer-KlausT-8.21-mod-r17 patch for Koto Sapling)
  https://gist.github.com/wo01/75ecb9660f5848ab308f93ce6cd42921

  ccminer.cpp nonceptr fix
  https://askmona.org/11245#res_69

History
  Version 5 2019-12-20
   update compute recompile with VS2019 CUDA 10.1 update 2
  Version 4 2019-11-16
   fix rejected/invalid shares and nonce errors for yescryptr8g
   recompile based on 8.21(KlausT-mod) mod r18 instead of mod r17
  Version 3 2019-11-15
   recompile with vc++2015 instead of 2017 +140 toolset (windows 7,8 & 10 Support)
   remove compute 7.5
   slight speed increase over version 1 & 2
  Version 2 2019-01-11
    ccminer.cpp nonceptr fix.
  Version 1 2019-01-06
    First release.
