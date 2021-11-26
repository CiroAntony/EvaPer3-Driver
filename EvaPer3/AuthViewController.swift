import UIKit
import FirebaseAnalytics
import FirebaseAuth
import FirebaseFirestore

class AuthViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var ingresarButton: UIButton!
    
    @IBOutlet weak var registrarButton: UIButton!
    
    @IBOutlet weak var recuperarButton: UIButton!
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Login"
        
        Analytics.logEvent("InitScreen", parameters: ["message": "Integracon de Firebase completa"])
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    @IBAction func ingresarButtonAction(_ sender: Any) {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                    if let _ =  authResult {
                        let alertController = UIAlertController(title: "Inicio de sesión exitoso", message: "Has iniciado sesión correctamente", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                        self?.present(alertController, animated: true, completion: nil)
                        return
                    } else {
                        let alertController = UIAlertController(title: "Error", message: "Credenciales no existentes", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                        self?.present(alertController, animated: true, completion: nil)
                        return}
                }
            }
        }
    }
    
    @IBAction func registrarButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func forgotPassButton_Tapped(_ sender: Any) {
    }
    
}

