import UIKit

class AccauntDataViewController: UIViewController
{
    //MARK: - Constants
    let requestFactory = RequestFactory()
    let alertFactory = AlertFactory()
    var userData: UserData!
    
    //MARK: - Outlets
    @IBOutlet weak var logoutButton: UIButton!
    
    //MARK: - LifeStyle ViewController
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //TODO: Убрать вызов userData
        userData = UserData(id: 123, username: "Somebody", password: "password", email: "fuck@android", gender: "m", creditCard: "123123123", bio: "kdslflksdnfkldsnfl")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: - Navigation
    
    @IBAction func logoutActionButton(_ sender: Any)
    {
        let segueIdentifier = "logoutUnwind"
        
        deauthorization() { [weak self] logoutResult in
            if logoutResult
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
    private func deauthorization(completion: @escaping (Bool) -> Void)
    {
        let auth = requestFactory.makeAuthRequestFactory()
        var logoutResult = false
        
        auth.logout(userData: userData){ response in
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

}




