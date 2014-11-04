@echo OFF
setlocal
set path=%PATH%;%CD%
set vitualdubpath=D:\Apps\PortableApps\PortableApps\VirtualDubPortable\App\VirtualDub\vdub.exe
set file=%1
set savedirectory=%~dp1%~n1
set file=%file:\=\\%
set savedirectory=%savedirectory:\=\\%

echo VirtualDub.Open(%file%,"",0); >>screen.vcf
echo VirtualDub.audio.SetSource(1); >>screen.vcf
echo VirtualDub.audio.SetMode(0); >>screen.vcf
echo VirtualDub.audio.SetInterleave(1,500,1,0,0); >>screen.vcf
echo VirtualDub.audio.SetClipMode(1,1); >>screen.vcf
echo VirtualDub.audio.SetConversion(0,0,0,0,0); >>screen.vcf
echo VirtualDub.audio.SetVolume(); >>screen.vcf
echo VirtualDub.audio.SetCompression(); >>screen.vcf
echo VirtualDub.audio.EnableFilterGraph(0); >>screen.vcf
echo VirtualDub.video.SetInputFormat(0); >>screen.vcf
echo VirtualDub.video.SetOutputFormat(7); >>screen.vcf
echo VirtualDub.video.SetMode(3); >>screen.vcf
echo VirtualDub.video.SetSmartRendering(0); >>screen.vcf
echo VirtualDub.video.SetPreserveEmptyFrames(0); >>screen.vcf
echo VirtualDub.video.SetFrameRate2(0,0,1500); >>screen.vcf
echo VirtualDub.video.SetIVTC(0, 0, 0, 0); >>screen.vcf
echo VirtualDub.video.SetCompression(); >>screen.vcf
echo VirtualDub.video.filters.Clear(); >>screen.vcf
echo VirtualDub.video.filters.Add("resize"); >>screen.vcf
echo VirtualDub.video.filters.instance[0].Config(175,175,1,4,3,1,320,240,4,3,0,6,1,0x000000); >>screen.vcf
echo VirtualDub.video.filters.Add("temporal smoother"); >>screen.vcf
echo VirtualDub.video.filters.instance[1].Config(7); >>screen.vcf
echo VirtualDub.video.filters.Add("sharpen"); >>screen.vcf
echo VirtualDub.video.filters.instance[2].Config(25); >>screen.vcf
echo VirtualDub.audio.filters.Clear(); >>screen.vcf
echo VirtualDub.subset.Clear(); >>screen.vcf
echo VirtualDub.subset.AddRange(0,81208); >>screen.vcf
echo VirtualDub.video.SetRange(); >>screen.vcf
echo VirtualDub.project.ClearTextInfo(); >>screen.vcf
echo   // -- $reloadstop -- >>screen.vcf
echo VirtualDub.SaveImageSequence("%savedirectory%\\", ".jpg", 4, 2, 95); >>screen.vcf
echo VirtualDub.audio.SetSource(1); >>screen.vcf
echo VirtualDub.Close(); >>screen.vcf
echo Customize the VCF file as per the need
pause
md  "%~dp1%~n1"
call "%vitualdubpath%" /s screen.vcf
del screen.vcf