//
//  ViagemViewController.swift
//  Ipiranga
//
//  Created by Maurício Mazzocco on 07/12/18.
//  Copyright © 2018 Totvs. All rights reserved.
//

import UIKit
import CoreLocation

struct LinksHelper {
    static func startNavigation(coordinate: CLLocationCoordinate2D) {
        struct Links {
            static let kGoogleMapsSchema = "comgooglemaps://"
            static let kGoogleMaps = "\(kGoogleMapsSchema)?daddr=%f,%f&directionsmode=driving"
            static let kAppleMaps = "https://maps.apple.com/?saddr=Current Location&daddr=%f,%f&z=10&t=s"
        }

        var path: String!

        if let googleMapsSchemaUrl = URL(string:Links.kGoogleMapsSchema), UIApplication.shared.canOpenURL(googleMapsSchemaUrl) {
            path = Links.kGoogleMaps
        } else {
            path = Links.kAppleMaps
        }
        guard let str = String(format: path, coordinate.latitude, coordinate.longitude).addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed) else {
                return
        }

        guard let url = URL(string: str) else {
            return
        }

        UIApplication.shared.openURL(url)
    }
}

class ViagemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startNavigation(_ sender: Any) {
        LinksHelper.startNavigation(coordinate: CLLocationCoordinate2D(latitude:-25.4284, longitude: -49.2733))

    }
    @IBOutlet weak var iniciarNavegação: UIButton!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
