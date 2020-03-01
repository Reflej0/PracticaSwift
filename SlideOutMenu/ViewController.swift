import UIKit

class ViewController: UIViewController
{

    @IBOutlet var trailingCon: NSLayoutConstraint!
    @IBOutlet var leadingCon: NSLayoutConstraint!
    
    var menuVisible = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
    
}

