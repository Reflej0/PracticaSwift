import Foundation
import SQLite3
class Pais
{
 
    var id: Int
    var nombre: String?
    var region: String?
    var capital: String?
    var habitantes: Int
    var area: Int
 
    init(id: Int, nombre: String?, region: String?, capital: String?, habitantes: Int, area: Int){
        self.id = id
        self.nombre = nombre
        self.region = region
        self.capital = capital
        self.habitantes = habitantes
        self.area = area
    }
    
    public static func getDatosPaisByPais(nombre: String) -> Dictionary<String, String>
    {
        var stmt:OpaquePointer?
        
        let queryString = "SELECT * FROM Pais ORDER BY ID DESC LIMIT 1 "
        
        //Obtencion de DB referenciada en ViewController.
        let db = ViewController.db
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW)
        {
            let id = sqlite3_column_int(stmt, 0)
            let nombre = String(cString: sqlite3_column_text(stmt, 1))
            let region = String(cString: sqlite3_column_text(stmt, 2))
            let capital = String(cString: sqlite3_column_text(stmt, 3))
            let habitantes = sqlite3_column_int(stmt, 4)
            let area = sqlite3_column_int(stmt, 5)
            return ["nombre": nombre, "region": region, "capital": capital, "habitantes": String(habitantes), "area": String(area)]
        }
        return [:]
    }
    
    public static func insertPais(nombre: String, region: String, capital: String, habitantes: String, area: String)
    {
        //Cursor
        var stmt: OpaquePointer?
        
        //Consulta plana en SQL.
        let queryString = "INSERT INTO Pais (nombre, region, capital, habitantes, area) VALUES (?,?, ?, ?, ?)"
        
        //Obtencion de DB referenciada en ViewController.
        let db = ViewController.db
        
        //Preparacion de consulta.
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, nombre, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, region, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, capital, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_int(stmt, 4, (habitantes as NSString).intValue) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_int(stmt, 5, (area as NSString).intValue) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        //Ejecucion de consulta.
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting hero: \(errmsg)")
            return
        }
    }
}
