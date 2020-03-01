import UIKit
import Foundation
import Alamofire //Para HTTPs Requests.
import SwiftyJSON //Para interpretar JSONs.

class PaisDetalleViewController: UIViewController
{
    var selectedCountry : String = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("Cargue desde otra vista con \(self.selectedCountry)")
        self.getDatosPais()
    }
    
    private func getDatosPais()
    {
        AF.request("https://restcountries.eu/rest/v2/name/"+selectedCountry, method: .get).validate().responseJSON { response in
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            print(json)
        case .failure(let error):
            print(error)
        }
        }
    }
}

