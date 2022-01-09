//
//  WebView.swift
//  MacMarkDown
//
//  Created by Ebubekir Sezer on 8.01.2022.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    
    @AppStorage("styleSheet") var styleSheet: StyleSheet = .raywenderlich
    
    var html: String
    var formattedHtml: String {
        return
"""
<html>
<head>
<link href="\(styleSheet).css" rel="stylesheet">
</head>
<body>
\(html)
</body>
</html>
"""
    }
    
    init(html: String) {
        self.html = html
    }
    
    func makeNSView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.loadHTMLString(
            formattedHtml,
            baseURL: Bundle.main.resourceURL)
    }
}
