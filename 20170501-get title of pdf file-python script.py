import sys
import re
import logging

from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from pdfminer.converter import TextConverter
from pdfminer.layout import LAParams
from pdfminer.pdfpage import PDFPage
from cStringIO import StringIO

def double_quote(word):
    double_q = '"' # double quote
    return double_q + word + double_q

def convert_pdf_to_txt(path,maxpages = 1):
    rsrcmgr = PDFResourceManager()
    retstr = StringIO()
    codec = 'utf-8'
    laparams = LAParams()
    device = TextConverter(rsrcmgr, retstr, codec=codec, laparams=laparams)
    fp = file(path, 'rb')
    interpreter = PDFPageInterpreter(rsrcmgr, device)
    password = ""    
    caching = True
    pagenos=set()

    for page in PDFPage.get_pages(fp, pagenos, maxpages=maxpages, password=password,caching=caching, check_extractable=True):
        interpreter.process_page(page)

    text = retstr.getvalue()

    fp.close()
    device.close()
    retstr.close()
    return text

logging.basicConfig(level=logging.DEBUG, filename="logfile.txt", filemode="a+", format="%(asctime)-15s %(levelname)-8s %(message)s")
	
filename=" ".join(str(x) for x in sys.argv[1:])
logging.info("file:%s", filename)
firstpagetext=convert_pdf_to_txt(filename)
print firstpagetext.split("\n")[0]
