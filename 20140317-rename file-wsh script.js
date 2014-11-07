//
//
//
//

var sFolderName, sStringToFind;
var nResult;
//////////////////////////////////////////
// Set these values
sFolderName = "C:\\Temp\\Images"; // use directory containing image
sStringToFind = ".gif.png";
sStringToReplace = ".gif";
//////////////////////////////////////////
 
nResult = renameFiles(sFolderName, sStringToFind, sStringToReplace);
WScript.Echo(nResult + " files renamed");
 
//    Function Name:    renameFiles
//    Parameters:
//    sFolder:    Folder Name (use double backslashes)
//    sString1:    String to search for
//    sString2:    String to replace
//    Returns:    Number of files renamed
 
function renameFiles(sFolder, sString1, sString2) {
    var oFSO, oFile, oFolder;
    var re, index;
    var sName;
    var i = 0, n;
 
    oFSO = new ActiveXObject("Scripting.FileSystemObject");
    oFolder = oFSO.GetFolder(sFolder);
    try {
        index = new Enumerator(oFolder.Files);
        for (; !index.atEnd(); index.moveNext()) {
            oFile = index.item();
            sName = oFile.Name;
            n = sName.indexOf(sString1);
            if(n != -1) {
                try {
                    sName = sName.substring(0, n) + sString2 + 
                            sName.substr(n + sString1.length);
                    oFile.Name = sName;
                    i++;
                } catch(e) {
                    WScript.Echo("Can not rename file " + sName + " because\n" + e.description);
                }
            }
        }
    }
    catch(e) {
        WScript.Echo("Could not access folder " + sFolder + " because\n" + e.description);
        return 0;
    } finally {
        oFSO = null;
        re = null;
        return i;
    }
}
