% 20131027-dev-beautify source code-dos batch script readme.md 	
% 2016-10-29 	
% Lal Thomas 	
% D:\project\20131027-scripts project\20131027-dev-beautify source code-dos batch script.bat 	
	
A batch script to incorporate different pretty print tools

Previous Astyle Styling Option

	astyle --brackets=break ^
		   --max-instatement-indent=0 ^
		   --indent-brackets ^
		   --indent-labels ^
		   --indent-namespaces ^
		   --indent-cases ^
		   --indent-switches ^
		   --indent-classes ^
		   --convert-tabs		   
 
### add support for explorer extension


	Windows Registry Editor Version 5.00
	[HKEY_CLASSES_ROOT\*\shell\Beautify\Command]
	@="\"E:\\Devel\\Mis\\Beautify.bat\" \"%1\""	

