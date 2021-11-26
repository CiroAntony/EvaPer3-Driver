import UIKit
import FirebaseAnalytics
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmTextField: UITextField!
    
    @IBOutlet weak var tipoTextField: UITextField!
    var selectedTipo: String?
    var listOfTipos = ["Cliente","Conductor"]
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.crearSelector()
        self.cerrarSelector()
        
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    func crearSelector(){
        let pickerview = UIPickerView()
        pickerview.delegate = self
        pickerview.dataSource = self
        self.tipoTextField.inputView = pickerview
    }
    
    func cerrarSelector(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Seleccionar", style: .plain, target: self, action: #selector(self.dismissAction))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        self.tipoTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func dismissAction(){
        self.view.endEditing(true)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        if let nombres = nameTextField.text {
            if let correo = emailTextField.text {
                if let contraseña = passwordTextField.text {
                    if let confirmarContraseña = confirmTextField.text {
                        if let tipoUsuario = tipoTextField.text {
                            
                            if (contraseña != confirmarContraseña) {
                                let passAlert = UIAlertController(title: "Aceptar", message: "Error al igualar contraseñas", preferredStyle: .alert)
                                passAlert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                                self.present(passAlert, animated: true, completion: nil)
                                return
                            }
                            
                            Auth.auth().createUser(withEmail: correo, password: contraseña) { authResult, error in guard let user = authResult?.user, error == nil else {
                                let alertController = UIAlertController(title: "Error", message: "Se ha producido un error al registrar al usuario", preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                                self.present(alertController, animated: true, completion: nil)
                                return
                            }
                                let alertController = UIAlertController(title: "Registro exitoso", message: "Se ha registrado al usuario correctamente", preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                                self.present(alertController, animated: true, completion: nil)
                                return
                            }
                        }
                    }
                }
            }
        }
    }
    
}

extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.listOfTipos.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.listOfTipos[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedTipo = self.listOfTipos[row]
        self.tipoTextField.text = self.selectedTipo
    }
    
}
