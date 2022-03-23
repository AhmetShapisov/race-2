import UIKit
import AVFoundation
import AVKit


class CrashViewController: UIViewController {
    
    @IBOutlet weak var mainMenuButton: UIButton!
    @IBOutlet weak var wasted: UILabel!
    @IBOutlet weak var mainMenu: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    
    var player: AVAudioPlayer?
    var name: String?
    var car = UIImage(named: "mclaren")
    var scoreValue: Double?
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wasted.font = UIFont(name: "Minecraft", size: 45)
        self.score.font = UIFont(name: "Minecraft", size: 40)
        self.labelScore.font = UIFont(name: "Minecraft", size: 30)
        self.mainMenu.font = UIFont(name: "Minecraft", size: 30)
        self.score.text = String.init(format: "%.2f miles", scoreValue ?? 0.0)
        self.getDate()
        
        self.highBackButton()
        self.wasted.setShadowThree()
        self.score.setShadowThree()
        self.labelScore.setShadowThree()
        self.mainMenu.setShadow()
  
        
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        if var array = UserDefaults.standard.array(forKey: "scoresArray") as? [String],
            let score = scoreValue, let name = name, let date = date {
            array.append(String(format: "%.2f miles - %@ - %@", score, name, date))
            UserDefaults.standard.set(array, forKey: "scoresArray")
            print(date)
            
        } else if let score = scoreValue, let name = name, let date = date {
            var array: [String] = []
            array.append(String(format: "%.2f miles - %@ - %@", score, name, date))
            UserDefaults.standard.set(array, forKey: "scoresArray")
            print(date)
        }
        
        guard let settingsVC = navigationController?.viewControllers[0]
            else {return}
       
        navigationController?.popToViewController(settingsVC, animated: true)
     
    }
    
    func highBackButton() {
        let backButton = UIBarButtonItem()
        navigationItem.leftBarButtonItem = backButton
    }
    
    func getDate() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd / MMM / yyyy"
        let datestring = formatter.string(from: Date())
        print(datestring)
        date = datestring
        return date
    }
    
    func playSound() {
              guard let path = Bundle.main.path(forResource: "track", ofType: "mp3") else { return }
              let url = URL(fileURLWithPath: path)
              
              do {
                  try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                  try AVAudioSession.sharedInstance().setActive(true)

                  player = try AVAudioPlayer(contentsOf: url)
                  guard let player = player else { return }
               player.volume = 0.3
                  player.prepareToPlay()
                  player.play()
               

              } catch let error {
                  print(error.localizedDescription)
              }
          }
    
    

}
