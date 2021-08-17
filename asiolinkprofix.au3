#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=tool.ico
#AutoIt3Wrapper_Res_Comment=Fix for ASIO Link Pro 2.4.4.2. Add patched asiolink.dll and renews the driver to the latest.
#AutoIt3Wrapper_Res_Description=Fix for ASIO Link Pro 2.4.4.2. Add patched asiolink.dll and renews the driver to the latest.
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_CompanyName=Dirko
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <File.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

If IsAdmin() = 0 Then MsgBox($MB_SYSTEMMODAL, "", "You can only run this script/executable with ADMIN rights.")

$sALPInstallDir = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\ASIOLinkPro","Install_Dir")
If @error <> 0 then
	MsgBox(0,"Install", "We couldn't find the install path for ASIO Link Pro. REINSTALL your ASIO Link Pro and run this fix again. Exiting")
	Exit
EndIf
;~ If @error = 0 Then
;~ 	MsgBox(0, "ASIO Link Pro Install Path", "Found ASIO Link Pro installed on " & $sALPInstallDir)
;~ EndIf

Global $alpfilesX86[5]
Global $alpfilesX64[5]

$alpfilesX86[0] = $sALPInstallDir & "\asiolink.dll"
$alpfilesX86[1] = $sALPInstallDir & "\asiovadpro.cat"
$alpfilesX86[2] = $sALPInstallDir & "\asiovadpro.inf"
$alpfilesX86[3] = $sALPInstallDir & "\asiovadpro.sys"
$alpfilesX86[4] = $sALPInstallDir & "\installer.exe"

$alpfilesX64[0] = $sALPInstallDir & "\x64\asiolink.dll"
$alpfilesX64[1] = $sALPInstallDir & "\x64\asiovadpro.cat"
$alpfilesX64[2] = $sALPInstallDir & "\x64\asiovadpro.inf"
$alpfilesX64[3] = $sALPInstallDir & "\x64\asiovadpro.sys"
$alpfilesX64[4] = $sALPInstallDir & "\x64\installer.exe"

If @OSArch = "X64" Then
	If FileExists($alpfilesX64[2]) Then
		If FileCheckString("Topo16",$alpfilesX64[2]) Then
			$sChannelType = "16devices_2channels"
		Else
			$sChannelType = "4devices_8channels"
		EndIf
	Else
		MsgBox(0,"No inf file found", "We can't find the inf file to determine your ALP installation.Exiting.")
		Exit
	EndIf
ElseIf @OSArch = "X86" Then
	If FileExists($alpfilesX86[2]) Then
		If FileCheckString("Topo16",$alpfilesX64[2]) Then
			$sChannelType = "16devices_2channels"
		Else
			$sChannelType = "4devices_8channels"
		EndIf
	Else
		MsgBox(0, "No inf file found", "We can't find the inf file to determine your ALP installation.Exiting.")
		Exit
	EndIf
EndIf

;~ MsgBox(0,"Channel type detected",$sChannelType)

$sScriptFolderFix = @ScriptDir & "\fix"
$bScriptFolderOk = FileExists($sScriptFolderFix)
If $bScriptFolderOk = 0 Then
	MsgBox(16, "No Fix folder", "We couldn't find the fix folder together with this script/executable. Please, keep the fix folder with its proper contents. Exiting.")
	Exit
EndIf

Global $fixfiles [5]

$fixfiles[0] = $sScriptFolderFix & "\x86\asiolink.dll"
$fixfiles[1] = $sScriptFolderFix & "\x64\asiolink.dll"
$fixfiles[2] = $sScriptFolderFix & "\"& @OSArch &"\"& $sChannelType &"\asiovadpro.cat"
$fixfiles[3] = $sScriptFolderFix & "\"& @OSArch &"\"& $sChannelType &"\asiovadpro.inf"
$fixfiles[4] = $sScriptFolderFix & "\"& @OSArch &"\"& $sChannelType &"\asiovadpro.sys"


If ProcessExists("asiolinktool.exe") then ProcessClose("asiolinktool.exe")

If @OSArch = "X64" Then
	RunWait($alpfilesX64[4] & " uninstall", $sALPInstallDir & "\x64")
	Sleep(2000)
	FileCopy($fixfiles[0], $sALPInstallDir,1)
	FileCopy($fixfiles[1], $sALPInstallDir & "\x64",1)
	FileCopy($fixfiles[2], $sALPInstallDir & "\x64",1)
	FileCopy($fixfiles[3], $sALPInstallDir & "\x64",1)
	FileCopy($fixfiles[4], $sALPInstallDir & "\x64",1)
	Sleep(2000)
	RunWait($alpfilesX64[4] & " install", $sALPInstallDir & "\x64")
	MsgBox(0,"DONE","DONE. Please wait a few seconds until the devices reappear again on your sound control panel.")
ElseIf @OSArch = "X86" Then
	RunWait($alpfilesx86[4] & " uninstall", $sALPInstallDir)
	Sleep(2000)
	FileCopy($fixfiles[0], $sALPInstallDir,1)
	FileCopy($fixfiles[2], $sALPInstallDir,1)
	FileCopy($fixfiles[3], $sALPInstallDir,1)
	FileCopy($fixfiles[4], $sALPInstallDir,1)
	Sleep(2000)
	RunWait($alpfilesX86[4] & " install", $sALPInstallDir)
	MsgBox(0,"DONE","DONE. Please wait a few seconds until the devices reappear again on your sound control panel.")
EndIf


Func FileCheckString($sStringToFind, $sFileToCheck)
	$hFileOpen = FileOpen($sFileToCheck,0)
	For $i=1 to _FileCountLines($sFileToCheck)
		$sLineRead = FileReadLine($hFileOpen,$i)
		if StringInStr($sLineRead,$sStringToFind,0) > 0 Then
			FileClose($hFileOpen)
			Return True
			ExitLoop
		EndIf
		if $i = _FileCountLines($sFileToCheck) Then
			FileClose($hFileOpen)
			Return False
			ExitLoop
		EndIf
	Next
EndFunc
