import UIKit

private enum AuthFlag
{
    case isAuth
    case isNotAuth
}

class AccauntDataViewController: UIViewController, TrackableMixin
{
    //MARK: - Constants
    let requestFactory = RequestFactory()
    let alertFactory = AlertFactory()
    let userDefaults = UserDefaults.standard
    
    //MARK: - Variables
    private var isAuththorization: AuthFlag = .isNotAuth
    private var user: User!
    
    //MARK: - Outlets
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userLogin: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userGender: UILabel!
    @IBOutlet weak var userCreditCard: UILabel!
    @IBOutlet weak var userBio: UITextView!
    @IBOutlet weak var editButton: UIButton!
    
    //MARK: - LifeStyle ViewController
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        userBio.isEditable = false
        isAuth()
        printUser()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Navigation
    @IBAction func unwindFuncToUserData(unwindSegue: UIStoryboardSegue)
    {
        isAuth()
        printUser()
    }
    
    @IBAction func editProfileAction(_ sender: Any)
    {
        if isAuththorization == .isAuth
        {
            let segueIdentifier = "toEdit"
            performSegue(withIdentifier: segueIdentifier, sender: nil)
        }
        else
        {
            let segueIdentifier = "toLogin"
            performSegue(withIdentifier: segueIdentifier, sender: nil)
        }
    }
    
    @IBAction func logoutActionButton(_ sender: Any)
    {
        let segueIdentifier = "toLogin"
        
        deauthorization() { [weak self] logoutResult in
            if logoutResult
            {
                self?.tracking()
                self?.removeUser()
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
    private func removeUser()
    {
        userDefaults.removeObject(forKey: "userName")
        userDefaults.removeObject(forKey: "userLastName")
        userDefaults.removeObject(forKey: "login")
        userDefaults.removeObject(forKey: "password")
        userDefaults.removeObject(forKey: "userId")
        userEmail.text = "eMail: "
        userGender.text = "Gender: "
        userImage.image = nil
        userCreditCard.text = "CreditCard: "
        userBio.text = ""
    }
    
    private func printUser()
    {
        if isAuththorization == .isAuth
        {
            let userFullName: String
            if let name = userDefaults.string(forKey: "userName"), let lastname = userDefaults.string(forKey: "userLastName")
            {
                userFullName = name + " " + lastname
            }
            else
            {
                userFullName = ""
            }
            
            userLogin.text = userFullName
        
            //Заглушка-----------------------------------------------
            userEmail.text = "eMail: something@mail.ru"
            userGender.text = "Gender: M"
            userImage.image = #imageLiteral(resourceName: "Yen")
            userCreditCard.text = "CreditCard: **** **** **** 1234"
            userBio.text = "Сколько воды утекло, \nИ теперь всё равно: что кровь, что вино. \n Больше не буду жалеть. \n Попробуй ответь, кому повезло?"
        }
    }
    
    // проверка авторизации
    private func isAuth()
    {
        let id = userDefaults.integer(forKey: "userId")

        if id > 0
        {
            isAuththorization = .isAuth
            editButton.setTitle("Edit", for: .normal)
            logoutButton.isUserInteractionEnabled = true
            logoutButton.setTitleColor(UIColor.red, for: .normal)
        }
        else
        {
            let errorAuthText = "You aren't login"
            isAuththorization = .isNotAuth
            userLogin.text = errorAuthText
            editButton.setTitle("Log in", for: .normal)
            logoutButton.isUserInteractionEnabled = false
            logoutButton.setTitleColor(UIColor.gray, for: .normal)
        }
    }
    
    private func deauthorization(completion: @escaping (Bool) -> Void)
    {
        let auth = requestFactory.makeAuthRequestFactory()
        var logoutResult = false
        let idUser = userDefaults.integer(forKey: "userId")
        auth.logout(idUser: idUser){ response in
            switch response.result
            {
            case .success:
                logoutResult = true
            case .failure:
                logoutResult = false
            }
            DispatchQueue.main.async {
                completion(logoutResult)
            }
        }
    }
    func tracking()
    {
        track(.logout)
    }
}




