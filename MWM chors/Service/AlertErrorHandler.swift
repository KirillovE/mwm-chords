//
//  AlertErrorHandler.swift
//  MWM chors
//
//  Created by Евгений Кириллов on 13.12.2020.
//

import UIKit

struct AlertErrorHandler {
    
    func handle(_ error: TextualError) {
        DispatchQueue.main.async {
            guard let host = self.getTopController() else { return }
            
            let errorMessage = String(describing: error)
            let alert = self.getAlert(with: errorMessage)
            host.present(alert, animated: true)
        }
    }
    
    private func getTopController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedController = topController.presentedViewController {
                topController = presentedController
            }
            return topController
        } else {
            return nil
        }
    }
    
    private func getAlert(with text: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        let oKbutton = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(oKbutton)
        return alert
    }
    
}
