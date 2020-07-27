#!/usr/local/bin/python3
import SimpleHTTPServer
import SocketServer
import mimetypes

PORT = 8080

Handler = SimpleHTTPServer.SimpleHTTPRequestHandler

Handler.extensions_map['.md']='text/html; charset=UTF-8'
httpd = SocketServer.TCPServer(("", PORT), Handler)

print "serving at port", PORT
httpd.serve_forever()


# Open http://localhost:8080/
