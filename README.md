# ASIOLinkProFIX
 Patch and Driver FIX for ASIO Link Pro on Windows 10 / Windows 11
 
**What?**

This is a script/executable with files necessary to fix ASIO Link Pro on Windows 10 x64/x86.

It includes:

-The necessary patches to have the software registered, so you don't get audio cuts from time to time. (pre-patched out of convenience) (Credits to G.A. Collective for doing the patch)

-Latest 'unreleased' drivers dated from 2017 that were "hidden" inside the official setup package, but never installed on Windows 10 environment. Now you can have the latest ASIOVADPRO drivers updated in Windows 10 (and probably Windows 11), without issues.

These drivers solved issues with very short audio files being 'cut' when played through the virtual WDM audio device (ex: Speaker Test or Discord sounds...). No more issues when using ASIO Link Pro with ASIO4ALL.

The script is very simple and raw. I'm not a good programmer by any means.

**To run it:**

1 - Have ASIO Link Pro version 2.4.4.2 installed

2 - Grab the executable on the Releases pages - (THE SOURCE CODE IS INCLUDED INSIDE THE ZIP FILE, JUST COMPILE IN AUTOIT IF YOU WANT).

3 - Unzip all the contents from the zip file. Run the asiolinkprofix.exe with Admin rights. Don't forget to have the "fix.zip" together.

Tested on Windows 10 and 11 x64 and Windows 10 x86.
The patched version on x86 environment is not guaranteed, but it works on 64bit Windows 10 and 11 - both 32bit and 64bit are OK on Windows 10 and Windows 11 x64. (Why are you using 32-bit Windows anyways...?)


Version 0.2 was necessary because something screwed with codepage of inf files. Also, I made it silent - no msgbox, only Log files. Make sure you unpack everything.
No more showing "trial" on ASIO Link Pro tray help/mouse hover.
