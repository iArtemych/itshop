import UIKit

class BasketTableViewController: UITableViewController, ProductTrackableMixin
{

    //MARK: - Constants
    let requestFactory = RequestFactory()
    let alertFactory = AlertFactory()
    let userDefaults = UserDefaults.standard
    
    //MARK: - Variables
    private var price: Int = 0
    private var count: Int = 0
    private var idUser: Int = 0
    private var basketArr: [BasketContents] = []
    private var removedGood: BasketRemoveResult!
    
    //MARK: - Outlets
    @IBOutlet weak var productsBuyButton: UIBarButtonItem!
    @IBOutlet weak var basketNavigation: UINavigationItem!
    
    //MARK: - LifeStyle ViewController
    override func viewDidLoad()
    {
        super.viewDidLoad()
        idUser = userDefaults.integer(forKey: "userId")
        goodsTable()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return basketArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath) as! BasketTableViewCell
        
        let good = basketArr[indexPath.row]
        
        cell.productName.text = good.productName
        cell.productPrice.text = String(good.price) + "$"
        cell.productImage.image = #imageLiteral(resourceName: "Book")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // Удаление товара из корзины
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            let idProduct = basketArr[indexPath.row].idProduct
            
            removeFromBasketReqest(productId: idProduct){ [weak self] removedProduct in
                self?.removedGood = removedProduct
                
                if self?.removedGood.result == 1
                {
                    self?.basketArr.remove(at: indexPath.row)
                    self?.tableView.reloadData()
                }
                else
                {
                    self?.alertFactory.singlButtonAlert(alertTitle: "Error",
                                                        alertMassage: "Error with remove from basket",
                                                        alertButton: "Ok",
                                                        controller: self!)
                }
                self?.trackingRemove()
            }
        }
    }

    //MARK: - Private methods
    // Вывод суммы и количества товаров в navigation conroller
    private func barInfo()
    {
        basketNavigation.title = "\(count) goods for \(price)$"
    }
    
    private func basketList(completion: @escaping (BasketGetResult) -> Void)
    {
        let basket = requestFactory.makeBasketRequestFactory()
        
        basket.getBasket(idUser: idUser){ response in
            switch response.result
            {
            case .success(let list):
                DispatchQueue.main.async {
                    completion(list)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func goodsTable()
    {
        basketList(){ [weak self] arr in
            self?.basketArr = arr.contents
            self?.price = arr.amount
            self?.count = arr.countGoods
            self?.tableView.reloadData()
            self?.barInfo()
        }
    }
    
    private func removeFromBasketReqest(productId: Int, completion: @escaping (BasketRemoveResult) -> Void)
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
    @IBAction func purchaseAction(_ sender: Any)
    {
        let title = "Are you sure?"
        let massage = "Total price is \(price)"
        let okButton = "Yes"
        let noButton = "No"
        let purchaseAns = alertFactory.doubleButtonAlert(alertTitle: title,
                                       alertMassage: massage,
                                       alertOKButton: okButton,
                                       alertCancelButton: noButton,
                                       controller: self)
        trackingPurchase(purchaseAns: purchaseAns)
    }
    func trackingPurchase(purchaseAns: Bool)
    {
        track(.payBasket(success: purchaseAns))
    }
    func trackingRemove()
    {
        if removedGood.result == 1
        {
            track(.removeFromBasket(success: true))
        }
        else
        {
            track(.removeFromBasket(success: false))
        }
    }
    
}
