# ASIOLinkProFIX
 Patch and Driver FIX for ASIO Link Pro on Windows 10
 
**What?**

This is a script/executable with files necessary to fix ASIO Link Pro on Windows 10 x64/x86.

It includes:

-The necessary patches to have the software registered, so you don't get audio cuts from time to time. (done out of convenience)

-Latest 'unreleased' drivers dated from 2017 that were "hidden" inside the official setup package, but never installed on Windows 10 environment. Now you can have the latest ASIOVADPRO drivers updated in Windows 10, without issues.

These drivers solved issues with very short audio files being 'cut' when played through the virtual WDM audio device (ex: Speaker Test or Discord sounds...). No more issues when using ASIO Link Pro with ASIO4ALL.

The script is very simple and raw. I'm not a good programmer by any means.

**To run it:**

1 - Have ASIO Link Pro version 2.4.4.2 installed

2 - Grab the executable on the Releases pages **OR** just donwload the source code and compile it in AutoIt.

3 - Unzip all the contents from the zip file. Run the asiolinkprofix.exe with Admin right. Don't forget to have the "fix" folder together.

Tested on Windows 10 x64 and Windows 10 x86.
The patched version on x86 environment is not guaranteed, but it works on 64bit Windows 10. (Why are you using 32-bit Windows anyways...?)
