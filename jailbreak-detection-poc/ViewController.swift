
// compatible with Swift 4.x and above.

import UIKit
import Foundation

public func isJailbroken() -> Bool {
    var jailbreakDetected = false
    // you can check for tons of stuff but these are usually the easiest ones without actually "touching" anything.
    if FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
        || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
        || FileManager.default.fileExists(atPath: "/Applications/Zebra.app")
        || FileManager.default.fileExists(atPath: "/Applications/Sileo.app")
        || FileManager.default.fileExists(atPath: "/bin/bash")
        || FileManager.default.fileExists(atPath: "/bin/zsh")
        || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
        || FileManager.default.fileExists(atPath: "/etc/apt")
        || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
        || UIApplication.shared.canOpenURL(URL(string:"cydia://package/com.example.package")!) {

            jailbreakDetected =  true
        }
    return jailbreakDetected
}

// Only called if device is jailbroken obviously.
public func sandBoxViolation(jailbreak: Bool) -> Bool {
    var successful = false
    if (jailbreak){
        let stringToWrite = "This a test."
        do {
                try stringToWrite.write(toFile:"/private/jailbreak.txt", atomically:true, encoding:String.Encoding.utf8)
                successful =  true
            
                
                
            } catch {
                successful =  false
            }
    }
    return successful
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var jailbrekLol:Bool
        if (isJailbroken()){
            jailbrekLol = true
            jailbreakLabel.text = "Jailbroken"
            if (sandBoxViolation(jailbreak: true)){
                let alert = UIAlertController(title: "Sandbox violated!", message: "A text file has been added to /private/jailbreak.txt", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

                self.present(alert, animated: true)
            }
            else{
                
            }
        }
        else {
            jailbrekLol = false
            jailbreakLabel.text = "Couldn't detect jailbreak."
        }
    }
    
    
    @IBOutlet weak var jailbreakLabel: UILabel!
    

}

