setlocal
@echo OFF
:END
echo <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> <html lang=en xml:lang=en xmlns=http://www.w3.org/1999/xhtml> <head> <meta content="text/html; charset=us-ascii" http-equiv=content-type /> <title>Patterns</title> <style media=screen type=text/css>*{margin:0;padding:0;}body{background-color:#000;color:#ccc;font-family:verdana, sans-serif;font-size:11px;}a,a:visited,a:active{outline:none;text-decoration:none;color:#666;}img{vertical-align:bottom;border:none;}#page{padding-top:100px;}#content{width:90%;margin:0 auto;}.pager a,.pager a:visited,.pager a:active{color:#ccc;border:solid 1px #333;background-color:#333;padding:2px 6px;}.pager a:hover{color:#fff;border:solid 1px #666;background-color:#666;background-image:none;}.pager span{color:#999;padding:2px 6px;}.pager span.active{border:solid 1px #ccc;background-color:#000;background-image:none;color:#fff;}.pager span.count{color:#666;}span.clear{display:block;clear:both;height:0;overflow:hidden;}#patterns p{display:inline;float:left;width:140px;margin:0 10px 20px;}#patterns p span{display:block;width:138px;height:138px;border:solid 1px #fff;}#patterns p span img{display:none;}#patterns p a{display:block;text-align:center;color:#999;padding-top:1px;background-color:#333;border:solid 1px #333;border-top:none;}#navigation{margin:10px 0 30px 10px;}#usage{margin-left:10px;margin-right:10px;background-color:#1e1e1e;color:#666;padding:10px;}a:hover,#patterns p a:hover{color:#fff;}</style> </head> <body> <div id=body> <div id=page> <div id=content> <div id=patterns> 
echo <p><span style=background-image:url($IMAGE$);></span><a href="'+PatternName+'">$FILENAME$</a></p>
echo </div> </div> </div> </div> </body> </html> 
::pause
endlocal