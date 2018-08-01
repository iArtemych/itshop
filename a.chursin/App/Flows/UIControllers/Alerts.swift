// фабрика алертов
import Foundation
import UIKit


class AlertFactory
{
    func singlButtonAlert(alertTitle: String,
                          alertMassage: String,
                          alertButton: String,
                          controller: UIViewController)
    
    {
        let alert = UIAlertController(title: alertTitle,
                                      message: alertMassage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertButton,
                                      style: .default,
                                      handler: { _ in
                                        NSLog("The \"OK\" alert occured.")}
        ))
        controller.present(alert, animated: true, completion: nil)
    }
    
}

