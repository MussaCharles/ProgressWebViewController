//
//  ViewController.swift
//  ProgressWebViewControllerDemo
//
//  Created by Zheng-Xiang Ke on 2017/10/14.
//  Copyright © 2017年 Zheng-Xiang Ke. All rights reserved.
//

import UIKit
import ProgressWebViewController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier, let url = URL(string: "https://m.post.naver.com/viewer/postView.nhn?volumeNo=31526768&memberNo=24772684"/*"https://www.google.com"*/) else {
            return
        }

        switch identifier {
        case "Present":
            guard let navigationController = segue.destination as? UINavigationController, let progressWebViewController = navigationController.topViewController as? ProgressWebViewController else {
                return
            }
            
            navigationController.navigationBar.isTranslucent = false

            progressWebViewController.pullToRefresh = true
            progressWebViewController.url = url
            progressWebViewController.bypassedSSLHosts = [url.host!]
            progressWebViewController.userAgent = "ProgressWebViewController/1.0.0"
            progressWebViewController.websiteTitleInNavigationBar = false
            progressWebViewController.navigationItem.title = "Google Website"
            progressWebViewController.navigationWay = .browser
            progressWebViewController.viewBackGroundColor = UIColor.white
//            progressWebViewController.toolbarItemTypes = []//[.back, .forward, .reload, .activity]
            
            progressWebViewController.toogleToolBarOnScroll = true
            progressWebViewController.openATagTabsOrNewWindowsNavigationType = .browser//.push
            progressWebViewController.forceOpenAllURLSWithinTheApp = true
            progressWebViewController.isScrollEnabled = true
            
            // Custom back arrows
            progressWebViewController.backAndNextButtonApperance = .arrow
            progressWebViewController.tintColor = UIColor.black
            progressWebViewController.progressBarOnlyTintColor = UIColor.red
//            progressWebViewController.tintColor = UIColor.black
        
//            progressWebViewController.navigationController?.automaticallyAdjustsScrollViewInsets = false
        
        case "Show":
            guard let progressWebViewController = segue.destination as? ProgressWebViewController else {
                return
            }
            
            progressWebViewController.isScrollEnabled = true
            progressWebViewController.disableZoom = true
            progressWebViewController.toolbarItemTypes = [.back, .forward, .reload, .activity]
            progressWebViewController.url = url
            progressWebViewController.defaultHeaders = ["browser": "in-app browser"]
            progressWebViewController.tintColor = .red
            progressWebViewController.defaultCookies = [
                HTTPCookie(properties:
                [HTTPCookiePropertyKey.originURL: url.absoluteString,
                 HTTPCookiePropertyKey.path: "/",
                 HTTPCookiePropertyKey.name: "author",
                 HTTPCookiePropertyKey.value: "Zheng-Xiang Ke"])!,
                HTTPCookie(properties:
                [HTTPCookiePropertyKey.originURL: url.absoluteString,
                 HTTPCookiePropertyKey.path: "/",
                 HTTPCookiePropertyKey.name: "GitHub",
                 HTTPCookiePropertyKey.value: "kf99916"])!]
        default:
            print("Unknown segue \(identifier)")
        }
    }
}

