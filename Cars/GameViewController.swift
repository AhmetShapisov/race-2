import UIKit
import AVFoundation
import AVKit


class GameViewController: UIViewController {
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var myCactus: UIImageView!
    @IBOutlet weak var mySecondCactus: UIImageView!
    @IBOutlet weak var myCar: UIImageView!
    @IBOutlet weak var mountainImageView: UIImageView!
    @IBOutlet weak var myLayerForRoad: UIView!
    @IBOutlet weak var myLayerForObstacles: UIView!
    @IBOutlet weak var myCountdown: UILabel!
    @IBOutlet weak var carPosition: NSLayoutConstraint!
    
    var player: AVAudioPlayer?
    var turnSound: AVAudioPlayer?
    var engineSound: AVAudioPlayer?
    var boomSound: AVAudioPlayer?
    
    
    var roadItem = UIView()
    
    var obstacles: [UIImageView] = []
    var name: String?
    
    var car = UIImage(named: "")
    var timer: Timer?
    var runScore: Double = 0.0
    var speed: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myCountdown.text = "Highscore"
        self.myCountdown.font = UIFont(name: "Minecraft", size: 65)
        self.score.font = UIFont(name: "Minecraft", size: 20)
        
        self.myCar.setShadowTwo()
        self.myCactus.setShadow()
        self.mySecondCactus.setShadow()
        self.playSoundEngine()
        self.highBackButton()
        
        self.moveMyCactus()
        self.moveObstacle()
        self.myCar.image = car
        
        
        
        let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightDetected))
        swipeRightRecognizer.direction = .right
        self.view.addGestureRecognizer(swipeRightRecognizer)
        
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftDetected))
        swipeLeftRecognizer.direction = .left
        self.view.addGestureRecognizer(swipeLeftRecognizer)
        
        myCar.frame.origin.x = UIScreen.main.bounds.width / 2 - (myCar.frame.width / 2)
    
        self.checkAccidente()
        
        var when = DispatchTime.now() + 0
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.myCountdown.text = "3"
        }
        when = DispatchTime.now() + 0.4
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.myCountdown.text = "2"
        }
        when = DispatchTime.now() + 0.8
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.myCountdown.text = "1"
        }
        when = DispatchTime.now() + 1.2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.myCountdown.text = "Start!"
        }
        when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.myCountdown.removeFromSuperview()
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (_) in
                self.runScore += 0.04 / self.speed
                self.score.text = String.init(format: "%.2f m", self.runScore)
                self.run()
               
            }
        }
        
        self.moveMyStrip()
    }
    
    func checkAccidente() {

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { tmpTimer in
            self.checkIntersection(timer: tmpTimer)
            self.checkRoadAccidenteOne(timer: tmpTimer)
            self.checkRoadAccidenteTwo(timer: tmpTimer)
            
        }
    }
    
    func run() {
        if Int(runScore) == 10 {
            score.textColor = .systemTeal
        }
        if Int(runScore) == 20 {
            score.textColor = .orange
        }
        if Int(runScore) == 30 {
            score.textColor = .red
        }
        if Int(runScore) == 40 {
            score.textColor = .systemGreen
        }
        if Int(runScore) == 50 {
            score.textColor = .yellow
        }
    }
    
    func checkIntersection(timer: Timer) {
        for obstacle in self.obstacles {
            if obstacle.overlaps(otherView: self.myCar, in: self.view) {
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "CrashViewController") as! CrashViewController
                controller.scoreValue = runScore
                controller.name = name
                self.navigationController?.pushViewController(controller, animated: true)
                timer.invalidate()
                self.player?.stop()
                self.engineSound?.stop()
                self.playSoundBoom()
            }
        }
    }
    
    func checkRoadAccidenteOne(timer: Timer) {
        var myFrame = self.view.frame
        myFrame = CGRect(x: 300, y: 0, width: 400, height: 400)
        if myCar.frame.origin.x > myFrame.origin.x {
            print(myCar.frame.origin.x)
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "CrashViewController") as! CrashViewController
            controller.scoreValue = runScore
            controller.name = name
            self.navigationController?.pushViewController(controller, animated: true)
            timer.invalidate()
            self.player?.stop()
            self.engineSound?.stop()
            self.playSoundBoom()
        }
    }
    func checkRoadAccidenteTwo(timer: Timer) {
        var myFrame = self.view.frame
        myFrame = CGRect(x: 0, y: 0, width: 400, height: 400)
        if myCar.frame.origin.x < myFrame.origin.x {
            print(myCar.frame.origin.x)
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "CrashViewController") as! CrashViewController
            controller.scoreValue = runScore
            controller.name = name
            self.navigationController?.pushViewController(controller, animated: true)
            timer.invalidate()
            self.player?.stop()
            self.engineSound?.stop()
            self.playSoundBoom()
        }
    }
    
    func moveMyCactus () {
        
        
        UIView.animate(withDuration: 3, animations: {
            self.myCactus.frame = CGRect(x: 50, y: 120, width: 50, height: 50)
            self.mySecondCactus.frame = CGRect(x: 320, y: 120, width: 50, height: 50)
            self.myCactus.frame.origin.y += 300
            self.myCactus.frame.origin.x -= 200
            self.myCactus.frame.size = CGSize(width: 150, height: 150)
            self.mySecondCactus.frame.origin.y += 300
            self.mySecondCactus.frame.origin.x += 100
            self.mySecondCactus.frame.size = CGSize(width: 150, height: 150)
        }) { (_) in
            
            self.myCactus.frame = CGRect(x: 50, y: 120, width: 50, height: 50)
            self.mySecondCactus.frame = CGRect(x: 320, y: 120, width: 50, height: 50)
            
            self.moveMyCactus()
            
        }
    }
    
    func createRoadItem() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { tmpTimer in
            
            let roadItem = UIView()
            let x = self.myLayerForRoad.bounds.width/2 - 5
            roadItem.frame = CGRect(x: Double(x), y: 90.0, width: 5.0, height: 40 / self.speed)
            roadItem.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.myLayerForRoad.insertSubview(roadItem, aboveSubview: self.myLayerForObstacles)
            
            
            UIView.animate(withDuration: (2.7 * self.speed), animations: {
                roadItem.frame.origin.y = UIScreen.main.bounds.height * 1.2
                roadItem.frame.size.width = 15
                roadItem.frame.size.height = CGFloat(240 / self.speed)
            }) { _ in
                roadItem.removeFromSuperview()
            }
        }
    }
    
    
    func createBarrel() {
        let positionTypes: [ObstaclePositionType] = [.center, .left, .right]
        let barrelView = CustomImageView(image: UIImage(named: "\(Int.random(in: 1...3))"))
        guard let type = positionTypes.randomElement() else { return }
        barrelView.obstaclePositionType = type
        barrelView.setShadowTwo()
        var x: CGFloat = 0.0
        let centerXPosition = UIScreen.main.bounds.width/2 - 12
        switch type {
        case .left:
            x = centerXPosition - 50
        case .center:
            x = centerXPosition
        case .right:
            x = centerXPosition + 50
        }
        barrelView.frame = CGRect(x: x, y: 70, width: 15, height: 20)
        view.insertSubview(barrelView, belowSubview: mountainImageView)
        obstacles.append(barrelView)
        
        
        UIView.animate(withDuration: (3 * self.speed), animations: {
            barrelView.frame.origin.y = UIScreen.main.bounds.height * 1.2
            barrelView.frame.size.width = UIScreen.main.bounds.width * 0.13
            barrelView.frame.size.height = UIScreen.main.bounds.height * 0.08
            
            switch type {
            case .left:
                barrelView.frame.origin.x -= 100
            case .right:
                barrelView.frame.origin.x += 80
            case .center:
                barrelView.frame.origin.x -= 10
            }
        }) { _ in
            barrelView.removeFromSuperview()
            self.obstacles.removeAll { $0 == barrelView }
        }
        
    }
    
    func moveMyStrip () {
        self.createRoadItem()
    }
    
    
    func moveObstacle () {
        let when = DispatchTime.now() + (TimeInterval(exactly: Double.random(in: (0.13 * self.speed)...(1.6 * self.speed)) ) ?? 1.8)
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.createBarrel()
            self.moveObstacle()
            
        }
    }
    
    @objc func swipeRightDetected() {
        self.moveRight()
    }
    
    @objc func swipeLeftDetected() {
        self.moveLeft()
    }
    
    
    func moveRight() {
        self.myCar.transform = CGAffineTransform(rotationAngle: 0.2)
        self.carPosition.constant += UIScreen.main.bounds.width / 3.9
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.playSound()
        }) { (_) in
            self.myCar.transform = CGAffineTransform(rotationAngle: 0.0)
            self.turnSound?.stop()
        }
    }
    
    func highBackButton() {
        let backButton = UIBarButtonItem()
        navigationItem.leftBarButtonItem = backButton
    }
    
    
    func moveLeft() {
        self.myCar.transform = CGAffineTransform(rotationAngle: -0.2)
        self.carPosition.constant -= UIScreen.main.bounds.width / 3.9
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.playSound()
        }) { (_) in
            self.myCar.transform = CGAffineTransform(rotationAngle: 0.0)
            self.turnSound?.stop()
        }
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "1", ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            turnSound = try AVAudioPlayer(contentsOf: url)
            guard let player = turnSound else { return }
            player.volume = 0.2
            player.prepareToPlay()
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSoundEngine() {
        guard let path = Bundle.main.path(forResource: "engine", ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            engineSound = try AVAudioPlayer(contentsOf: url)
            guard let player = engineSound else { return }
            player.volume = 0.6
            player.prepareToPlay()
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSoundBoom() {
        guard let path = Bundle.main.path(forResource: "Boom", ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            boomSound = try AVAudioPlayer(contentsOf: url)
            guard let player = boomSound else { return }
            player.volume = 0.9
            player.prepareToPlay()
            player.play()
         

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

