//
//  IpirangaInputViewController.swift
//  Ipiranga
//
//  Created by Maurício Mazzocco on 06/12/18.
//  Copyright © 2018 Totvs. All rights reserved.
//

import UIKit
import fluigSDKCore
import RSLoadingView

class IpirangaInputViewController: UIViewController {
    let apiFluig = FluigAPI()
    var item : WorkflowProcessDto!
    var attachments: [AttachmentProcessReturn] = []
    var dadosViewController : DadosViewController!
    var viagemViewController : ViagemViewController!
    var comprovanteViewController : ComprovanteViewController!

    @IBOutlet weak var viagemView: UIView!
    @IBOutlet weak var dadosView: UIView!
    @IBOutlet weak var comprovantesView: UIView!
    @IBOutlet weak var segmentedControll: UISegmentedControl!



    @IBOutlet weak var tableView: UITableView!
    let loadingView = RSLoadingView()
    override func viewDidLoad() {
        super.viewDidLoad()
        dadosView.alpha = 1
        comprovantesView.alpha = 0
        viagemView.alpha = 0
        print(item.processInstanceId)
            NotificationCenter.default.addObserver(self, selector: #selector(self.finishLoading(notification:)), name: Notification.Name("finishLoading"), object: nil)
         navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(addTapped))


        // Do any additional setup after loading the view.
    }

@objc func finishLoading(notification: Notification) {
    loadingView.hide()
        NotificationCenter.default.post(name: Notification.Name("reloadMinhasViagens"), object: nil)
     self.navigationController?.popViewController(animated: true)


    }

    @objc func addTapped(){
         let alertController = UIAlertController(title: "Ações", message: "", preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "Registrar Abastecimento", style: .default, handler: { (_) in

            self.loadingView.showOnKeyWindow()
            self.apiFluig.vsendProcess(movimentSequence:self.item.movementSequence.description,processInstanceId: self.item!.processInstanceId.description, choosedState: "9" , attachments: self.attachments, tipoCombustivel: self.dadosViewController.getTipoCombustivel(),quantidadeLitros: self.dadosViewController.getQtdLitros() , valorTotal: self.dadosViewController.getValorTotalTxt(),kmAtual:self.dadosViewController.getKmAtualTxt(), posto: self.dadosViewController.getPosto() )

        }))

        alertController.addAction(UIAlertAction(title: "Adicionar Comprovantes", style: .default, handler: { (_) in
            self.showCamera()
        }))


        alertController.addAction(UIAlertAction(title: "Finalizar Viagem", style: .destructive, handler: { (_) in
            self.apiFluig.vsendProcess(movimentSequence:self.item.movementSequence.description,processInstanceId: self.item!.processInstanceId.description, choosedState: "26" , attachments: self.attachments, tipoCombustivel: self.dadosViewController.getTipoCombustivel(),quantidadeLitros: self.dadosViewController.getQtdLitros() , valorTotal: self.dadosViewController.getValorTotalTxt(),kmAtual:self.dadosViewController.getKmAtualTxt(), posto: self.dadosViewController.getPosto() )
        }))


        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (_) in

        }))

         self.present(alertController, animated: true, completion: nil)

    }
   

    @IBAction func indexChanged(sender: UISegmentedControl) {
        self.view.endEditing(true)
        switch segmentedControll.selectedSegmentIndex
        {
        case 0:
            dadosView.alpha = 1
            comprovantesView.alpha = 0
            viagemView.alpha = 0
        //show popular view
        case 1:

            dadosView.alpha = 0
            comprovantesView.alpha = 0
            viagemView.alpha = 1
        //show history view
        case 2:

            dadosView.alpha = 0
            comprovantesView.alpha = 1
            viagemView.alpha = 0
        //show history view
        default:
            break;
        }
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
    let scale = newWidth / image.size.width
    let newHeight = image.size.height * scale
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage! }

   func showCamera(){
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            print("Got image!!!!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                // your code here

                let alertController = UIAlertController(title: "Title", message: "", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
                    let textField = alertController.textFields![0] as UITextField
                    let imageRecize = self.resizeImage(image: image, newWidth: 300)
                    let imageData = imageRecize.jpegData(compressionQuality: 0.5)

                    let attachmentProcessReturn = AttachmentProcessReturn()
                    attachmentProcessReturn.image = imageRecize
                    attachmentProcessReturn.archive = imageData
                    attachmentProcessReturn.documentType = "7"
                    attachmentProcessReturn.fileName = textField.text! + ".png"
                    attachmentProcessReturn.descriptionStr = textField.text! + ".png"
                    attachmentProcessReturn.deleted = false
                    attachmentProcessReturn.newAttach = true
                    attachmentProcessReturn.permission = "PREDMO"
                    let attachment = Attachment()
                    attachment.fileName = textField.text! + ".png"

                    let array = NSMutableArray()
                    array.add(attachment)
                    attachmentProcessReturn.attachments = array
                    self.attachments.append(attachmentProcessReturn)
                    self.comprovanteViewController.attachments = self.attachments
                  NotificationCenter.default.post(name: Notification.Name("reloadTableComprovantes"), object: nil)
                }))

                alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                    textField.placeholder = "Insira o nome do anexo"
                })

                  self.present(alertController, animated: true, completion: nil)

            }

        }
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "dados"){
             dadosViewController  = segue.destination as! DadosViewController

        }else if(segue.identifier == "viagem"){
            viagemViewController = segue.destination as! ViagemViewController

        }else if(segue.identifier == "comprovante"){
            comprovanteViewController = segue.destination as! ComprovanteViewController
            comprovanteViewController.attachments = attachments
        }


    }


    
}
extension IpirangaInputViewController: UITableViewDelegate, UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {

        return 1

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       return 3
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        if let cell = tableView.dequeueReusableCell(
            withIdentifier: "TaskTableViewCell",
            for: indexPath) as? TaskTableViewCell{
            cell.lblTxt.text = item.processId + " " + item.processInstanceId.description
            return cell

        }

        return UITableViewCell()
    }



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


}
}
