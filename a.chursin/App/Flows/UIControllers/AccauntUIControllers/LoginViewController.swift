import UIKit

class LoginViewController: UIViewController
{
    //MARK: - Constants
    let requestFactory = RequestFactory()
    let alertFactory = AlertFactory()
    let userDefaults = UserDefaults.standard
    
    //MARK: - Variables
    var user: User!
    
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
        userlogin(login: login, password: password)
    }

    //MARK: - Private methods
    private func authorization(login: String, password: String, completionHandler: @escaping ((responseResult: Int, userResult: User)) -> Void)
    {
        let auth = requestFactory.makeAuthRequestFactory()
    
        auth.login(login: login, password: password){ response in
            switch response.result
            {
            case .success(let login):
                DispatchQueue.main.async {
                    completionHandler((login.result,
                                       login.user))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func userlogin(login: String, password: String)
    {
        let segueIdentifier = "loginSuccess"
        
        userDefaults.set(login, forKey: "login")
        userDefaults.set(password, forKey: "password")
        
        authorization(login: login, password: password) { [weak self] loginRusult in
            if loginRusult.responseResult == 1
            {
                self?.userDefaults.set(loginRusult.userResult.id, forKey: "userId")
                self?.userDefaults.set(loginRusult.userResult.name, forKey: "userName")
                self?.userDefaults.set(loginRusult.userResult.lastname, forKey: "userLastName")
                
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
        
    //MARK: - Keyboard methods
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
}



