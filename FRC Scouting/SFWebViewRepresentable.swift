//
//  SFWebViewRepresentable.swift
//  FRC Scouting
//
//  Created by Jacob Trentini on 9/24/22.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    let sfSafariViewController: SFSafariViewController

    init(url: URL) {
        self.url = url
        self.sfSafariViewController = SFSafariViewController(url: url)
        self.sfSafariViewController.delegate = self
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) { }
}

extension SafariView: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        <#code#>
    }
}
