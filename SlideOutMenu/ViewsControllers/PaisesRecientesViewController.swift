import UIKit
import Foundation
import WebKit
import Alamofire //Para HTTPs Requests.
import SwiftyJSON //Para interpretar JSONs.

class PaisesRecientesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerData: [String] = [String]()
    var selectedCountry : String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.loadPickerView()
    }
    
    private func loadPickerView()
    {
        let storage = UserDefaults.standard;
        let paisesVisitados = storage.stringArray(forKey: "paisesVisitados") ?? [String]()
        for paisVisitado in paisesVisitados
        {
            self.pickerData.append(paisVisitado)
        }
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    @IBAction func obtenerInfoPais(_ sender: Any)
    {
        self.selectedCountry = pickerData[pickerView.selectedRow(inComponent: 0)]
            print("Seleccionado: \(selectedCountry)")
            performSegue(withIdentifier: "paisDetalleOffline", sender: self)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "paisDetalleOffline")
        {
            let viewController = segue.destination as? PaisesRecientesViewController
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

