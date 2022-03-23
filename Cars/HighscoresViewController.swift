import UIKit

class HighscoresViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var array = UserDefaults.standard.array(forKey: "scoresArray") as? [String] ?? [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sort()
        setBackButton()
        setNavBarTransparent()
        self.label.text = "Highscore"
        self.label.font = UIFont(name: "Minecraft", size: 30)
        
        tableView.reloadData()
    }
    
    @IBAction func BackPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func sort() {
        array.sort { (value1, value2) -> Bool in
            guard let value1Result = value1.components(separatedBy: " ").first, let value1Double = Double(value1Result),
                let value2Result = value2.components(separatedBy: " ").first, let value2Double = Double(value2Result) else{return value1 > value2}
            
            return value1Double > value2Double
        }
    }
}

extension HighscoresViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else {return UITableViewCell() }
        cell.labels?.text = array[indexPath.row]
        
        return cell
    }
}
