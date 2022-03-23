import UIKit
import AVFoundation
import AVKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var Go: UIButton!
    @IBOutlet weak var mclaren: UIButton!
    @IBOutlet weak var tesla: UIButton!
    @IBOutlet weak var formulaOne: UIButton!
    @IBOutlet weak var okOne: UIImageView!
    @IBOutlet weak var okTwo: UIImageView!
    @IBOutlet weak var okThree: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelChoose: UILabel!
    @IBOutlet weak var mc: UILabel!
    @IBOutlet weak var tes: UILabel!
    @IBOutlet weak var form: UILabel!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var okEasy: UIImageView!
    @IBOutlet weak var okHard: UIImageView!
    
    
    
    var player: AVAudioPlayer?
    var choosePlayer: AVAudioPlayer?
    var selectedCarImage: UIImage? = UIImage(named: "mclaren")
    var selectedComplexity: Double? = 1.6

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let string = UserDefaults.standard.object(forKey: "key") as? String
        name.text = string
        
        self.labelName.font = UIFont(name: "Minecraft", size: 25)
        self.labelChoose.font = UIFont(name: "Minecraft", size: 25)
        self.mc.font = UIFont(name: "Minecraft", size: 16)
        self.tes.font = UIFont(name: "Minecraft", size: 16)
        self.form.font = UIFont(name: "Minecraft", size: 16)
        
        
        
        self.okOne.setShadow()
        self.okTwo.setShadow()
        self.okThree.setShadow()
        setBackButton()
        setNavBarTransparent()
        self.name.font = UIFont(name: "Minecraft", size: 30)
    }
    
    @IBAction func easyPressed(_ sender: UIButton) {
        self.playSound()
        selectedComplexity = 1.2
        self.okEasy.isHidden = false
        self.okHard.isHidden = true
    }
    
    
    @IBAction func hardPressed(_ sender: UIButton) {
        self.playSound()
        selectedComplexity = 0.8
        self.okEasy.isHidden = true
        self.okHard.isHidden = false
    }
    
    
    @IBAction func StartTheGame(_ sender: UIButton) {
        self.playSound()
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.navigationController?.pushViewController(controller, animated: true)
        guard let carImage = self.selectedCarImage else { return }
        controller.car = carImage
        guard let complexity = self.selectedComplexity else { return }
        controller.speed = complexity
        controller.player = player
        
        controller.name = name.text
        UserDefaults.standard.set(name.text, forKey: "key")
    }
    
    func playSound() {
           guard let path = Bundle.main.path(forResource: "1", ofType: "mp3") else { return }
           let url = URL(fileURLWithPath: path)

           do {
               try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
               try AVAudioSession.sharedInstance().setActive(true)

               choosePlayer = try AVAudioPlayer(contentsOf: url)
               guard let player = choosePlayer else { return }
            player.volume = 0.4
               player.prepareToPlay()
               player.play()


           } catch let error {
               print(error.localizedDescription)
           }
       }
    
    
    @IBAction func myMcPressed(_ sender: UIButton) {
        self.playSound()
        selectedCarImage = UIImage(named: "mclaren")
        self.okOne.isHidden = false
        self.okTwo.isHidden = true
        self.okThree.isHidden = true
    }
    
    @IBAction func myTeslaPressed(_ sender: UIButton) {
        self.playSound()
        selectedCarImage = UIImage(named: "tesla")
        self.okTwo.isHidden = false
        self.okOne.isHidden = true
        self.okThree.isHidden = true
    }
    @IBAction func myFormPressed(_ sender: UIButton) {
        self.playSound()
        selectedCarImage = UIImage(named: "formula")
        self.okOne.isHidden = true
        self.okTwo.isHidden = true
        self.okThree.isHidden = false
    }
}


