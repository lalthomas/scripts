@echo OFF
setlocal
set path=%PATH%;D:\Program Files\Mozilla Thunderbird
echo Mail to
echo .....................................................
echo 1. Lal Thomas Official Blog
echo 2. Devel Mind
echo 3. Digital Career
echo 4. Digital Comfort
echo 5. Seeds of Goodness 
echo 6. Lal Test Blog
echo 7. Custom
echo .....................................................
SET /p _Opt=Enter your choice : 
@echo OFF
SET _MailAdd= "lalt_mail@yahoo.com"
IF /I "%_Opt%" == "1" ( SET _MailAdd=lal.thomas.mail.lalblog2010@blogger.com )
IF /I "%_Opt%" == "2" ( SET _MailAdd=lal.thomas.mail.develmind10101010@blogger.com)
IF /I "%_Opt%" == "3" ( SET _MailAdd=lal.thomas.mail.careermatters999@blogger.com)
IF /I "%_Opt%" == "4" ( SET _MailAdd=lal.thomas.mail.digitalcomfort420@blogger.com)
IF /I "%_Opt%" == "5" ( SET _MailAdd=lal.thomas.mail.seedsofgoodness101@blogger.com)
IF /I "%_Opt%" == "6" ( SET _MailAdd=lal.thomas.mail.laltestblog2000@blogger.com)
IF /I "%_Opt%" == "7" ( SET /p _MailAdd=Enter your mail address : )
@echo ON
pause
call thunderbird -compose "to='%_MailAdd%',subject='%~n1',body='%MsgBody%'"
endlocal