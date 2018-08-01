import UIKit

class LoginViewController: UIViewController
{
    //MARK: - Constants
    
    let requestFactory = RequestFactory()
    let alertFactory = AlertFactory()
    
    //MARK: - Outlets

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var loginLable: UITextField!
    
    @IBOutlet weak var passwordLable: UITextField!
    
    //MARK: - LifeStyle ViewController
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        hideGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        notificationKeyboardSubscribe()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        notificationKeyboardUnsubscribe()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
    
    //MARK: - Navigation
    
    @IBAction func unwindFunctoLogin(unwindSegue: UIStoryboardSegue)
    {
        
    }
    
    @IBAction func loginAction(_ sender: Any)
    {
        let login = loginLable.text!
        let password = passwordLable.text!
        let segueIdentifier = "loginSuccess"
        authorization(login: login, password: password) { [weak self] loginRusult in
            if loginRusult
            {
                self?.performSegue(withIdentifier: segueIdentifier, sender: nil)

            }
            else
            {
                let title = "Error"
                let massage = "Incorrect password or login!"
                let button = "Ok"
                self?.alertFactory.singlButtonAlert(alertTitle: title,
                                              alertMassage: massage,
                                              alertButton: button,
                                              controller: self!)
            }
        }
    }

    
    //MARK: - Private methods
    
    //TODO: Запоминать пароль после первого входа
    
    //когда клавиатура появляется
    @objc private func keyboardWasShown(notification: Notification)
    {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0,
                                             0.0,
                                             kbSize.height,
                                             0.0)
        
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //когда клавиатура исчезает
    @objc private func keyboardWillBeHidden(notification: Notification)
    {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func hideKeyboard()
    {
        self.scrollView?.endEditing(true)
    }


    private func notificationKeyboardSubscribe()
    {
        //Подписываемся на два уведомления, одно приходит при появляении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        // Пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    private func notificationKeyboardUnsubscribe()
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func hideGestureRecognizer()
    {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    private func authorization(login: String, password: String, completion: @escaping (Bool) -> Void)
    {
        let auth = requestFactory.makeAuthRequestFactory()
        var loginResult = false
        
        auth.login(login: login, password: password){ response in
            
            switch response.result
            {
            case .success:
                loginResult = true
            case .failure:
                loginResult = false
            }
            DispatchQueue.main.async {
                completion(loginResult)
            }
        }
    }
}



