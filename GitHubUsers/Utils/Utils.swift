//
//  Utils.swift
//  GitHubUsers
//
//  Created by Vikram on 18/02/22.
//

import Foundation
import UIKit

extension UIImageView {
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "default.png")
            return
        }
        DispatchQueue.global().async { [weak self] in
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage(named: "default.png")
            }
        }
    }
}

func showNetworkAlert(viewController: UIViewController) {
    let alert = UIAlertController(title: Constants.ALERT_TITLE, message: Constants.NO_NETWORK_ALERT, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: Constants.ALERT_BUTTON_TTILE_OK, style: UIAlertAction.Style.default, handler: nil))
    viewController.present(alert, animated: true, completion: nil)
}
