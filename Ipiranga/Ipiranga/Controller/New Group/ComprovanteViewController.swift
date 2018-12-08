//
//  ComprovanteViewController.swift
//  Ipiranga
//
//  Created by Maurício Mazzocco on 07/12/18.
//  Copyright © 2018 Totvs. All rights reserved.
//

import UIKit
import TKImageShowing

class ComprovanteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var attachments: [AttachmentProcessReturn] = []
    let tkImageVC = TKImageShowing()
    var imageView: [UIImageView] = []

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewOnLoad()
       NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("reloadTableComprovantes"), object: nil)
        // Do any additional setup after loading the view.
    }

    @objc func methodOfReceivedNotification(notification: Notification) {
        self.tableView.reloadData()
    }


}

extension ComprovanteViewController: UITableViewDelegate, UITableViewDataSource {

    func configureTableViewOnLoad() {

        tableView.register(UINib(nibName: "AttachmentTableViewCell",
                                 bundle: Bundle.main),
                           forCellReuseIdentifier: "AttachmentTableViewCell")



    }

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 100
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return attachments.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = attachments[indexPath.row]
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: "AttachmentTableViewCell",
            for: indexPath) as? AttachmentTableViewCell{
            cell.attachmentTitle.text =  item.fileName!
            cell.imageAtt.image = item.image!
            imageView.append(cell.imageAtt)

            return cell

        }

        return UITableViewCell()
    }



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let item = attachments[indexPath.row]

        tkImageVC.images = [TKImageSource(url: nil, image: item.image!)]
        tkImageVC.animatedView = imageView[indexPath.row]
         self.present(self.tkImageVC, animated: true, completion: nil)
    }


}
