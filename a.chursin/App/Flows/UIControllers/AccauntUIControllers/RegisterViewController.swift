import UIKit

private enum AuthFlag
{
    case isAuth
    case isNotAuth
}

class RegisterViewController: UIViewController
{
    //MARK: - Constants
    let requestFactory = RequestFactory()
    let alertFactory = AlertFactory()
    let userDefaults = UserDefaults.standard
    
    //MARK: - Variables
    private var isAuththorization: AuthFlag = .isNotAuth
    
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
        
        isAuth()
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
    // Метод для регистрации или редоктирования аккаунта
    //(зависит: совершен ли вход)
    @IBAction func registerActionButton(_ sender: Any)
    {
        if isAuththorization == .isAuth
        {
            editUserData()
        }
        else
        {
            registerUserData()
        }
    }
    
    // Метод для выхода с контроллера редоктирования аккаунта
    //(зависит: совершен ли вход)
    @IBAction func backButtonAction(_ sender: Any)
    {
        if isAuththorization == .isAuth
        {
            let segueIdentifier = "editEnd"
            performSegue(withIdentifier: segueIdentifier, sender: nil)
        }
        else
        {
            let segueIdentifier = "registerEnd"
            performSegue(withIdentifier: segueIdentifier, sender: nil)
        }
    }
    
    //MARK: - Private methods
    @IBAction private func segmentedGenderAction(_ sender: Any)
    {
        
    }
    
    private func registerUserData()
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
    
    private func editUserData()
    {
        let segueIdentifier = "editEnd"
        
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
    
    private func printUserData()
    {
        loginInput.text = userDefaults.string(forKey: "login")
        passwordInput.text = userDefaults.string(forKey: "password")
        //Заглушка-----------------------------------------------
        emailInput.text = "something@mail.ru"
        creditCardInput.text = "**** **** **** 1234"
        aboutInput.text = "Сколько воды утекло, \n И теперь всё равно: что кровь, что вино. \n Больше не буду жалеть. \n Попробуй ответь, кому повезло?"
    }
    
    private func isAuth()
    {
        let login = userDefaults.string(forKey: "login")
        let password = userDefaults.string(forKey: "password")
        if login != nil && password != nil
        {
            isAuththorization = .isAuth
            printUserData()
        }
    }

    private func registration(completion: @escaping (Bool) -> Void)
    {
        let randomCount = Int(arc4random_uniform(UInt32(2000)))
        let registr = requestFactory.makeAccauntRequestFactory()
        var registrResult = false
        let userData: UserData!
        let control = genderSegmented.selectedSegmentIndex
        let gender: String
        
        if control == 0 {gender = "М"}
        else {gender = "Ж"}
        
        if let login = loginInput.text,
            let password = passwordInput.text,
            let email = emailInput.text,
            let creditCard = creditCardInput.text,
            let bio = aboutInput.text
        {
            userData = UserData(id: randomCount, username: login, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
            if isAuththorization == .isNotAuth
            {
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
            else
            {
                registr.changeOptions(userData: userData){ response in
                    
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
