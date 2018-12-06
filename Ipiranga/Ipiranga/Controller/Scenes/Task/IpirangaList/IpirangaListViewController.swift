//
//  IpirangaListViewController.swift
//  Ipiranga
//
//  Created by Maurício Mazzocco on 06/12/18.
//  Copyright © 2018 Totvs. All rights reserved.
//

import UIKit
import fluigSDKCore

class IpirangaListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let api =  FluigAPI()
    var taskItems: [ProcessTaskResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        // Do any additional setup after loading the view.
    }

    func loadItems(){
        api.getAllItems(page: 0) { (itemResponse, itemError) in

            guard let item = itemResponse, let items = itemResponse?.items else { return } // add e\\

            self.taskItems  = items
            self.tableView.reloadData()

        }


    }

}

extension IpirangaListViewController: UITableViewDelegate, UITableViewDataSource {


    func configureTableViewOnLoad() {

//        tableView.register(UINib(nibName: App.CellID.task,
//                                 bundle: Bundle.main),
//                           forCellReuseIdentifier: App.CellID.task)
//
//        tableView.backgroundColor = .tableBackgroundColor
//        tableView.estimatedRowHeight = 320 // prototype cell height
//        tableView.rowHeight = UITableViewAutomaticDimension
//
//        delayedTableView.register(UINib(nibName: App.CellID.task,
//                                        bundle: Bundle.main),
//                                  forCellReuseIdentifier: App.CellID.task)
//
//        delayedTableView.backgroundColor = .tableBackgroundColor
//        delayedTableView.estimatedRowHeight = 320 // prototype cell height
//        delayedTableView.rowHeight = UITableViewAutomaticDimension


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

        /*

        if tableView == self.tableView {
            let item = taskItems[indexPath.row]

            if let cell = tableView.dequeueReusableCell(
                withIdentifier: App.CellID.task,
                for: indexPath) as? TaskItemCell{

                cell.item = item
                cell.delegate = self

                if !isLoadingTasks {
                    checkForNextPageToLoad(in: indexPath.row, with: taskItems.count, with: .task)
                }

                return cell
            }
        } else if tableView == self.delayedTableView {

            let item = delayedTaskItems[indexPath.row]
            if let cell = delayedTableView.dequeueReusableCell(
                withIdentifier: App.CellID.task,
                for: indexPath) as? TaskItemCell {
                cell.item = item
                cell.delegate = self
                if !isLoadingDelayedTasks {
                    checkForNextPageToLoad(in: indexPath.row, with: delayedTaskItems.count, with: .delayedTask)
                }

                return cell

            }
        }
 */

        return UITableViewCell()
    }




    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var item : ItemList.FetchTaskItems.ViewModel.Item?
//        if tableView == self.tableView {
//            item = taskItems[indexPath.row]
//        }else if tableView == self.delayedTableView {
//            item = delayedTaskItems[indexPath.row]
//        }
//        self.selectedItem = item
//        //Ver isso depois
//        if(UserDefaultsManager.getCurrentTaskStatus(processInstanceID: (item?.processInstanceId)!, movimentSequence: (item?.movementSequence)!) == TaskStatusType.completed){
//            return
//        }
//        self.performSegue(withIdentifier: "TaskItemDetailSegue", sender: self)

    }

}


