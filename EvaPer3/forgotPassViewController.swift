import UIKit
import FirebaseAuth

class forgotPassViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    }
    
    @IBAction func forgotPassButton_Tapped(_ sender: UIButton) {
        
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { (error) in
            if error == nil
            {
                let alertController = UIAlertController(title: "Enviado", message: "Se ha enviado un link a su correo para recuperar la contraseña", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion: nil)
                return
            }else {
                let alertController = UIAlertController(title: "Error", message: "Cuenta/Correo inexistente", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
        }
    }
    
}
