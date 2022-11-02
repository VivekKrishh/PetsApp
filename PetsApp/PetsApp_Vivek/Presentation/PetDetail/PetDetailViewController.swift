//
//  PetDetailViewController.swift
//  PetsApp_Vivek
//

import UIKit
import WebKit

class PetDetailViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webkit: WKWebView!
    
    var viewModel: PetDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.getPetTitle()
        initWebKit()
    }
    
    func initWebKit() {
        let urlRequest = URLRequest(url: URL(string: viewModel.getPetContentURL())!)
        webkit.navigationDelegate = self
        webkit.load(urlRequest)
        activityIndicator.startAnimating()
    }
}

extension PetDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading")
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
