//
//  ViewController.swift
//  choiceTecnicoMobileDev
//
//  Created by Nelida Valencia on 18/07/21.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var txf_sub: UITextField!
    let bussines = BusinessController()
    var alert: UIAlertView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func goStoryboard(typeText: String, tokenText: String) {
        let storyboard = UIStoryboard(name: "Carousel", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CarouselViewController") as! CarouselViewController
        vc.type = typeText
        vc.token = tokenText
        vc.definesPresentationContext = true
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }

    func login(subData: String) {
        self.bussines.executeLogin(sub: subData) { (result, token, type) in
            if result{
                print("TOKEN LOGIN", token)
                self.goStoryboard(typeText: type ?? "", tokenText: token ?? "")
            }else{
                let alert = UIAlertController(title: "ERROR", message: "Intentar nuevamente.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ACEPTAR", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func btn_login(_ sender: Any) {
        let sub = txf_sub.text ?? ""
        if sub.isEmpty {
            let alert = UIAlertController(title: "ERROR", message: "Por favor ingresar Sub.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ACEPTAR", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            login(subData: sub)
        }
    }
}

