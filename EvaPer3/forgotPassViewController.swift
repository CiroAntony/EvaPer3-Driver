import UIKit
import FirebaseAuth

class forgotPassViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
    super.viewDidLoad()
         emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.cornerRadius = 13.0
        
        recuperarButton.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        recuperarButton.layer.cornerRadius = 25.0
        recuperarButton.tintColor = UIColor.black
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
