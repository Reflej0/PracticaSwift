import UIKit
import SQLite3

class ViewController: UIViewController
{

    @IBOutlet var trailingCon: NSLayoutConstraint!
    @IBOutlet var leadingCon: NSLayoutConstraint!
    
    var menuVisible = false
    var fileURL : URL? = nil
    static var db: OpaquePointer?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.createFileDatabase()
        self.openDatabase()
        self.createTablePaises()
        //Eliminacion del UserDefaults.standard
        /*let storage = UserDefaults.standard;
        storage.removeObject(forKey: "paisesVisitados")*/
    }
    
    @IBAction func PaisesButton(_ sender: Any)
    {

    }

    @IBAction func menuTapped(_ sender: Any)
    {
        
        if !menuVisible
        {
            leadingCon.constant = 150
            trailingCon.constant = -150
            menuVisible = true
        }
        else
        {
            leadingCon.constant = 0
            trailingCon.constant = 0
            menuVisible = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            //print("The animation is complete!")
        }
        
    }
    
    //Inicacion de la base de datos.
    private func createFileDatabase()
    {
        self.fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent("PaisDatabase.sqlite")
    }
    
    //Inicacion de la base de datos.
    private func openDatabase()
    {
        if sqlite3_open(self.fileURL!.path, &ViewController.db) != SQLITE_OK {
            print("error opening database")
        }
    }
    
    //Inicacion de la base de datos.
    private func createTablePaises()
    {
        if sqlite3_exec(ViewController.db, "CREATE TABLE IF NOT EXISTS Pais (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, region TEXT, capital TEXT, habitantes INTEGER, area INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(ViewController.db)!)
            print("error creating table: \(errmsg)")
        }
    }
}

