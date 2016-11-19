


Add windows registry entry by saving the below code snippet as a `.reg` file


	Windows Registry Editor Version 5.00

	[HKEY_CLASSES_ROOT\*\shell\Organize\Command]
	@="\"E:\\Devel\\Mis\\Organize.bat\" \"%1\""

