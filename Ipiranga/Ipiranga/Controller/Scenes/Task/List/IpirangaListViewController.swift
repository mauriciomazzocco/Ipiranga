//
//  IpirangaListViewController.swift
//  Ipiranga
//
//  Created by Maurício Mazzocco on 06/12/18.
//  Copyright © 2018 Totvs. All rights reserved.
//

import UIKit
import fluigSDKCore
import RSLoadingView
class IpirangaListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let api =  FluigAPI()
    var taskItems: [WorkflowProcessDto] = []
    var selectedItem : WorkflowProcessDto!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        configureTableViewOnLoad()
        self.title = "Minhas Viagens"

         NotificationCenter.default.addObserver(self, selector: #selector(self.finishLoading(notification:)), name: Notification.Name("reloadMinhasViagens"), object: nil)

    }

    @objc func finishLoading(notification: Notification) {
        self.loadItems()
    }

    func loadItems(){
        let loadingView = RSLoadingView()
        loadingView.showOnKeyWindow()
        api.getAllItemsFromServer { items in
            self.taskItems  = items!
            DispatchQueue.main.async {
                  self.tableView.reloadData()
                loadingView.hide()
            }
                //                self.tableView.reloadData()
        }
//        api.getAllItems(page: 0) { (itemResponse, itemError) in
//            guard let item = itemResponse, let items = itemResponse?.items else { return } // add e\\
//
//            self.taskItems  = items
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    }

}

extension IpirangaListViewController: UITableViewDelegate, UITableViewDataSource {


    func configureTableViewOnLoad() {

        tableView.register(UINib(nibName: "TaskTableViewCell",
                                 bundle: Bundle.main),
                           forCellReuseIdentifier: "TaskTableViewCell")
        tableView.backgroundColor = .tableBackgroundColor
        tableView.estimatedRowHeight = 320 // prototype cell height
        tableView.rowHeight = UITableView.automaticDimension

    }


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

        return taskItems.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = taskItems[indexPath.row]

        if let cell = tableView.dequeueReusableCell(
            withIdentifier: "TaskTableViewCell",
            for: indexPath) as? TaskTableViewCell{
            cell.lblTxt.text = item.processId + " " + item.processInstanceId.description
            return cell

        }

        return UITableViewCell()
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "taskItem"){
            let destVC : IpirangaInputViewController = segue.destination as! IpirangaInputViewController
            destVC.item = selectedItem
            destVC.hidesBottomBarWhenPushed = true
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = taskItems[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "taskItem", sender: self)

    }

}


