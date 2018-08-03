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
    
    func doubleButtonAlert(alertTitle: String,
                           alertMassage: String,
                           alertOKButton: String,
                           alertCancelButton: String,
                           controller: UIViewController) -> Bool
    {
        var flag = false
        let alert = UIAlertController(title: alertTitle,
                                      message: alertMassage,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertOKButton,
                                      style: .default,
                                      handler: { _ in
                                        flag = true}
        ))
        alert.addAction(UIAlertAction(title: alertOKButton,
                                      style: .default,
                                      handler: { _ in
                                        flag = false}
        ))
        
        controller.present(alert, animated: true, completion: nil)
        return flag
    }
}

