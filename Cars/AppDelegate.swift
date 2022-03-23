import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        
//        UserDefaults.standard.set([], forKey: "scoresArray")
       
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension UIViewController {
    
    func setNavBarTransparent() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func setBackButton() {
        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(onBack))
        barButton.title = " "
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func onBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UIView {
    
    func overlaps(otherView: UIView, in superView: UIView) -> Bool {
        guard let frame1 = self.layer.presentation()?.frame, let frame2 = otherView.layer.presentation()?.frame else { return false }
        return frame1.intersects(frame2)
    }

    func setShadow() {
        self.layer.shadowColor = UIColor.systemGray4.cgColor
        self.layer.shadowOpacity = 2
        self.layer.shadowOffset = CGSize(width: -1, height: 0)
//        self.layer.shadowRadius = 5
//        self.layer.cornerRadius = 20
        self.layer.shouldRasterize = true
    }
    
    func setShadowTwo() {
            self.layer.shadowColor = UIColor.systemGray.cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize(width: -3, height: 0)
    //        self.layer.shadowRadius = 5
    //        self.layer.cornerRadius = 20
            self.layer.shouldRasterize = true
    }
   func setShadowThree() {
           self.layer.shadowColor = UIColor.black.cgColor
           self.layer.shadowOpacity = 1
           self.layer.shadowOffset = CGSize(width: 0, height: -1)
           self.layer.shouldRasterize = true
   }
       
    
}
