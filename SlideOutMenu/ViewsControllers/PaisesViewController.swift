import Foundation
import UIKit
import Alamofire //Para HTTPs Requests.
import SwiftyJSON //Para interpretar JSONs.

//Separacion de PaisesViewController.
class PaisesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    //Referencia al PickerView.
    @IBOutlet weak var pickerView: UIPickerView!
    //Array que contiene los elementos del PickerData.
    
    var pickerData: [String] = [String]()
    var selectedCountry : String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.loadPaises()
    }
    
    //Funcion que realiza un GET y carga el pickerData.
    private func loadPaises()
    {
        AF.request("https://restcountries.eu/rest/v2/all", method: .get).validate().responseJSON { response in
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            for jsonElement in json
            {
                let countryName = jsonElement.1["name"]
                print("JSON: \(countryName)")
                self.pickerData.append("\(countryName)")
            }
            self.pickerView.delegate = self
            self.pickerView.dataSource = self
        case .failure(let error):
            print(error)
        }
        }
    }
    
    @IBAction func obtenerInfoPais(_ sender: Any)
    {
        self.selectedCountry = pickerData[pickerView.selectedRow(inComponent: 0)]
        print("Seleccionado: \(selectedCountry)")
        performSegue(withIdentifier: "paisDetalle", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "paisDetalle")
        {
            let viewController = segue.destination as? PaisDetalleViewController
            viewController?.selectedCountry = self.selectedCountry
        }
    }
    
    //Funciones por implementar pickerView.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Funciones por implementar pickerView.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //Funciones por implementar pickerView.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
