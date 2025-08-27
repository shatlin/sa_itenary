#!/usr/bin/env python3
"""
Simple HTTP server to view the itinerary locally
Run this script and open http://localhost:8000 in your browser
"""

import http.server
import socketserver
import webbrowser
import os

PORT = 8000

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        # Add headers to allow cross-origin requests
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET')
        self.send_header('Cache-Control', 'no-store, no-cache, must-revalidate')
        super().end_headers()

os.chdir(os.path.dirname(os.path.abspath(__file__)))

with socketserver.TCPServer(("", PORT), MyHTTPRequestHandler) as httpd:
    print(f"🌐 Server running at http://localhost:{PORT}")
    print(f"📱 On your phone, connect to the same WiFi and visit:")
    print(f"   http://[YOUR-COMPUTER-IP]:{PORT}")
    print(f"")
    print(f"Opening browser...")
    webbrowser.open(f'http://localhost:{PORT}')
    print(f"Press Ctrl+C to stop the server")
    httpd.serve_forever()