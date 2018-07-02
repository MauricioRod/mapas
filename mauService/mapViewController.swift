//
//  mapViewController.swift
//  mauService
//
//  Created by Mauricio Rodriguez on 7/1/18.
//  Copyright © 2018 Rodolfo Benjamin Alcantara Solorio. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapViewController: UIViewController, CLLocationManagerDelegate {
    var lati: Double?
    var long: Double?
    var nombre: String?
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = nombre
       
        let mark: CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.lati!, self.long!)
        let span: MKCoordinateSpan = MKCoordinateSpanMake (0.05, 0.05)
        let region : MKCoordinateRegion = MKCoordinateRegionMake(mark, span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
        let anotation = MKPointAnnotation()
        anotation.coordinate = mark
        anotation.title = self.nombre
        map.addAnnotation(anotation)
        
        
        print(lati ?? 0.0)
        print(long ?? 0.0)
        print(nombre ?? "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
