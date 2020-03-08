import UIKit
import Foundation
import WebKit
import Alamofire //Para HTTPs Requests.
import SwiftyJSON //Para interpretar JSONs.
import SQLite3

class PaisDetalleViewController: UIViewController
{
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var habitantesLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var banderaImage: WKWebView!
    
    var selectedCountry : String = ""
    var selectedCountryOffline : String = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if !selectedCountry.isEmpty
        {
            self.getDatosPais()
        }
        else
        {
            self.getDatosPaisOffline()
        }
    }
    
    //Funcion para la obtencion de datos del pais.
    private func getDatosPais()
    {
        //Saneamiento en el caso de paises con caracteres especiales o espacios.
        self.selectedCountry = self.selectedCountry.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        //Request GET API.
        AF.request("https://restcountries.eu/rest/v2/name/"+selectedCountry, method: .get).validate().responseJSON { response in
            switch response.result
            {
                case .success(let value):
                    let json = JSON(value)
                    self.loadLabels(json: json)
                    self.autoSizeLabel()
                    self.loadFlag(flagUrl: json[0]["flag"].stringValue)
                    self.saveCountry(pais: json[0])
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    //Funcion para la obtencion de datos del pais de la BD.
    private func getDatosPaisOffline()
    {
        let datos = Pais.getDatosPaisByPais(nombre: self.selectedCountryOffline)
        print(datos)
        //self.loadLabels(nombre: datos["nombre"]!, region: datos["region"]!, capital: datos["capital"]!, habitantes: datos["habitantes"]!, area: datos["area"]!)
        self.autoSizeLabel()
        
    }
    
    //Funcion para cargar los labels del pais.
    private func loadLabels(json: JSON)
    {
        self.nombreLabel.text = json[0]["name"].stringValue
        self.regionLabel.text = json[0]["region"].stringValue
        self.capitalLabel.text = json[0]["capital"].stringValue
        self.habitantesLabel.text = json[0]["population"].stringValue
        self.areaLabel.text = json[0]["area"].stringValue
    }
    
    //Funcion para cargar los labels del pais.
    private func loadLabels(nombre: String, region: String, capital: String, habitantes: String, area:String)
    {
        self.nombreLabel.text = nombre
        self.regionLabel.text = region
        self.capitalLabel.text = capital
        self.habitantesLabel.text = habitantes
        self.areaLabel.text = area
    }
    
    //Funcion para redimensionar los labels del pais.
    private func autoSizeLabel()
    {
        self.nombreLabel.sizeToFit()
        self.regionLabel.sizeToFit()
        self.capitalLabel.sizeToFit()
        self.habitantesLabel.sizeToFit()
        self.areaLabel.sizeToFit()
    }
    
    //Funcion para cargar el SVG que representa la bandera del pais.
    private func loadFlag(flagUrl: String)
    {
        let urlString = URL(string: flagUrl)!
        let request = URLRequest(url: urlString)
        banderaImage.load(request)
        banderaImage.scrollView.isScrollEnabled = false
        banderaImage.contentMode = .scaleAspectFit
    }
    
    private func saveCountry(pais: JSON)
    {
        //Obtencion de UserDefaults.
        let storage = UserDefaults.standard;
        var paisesVisitados = storage.stringArray(forKey: "paisesVisitados") ?? [String]()
        paisesVisitados.insert(selectedCountry, at: paisesVisitados.count)
        
        //Almacenamiento de UserDefaults.
        storage.set(paisesVisitados, forKey: "paisesVisitados")
        
        self.saveBD(pais: pais)
    }
    
    //Guardar los datos del pais en BD local.
    private func saveBD(pais: JSON)
    {
        let nombre = pais["name"].stringValue
        let region = pais["region"].stringValue
        let capital = pais["capital"].stringValue
        let habitantes = pais["population"].stringValue
        let area = pais["area"].stringValue
        Pais.insertPais(nombre: nombre, region: region, capital: capital, habitantes: habitantes, area: area)
    }
}

