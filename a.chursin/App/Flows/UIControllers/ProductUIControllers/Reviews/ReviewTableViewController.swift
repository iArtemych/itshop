import UIKit

class ReviewTableViewController: UITableViewController {

    //MARK: - Constants
    let nameStub: [String] = ["Good choice for me","Мощный, быстрый, невероятно красивый дизайн. Изменил мое представление о технике Apple и моноблоках в целом.","Давно мечтал попробовать поработать на Мак. Был всю жизнь пк. Долго решался на покупку. Смотрел кучу отзывов и обзоров. И не пожалел ни на минуту."]
    let rewiewsStub: [String] = ["Diana","Alex","Diman2008"]
    
    //MARK: - LifeStyle ViewController
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
        
        return rewiewsStub.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell

        let review = rewiewsStub[indexPath.row]
        let reviewer = nameStub[indexPath.row]
        
        cell.reviewText.text = reviewer
        cell.reviewerName.text = review

        return cell
    }
}
