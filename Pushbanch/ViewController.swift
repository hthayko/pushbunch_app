//
//  ViewController.swift
//  Pushbanch
//
//  Created by David Grigoryan on 11/15/16.
//  Copyright © 2016 Yantech. All rights reserved.
//

import UIKit
import OneSignal
import Alamofire
class ViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        OneSignal.idsAvailable({ (userId, pushToken) in
            print("UserId: ", userId)

            if let userId = userId {
                var request = Alamofire.request("http://push-bunch-server.herokuapp.com/register_key",
                                  method: .post,
                                  parameters: ["user_id": userId], encoding: JSONEncoding.default
                    ).responseJSON { response in
                        let alert = UIAlertController(title: "Done", message: "Please kill the app", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.stopAnimation()
                }
                    

            }
            if (pushToken != nil) {
                print("pushToken: ", pushToken)
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        animateLogo()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func animateLogo() {
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = NSNumber(value: 2 * M_PI)
        rotate.toValue = NSNumber(value: 0)
        rotate.duration = 2.0;
        rotate.repeatCount = 1000;
        logo.layer.add(rotate, forKey: "rotate")
    }
    func stopAnimation() {
        logo.layer.removeAllAnimations()
    }

}

