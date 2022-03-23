import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var HighScoresButton: UIButton!
    var player: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let attributedStartButtonTitle = NSAttributedString(string: "Start Game", attributes: [NSAttributedString.Key.font : UIFont(name: "Minecraft", size: 50) as Any,
             NSAttributedString.Key.foregroundColor : UIColor.white
        ])
        
        self.startButton.setAttributedTitle(attributedStartButtonTitle, for: .normal)
        
        
        self.startButton.setShadowThree()
        
        let attributedScoreButtonTitle = NSAttributedString(string: "HighScore", attributes: [NSAttributedString.Key.font : UIFont(name: "Minecraft", size: 30) as Any,
                    NSAttributedString.Key.foregroundColor : UIColor.white
               ])
               
               self.HighScoresButton.setAttributedTitle(attributedScoreButtonTitle, for: .normal)
               
               
               self.HighScoresButton.setShadowThree()
        
        self.startButton.layer.cornerRadius = self.startButton.frame.size.width / 14
        
        self.HighScoresButton.layer.cornerRadius = self.HighScoresButton.frame.size.width / 14       
        setNavBarTransparent()
    }
    
    @IBAction func myStartButtonPressed(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.playSound()
        controller.player = player
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func myHighScoresButtonPressed(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "HighscoresViewController") as! HighscoresViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
    
    func playSound() {
           guard let path = Bundle.main.path(forResource: "3", ofType: "mp3") else { return }
           let url = URL(fileURLWithPath: path)
           
           do {
               try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
               try AVAudioSession.sharedInstance().setActive(true)

               player = try AVAudioPlayer(contentsOf: url)
               guard let player = player else { return }
            player.volume = 0.2
               player.prepareToPlay()
               player.play()
            

           } catch let error {
               print(error.localizedDescription)
           }
       }
    
    
    
}

