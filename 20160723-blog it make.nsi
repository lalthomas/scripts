; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Blogit"
!define PRODUCT_VERSION "0.01"
!define PRODUCT_PUBLISHER "devel Mind"
!define PRODUCT_WEB_SITE "http://www.develmind.blogspot.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\blogit.bat"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define CONTEXT_MENU "$\"$PROGRAMFILES\Blogit\Blogit.bat$\"$\"%1$\""
;$\"%1$\""
; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "20160723-blog it icon.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "20160723-blog it license.txt"
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "setup.exe"
InstallDir "$PROGRAMFILES\Blogit"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  
  SetOutPath "$INSTDIR\templates"
  SetOverwrite ifnewer
  File "src\*.*" 
  File "20160723-blog it.bat" 
  File "20160723-blog it.bat" 
  File "templates\20151224-blog header include template.sql"
  File "templates\20151224-blog header include template.txt"
  File "templates\20151224-blog header include template.vb"
  File "templates\20151224-blog header include template.xml"
  File "templates\20151224-blog header style.txt"
  File "templates\20151224-blog html head.txt"
  File "templates\20151224-blog html meta.txt"
  File "templates\20151224-blog info template.txt"
  File "templates\20151224-blog remarks.txt"
  File "templates\20151224-blog body div closing 02.txt"
  File "templates\20151224-blog body div closing.txt"
  File "templates\20151224-blog body program section.txt"
  File "templates\20151224-blog body start.txt"
  File "templates\20151224-blog body template 01.txt"
  File "templates\20151224-blog body template 02.txt"
  File "templates\20151224-blog body template 03.txt"
  File "templates\20151224-blog body template 04.txt"
  File "templates\20151224-blog body template 05.txt"
  File "templates\20151224-blog header include template.c"
  File "templates\20151224-blog header include template.cpp"
  File "templates\20151224-blog header include template.cs"
  File "templates\20151224-blog header include template.css"
  File "templates\20151224-blog header include template.java"
  File "templates\20151224-blog header include template.js"
  File "templates\20151224-blog header include template.php"
  File "templates\20151224-blog header include template.py"
  File "templates\20151224-blog readme.md"
  
  SetOutPath "$INSTDIR\tools"  
  File "tools\csplit\csplit.exe"  
  File "tools\csplit\libiconv2.dll"  
  File "tools\csplit\libintl3.dll"  
  File "tools\fart\fart.exe" 
  File "tools\htb\htb.exe" 
  File "tools\rxfind\rxfind.exe" 
  
  SetOutPath "$DESKTOP"  
  CreateDirectory "$SMPROGRAMS\develmind"
  CreateShortCut "$SMPROGRAMS\develmind\readme.lnk" "$INSTDIR\templates\20151224-blog readme.md"
  
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  SetShellVarContext current
  WriteRegStr HKCR "*\shell\Blog\Command\" "" "${CONTEXT_MENU}"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\blogit.bat"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\Tools\csplit.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\templates\*.*"
  Delete "$INSTDIR\*.*"  
  RMDir "$INSTDIR\tools"
  RMDir "$INSTDIR\templates"
  RMDir "$INSTDIR\blogit"
  RMDir "$INSTDIR"  
  Delete "$SMPROGRAMS\Devel Mind\Readme.lnk"
  RMDir "$SMPROGRAMS\Devel Mind"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  DeleteRegKey HKCR "*\shell\Blog\"
  SetAutoClose true
SectionEnd