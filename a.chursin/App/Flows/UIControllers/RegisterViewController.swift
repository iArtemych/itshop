import UIKit

class RegisterViewController: UIViewController
{
    //MARK: - Constants
    let requestFactory = RequestFactory()
    let alertFactory = AlertFactory()
    //MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var genderSegmented: UISegmentedControl!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var creditCardInput: UITextField!
    @IBOutlet weak var aboutInput: UITextView!
    @IBOutlet weak var registerButton: UIButton!
    
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
    //TODO: gender доделать
    @IBAction func registerActionButton(_ sender: Any)
    {
        let segueIdentifier = "registerEnd"

        registration() { [weak self] registrResult in
            if registrResult
            {
                self?.performSegue(withIdentifier: segueIdentifier, sender: nil)
            }
            else
            {
                let title = "Error"
                let massage = "Incorrect data!"
                let button = "Ok"
                self?.alertFactory.singlButtonAlert(alertTitle: title,
                                                    alertMassage: massage,
                                                    alertButton: button,
                                                    controller: self!)
            }
        }
    }
    
    //MARK: - Private methods
    
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

    private func registration(completion: @escaping (Bool) -> Void)
    {
        let randomCount = Int(arc4random_uniform(UInt32(2000)))
        let registr = requestFactory.makeAccauntRequestFactory()
        var registrResult = false
        let userData: UserData!
        
        if let login = loginInput.text,
            let password = passwordInput.text,
            let email = emailInput.text,
            let creditCard = creditCardInput.text,
            let bio = aboutInput.text
        {
            userData = UserData(id: randomCount, username: login, password: password, email: email, gender: "M", creditCard: creditCard, bio: bio)
        
        
        registr.register(userData: userData){ response in
            
            switch response.result
            {
            case .success:
                registrResult = true
            case .failure:
                registrResult = false
            }
            DispatchQueue.main.async {
                completion(registrResult)
            }
        }
        }
    }
    
}
