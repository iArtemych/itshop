import UIKit

class GoodsListTableViewController: UITableViewController {
    
    //MARK: - Constants
    let requestFactory = RequestFactory()
    let alertFactory = AlertFactory()
    var itemRequest: ItemRequest!
    
    //MARK: - Variables
    private var goodsArr: [GoodsResult] = []
    
    //MARK: - LifeStyle ViewController
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
        return goodsArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goodsCell", for: indexPath) as! GoodsListTableViewCell
        
        let good = goodsArr[indexPath.row]
        cell.goodName.text = good.productName
        cell.goodPrice.text = String(good.price)
        cell.goodImage.image = #imageLiteral(resourceName: "Beer")

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if  segue.identifier == "productPage"
        {
            let destination = segue.destination as? ProductViewController
            if let selectedRow = tableView.indexPathForSelectedRow?.row
            {
                destination?.productId = goodsArr[selectedRow].idProduct
            }
        }
    }
    
    //MARK: - Private methods
    private func goodList(completion: @escaping ([GoodsResult]) -> Void)
    {
        itemRequest = ItemRequest(pageNumber: 1, idCategory: 1)
        
        let product = requestFactory.makeProductRequestFactory()
        
        product.productList(itemRequest: itemRequest){ response in
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
        goodList(){ [weak self] arr in
            self?.goodsArr = arr
            self?.tableView.reloadData()
        }
    }
}
