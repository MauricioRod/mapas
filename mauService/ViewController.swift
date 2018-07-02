import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableViewLugares: UITableView!
    var numeroResultados = 1
    var auxLugares: [Result]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if auxLugares != nil {
            return (auxLugares?.count)!
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(200)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaDatos", for: indexPath) as! PlacesTableViewCell
        
        let latitudeString = String(format: "%f", (auxLugares?[indexPath.row].geometry.location.lat)!)
        let longitudeString = String(format: "%f", (auxLugares?[indexPath.row].geometry.location.lng)!)
        
        cell.nombreLabel.text = auxLugares?[indexPath.row].name
        cell.latLabel.text = latitudeString
        cell.longLabel.text = longitudeString

       
    
        
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        //Llamada de función de Alamofire
        
        /**
        Para este caso el servicio no necesita parametros ni headers, por lo que estos campos los dejaremos con [:]
         */
        Alamofire.request("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=19.4381507,-99.19374449999998&radius=50000&type=restaurant&keyword=cruise&key=AIzaSyCoYdnpjFDNy8IhPKQ9X4FNMydD_0ALPh4", method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:]).responseJSON {
            response in
            
            if response.data != nil {
                    let lugares = try? JSONDecoder().decode(Mapas.self, from: response.data!)
                    if lugares != nil {
                        self.auxLugares = (lugares?.results)!
                        
                        // Set de los campos
                        
                        /*for item in self.auxLugares! {
                            let mark: CLLocationCoordinate2D = CLLocationCoordinate2DMake(item.geometry.location.lat, item.geometry.location.lng)
                            let annotation = MKPointAnnotation ()
                            annotation.coordinate = mark
                            annotation.title = variableConLosObjetos.name
                            mapView.addAnnotation(annotation)*/
                        }
                        
                        self.tableViewLugares.reloadData()
                    } else {
                        print("No response")
                    }
            }
            print("Finish")
        }
    
    func irMapas(latRecibida: Double, longRecibida: Double, nombreRecibido: String) {
        let mapViewController =  self.storyboard?.instantiateViewController(withIdentifier: "mapViewController") as! mapViewController
        mapViewController.lati = latRecibida
        mapViewController.long = longRecibida
        mapViewController.nombre = nombreRecibido
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print((auxLugares?[indexPath.row].name)!)
        let latitudAux = auxLugares?[indexPath.row].geometry.location.lat ?? 0.0
        let longAux = auxLugares?[indexPath.row].geometry.location.lng ?? 0.0
        let nomAux = auxLugares?[indexPath.row].name ?? ""
        
        irMapas(latRecibida: latitudAux, longRecibida: longAux, nombreRecibido: nomAux)
    }
    
    
}
