import UIKit

private enum AuthFlag
{
    case isAuth
    case isNotAuth
}

class AddReviewViewController: UIViewController
{
    //MARK: - Constants
    let requestFactory = RequestFactory()
    let alertFactory = AlertFactory()
    let userDefaults = UserDefaults.standard
    
    //MARK: - Variables
    var reviewCart: ReviewAddResult!
    private var idUser: Int = 0
    private var isAuthtorizaytion: AuthFlag = .isNotAuth
    
    //MARK: - Outlets
    @IBOutlet weak var addReviewButton: UIButton!
    @IBOutlet weak var textReview: UITextView!
    
    //MARK: - LifeStyle ViewController
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: - Navigation
    
    @IBAction func addReviewAction(_ sender: Any)
    {
        checkReview()
        if isAuthtorizaytion == .isAuth
        {
            productPage()
        }
    }
    //MARK: - Private methods
    
    // Проверка совершен ли вход в систему
    private func checkReview()
    {
        idUser = userDefaults.integer(forKey: "userId")
        if idUser == 0
        {
            let title = "Error"
            let massage = "You should log in before send reviews"
            let button = "Ok"
            
            alertFactory.singlButtonAlert(alertTitle: title, alertMassage: massage, alertButton: button, controller: self)
            isAuthtorizaytion = .isNotAuth
        }
        else
        {
            isAuthtorizaytion = .isAuth
        }
    }
    
    private func reviewReq(completion: @escaping (ReviewAddResult) -> Void)
    {
        let review = requestFactory.makeReviewRequestFactory()
        
        if let text = textReview.text
        {
            review.addReview(idUser: idUser, text: text){ response in
                switch response.result
                {
                case .success(let reviewAnswer):
                    DispatchQueue.main.async {
                        completion(reviewAnswer)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        else
        {
            let title = "Error"
            let massage = "You should write review before send it"
            let button = "Ok"
            alertFactory.singlButtonAlert(alertTitle: title,
                                          alertMassage: massage,
                                          alertButton: button,
                                          controller: self)
        }
    }
    
    private func productPage()
    {
        reviewReq(){ [weak self] review in
            self?.reviewCart = review
            if self?.reviewCart.result == 1
            {
                let title = "Thanks for review"
                let massage = "Feedback sent for moderation"
                let button = "Ok"
                
                self?.alertFactory.singlButtonAlert(alertTitle: title,
                                                    alertMassage: massage,
                                                    alertButton: button,
                                                    controller: self!)
            }
        }
    }
}
