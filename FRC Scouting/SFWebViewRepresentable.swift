//
//  SFWebViewRepresentable.swift
//  FRC Scouting
//
//  Created by Jacob Trentini on 9/24/22.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    public private(set) var url: URL
    
    private let sfSafariViewController: SFSafariViewController
    private let coordinator: Coordinator
    
    @Binding var safariViewControllerDidDismiss: Bool

    init(url: URL, safariViewControllerDidDismiss: Binding<Bool>) {
        self.url = url
        
        self.sfSafariViewController          = SFSafariViewController(url: url)
        self.coordinator                     = Coordinator(safariViewControllerDidDismiss: safariViewControllerDidDismiss)
        self.sfSafariViewController.delegate = self.coordinator
        
        _safariViewControllerDidDismiss = safariViewControllerDidDismiss
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func makeCoordinator() -> Coordinator {
        return self.coordinator
    }
    
    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        @Binding var safariViewControllerDidDismiss: Bool

        init(safariViewControllerDidDismiss: Binding<Bool>) {
            _safariViewControllerDidDismiss = safariViewControllerDidDismiss
            super.init()
        }
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            safariViewControllerDidDismiss.toggle()
        }
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) { }
}
