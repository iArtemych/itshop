import UIKit

enum basketFlag
{
    case inBasket
    case isNotInBasket
}

class ProductViewController: UIViewController
{
    //MARK: - Constants
    let requestFactory = RequestFactory()
    let alertFactory = AlertFactory()
    
    //MARK: - Variables
    private var productCart: ItemResult!
    private var addedGood: BasketAddResult!
    private var removedGood: BasketRemoveResult!
    private var isAddedInBasket: basketFlag = .isNotInBasket
    var productId = 0
    
    //MARK: - Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var producrReviews: UIButton!
    @IBOutlet weak var productAddToBasket: UIButton!
    @IBOutlet weak var productDescription: UITextView!
    
    //MARK: - LifeStyle ViewController
    override func viewDidLoad()
    {
        super.viewDidLoad()
        productDescription.isEditable = false
        productPage()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: - Private methods
    private func addToBasketReqest(completion: @escaping (BasketAddResult) -> Void)
    {
        let basket = requestFactory.makeBasketRequestFactory()
        
        basket.addToBasket(idProduct: productId, quantity: 1){ response in
            switch response.result
            {
            case .success(let productAnswer):
                DispatchQueue.main.async {
                    completion(productAnswer)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func removeFromBasketReqest(completion: @escaping (BasketRemoveResult) -> Void)
    {
        let basket = requestFactory.makeBasketRequestFactory()
        
        basket.removeFromBasket(idProduct: productId){ response in
            switch response.result
            {
            case .success(let productAnswer):
                DispatchQueue.main.async {
                    completion(productAnswer)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func addToBasketAction(_ sender: Any)
    {
        if isAddedInBasket == .isNotInBasket
        {
            addToBasketReqest(){ [weak self] addedProduct in
                self?.addedGood = addedProduct
                
                if self?.addedGood.result == 1
                {
                    let buttonTitle = "Remove from basket"
                    self?.productAddToBasket.setTitle(buttonTitle, for: .normal)
                    self?.isAddedInBasket = .inBasket
                }
                else
                {
                    self?.alertFactory.singlButtonAlert(alertTitle: "Error",
                                                        alertMassage: "Error with add to basket",
                                                        alertButton: "Ok",
                                                        controller: self!)
                }
            }
        }
        else
        {
            removeFromBasketReqest(){ [weak self] removedProduct in
                self?.removedGood = removedProduct
                
                if self?.removedGood.result == 1
                {
                    let buttonTitle = "Add to basket"
                    self?.productAddToBasket.setTitle(buttonTitle, for: .normal)
                    self?.isAddedInBasket = .isNotInBasket
                }
                else
                {
                    self?.alertFactory.singlButtonAlert(alertTitle: "Error",
                                                        alertMassage: "Error with remove from basket",
                                                        alertButton: "Ok",
                                                        controller: self!)
                }
            }
        }
    }
    
    private func productReqest(completion: @escaping (ItemResult) -> Void)
    {
        let product = requestFactory.makeProductRequestFactory()
        
        product.productItem(idProduct: productId){ response in
            switch response.result
            {
            case .success(let productAnswer):
                DispatchQueue.main.async {
                    completion(productAnswer)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func productPage()
    {
        productReqest(){ [weak self] product in
            self?.productCart = product
            self?.printProduct()
        }
    }
    
    private func printProduct()
    {
        let stub = "\nНИЧТО НЕ ПОМЕШАЕТ ИГРЕ \nРазрешение Full HD 1920x1080 пикселей позволяет видеть все детали даже в процессе динамичной игры. За счёт антибликового покрытия внешний источник света никак не влияет на видимость картинки. Также на нём меньше заметны отпечатки пальцев."
        productImage.image = #imageLiteral(resourceName: "Book")
        productName.text = "Name: " + productCart.productName
        productPrice.text = "Price: " + String(productCart.productPrice) + "$"
        productDescription.text = productCart.productDescription + stub
        self.navigationItem.title = productCart.productName
    }
}
