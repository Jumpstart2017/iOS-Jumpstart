//
//  VideoCard.swift
//  Jumpstart
//
//  Created by Gabriel I Leyva Merino on 11/27/17.
//  Copyright © 2017 Jumpstart. All rights reserved.
//

import Foundation
import Material


class VideoCard : Card, UIWebViewDelegate {
    
     var webView: UIWebView!
     var contentBar: Toolbar!
    
    func initVideoCardWith(url: String, title: String, description: String, embedHTML: String) {
        self.prepareToolbar(title: title, description: description)
        self.prepareContentView(url: url, embedHTML: embedHTML)
        self.prepareCard()
        
    }
    
    fileprivate func prepareContentView(url: String, embedHTML: String) {
        let contentFrame = CGRect(x: 0, y: 0, width: 340, height: 200)
        self.webView = UIWebView(frame: contentFrame)
        webView.delegate = self
        webView.scrollView.isScrollEnabled = false
        let newUrl = URL(string: url)!
        webView.loadHTMLString(embedHTML as String, baseURL: newUrl )
    }
    
    fileprivate func prepareToolbar(title: String, description: String) {
        self.contentBar = Toolbar()

        contentBar.title = title
        contentBar.titleLabel.textAlignment = .left
        
        contentBar.detail = description
        contentBar.detailLabel.textAlignment = .left
        contentBar.detailLabel.textColor = Color.grey.base
    }
    
    fileprivate func prepareCard() {
        self.bottomBar = self.contentBar
        self.bottomBarEdgeInsetsPreset = .wideRectangle3
//        self.bottomBarEdgeInsets.bottom = 0
//        self.bottomBarEdgeInsets.right = 8
        
        
        self.contentView = self.webView
        self.contentViewEdgeInsetsPreset = .wideRectangle2
    }
    
}
