//
//  MessageController.swift
//  CarMasterNotify
//
//  Created by Admin on 24.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreData
import RxSwift

class MessageController: UIViewController {
    private let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendMessageButton: UIButton!
    var fetchedResultsController: NSFetchedResultsController<Message>!
    var viewModel: MessageViewModel!
    var tableViewDidLoad: Bool = false
    
    var messages: [Message] {
        return self.fetchedResultsController.fetchedObjects!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        setupBindings()
        getFromApi()
    }
    
    func setupBindings() {
        self.viewModel.title
            .bind(to: self.rx.title)
            .disposed(by: self.disposeBag)
        
        self.tableView.rx.setDataSource(self)
            .disposed(by: self.disposeBag)
        
        self.tableView.rx.willDisplayCell
            .subscribe(onNext: {[unowned self] cell, indexPath in
                if indexPath.row == self.tableView.indexPathsForVisibleRows?.last?.row {
                    if !self.tableViewDidLoad {
                        self.tableViewDidLoad = true
                        self.tableView.scrollToBottom()
                    }
                }
            })
            .disposed(by: self.disposeBag)
        
        self.tableView.rx.contentOffset
            .bind(to: self.viewModel.tableContentOffset)
            .disposed(by: self.disposeBag)
        
        sendMessageButton.rx.tap
            .flatMap{_ in return Observable.just(self.messageTextField.text)}
            .ifEmpty(default: "")
            .bind(to: self.viewModel!.sendMessageTapped)
            .disposed(by: disposeBag)
        
    }
    
    func getFromApi() {
        self.viewModel.getMessages(offset: self.messages.count)
    }
}

extension MessageController: NSFetchedResultsControllerDelegate {
    func fetch() {
        let context = CoreDataManager.context
        let request = NSFetchRequest<Message>(entityName: "Message")
        let sort = NSSortDescriptor(key: "created", ascending: true)
        request.sortDescriptors = [sort]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                              managedObjectContext: context!,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        fetchedResultsController!.delegate = self
        
        do {
            try fetchedResultsController!.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let indexPath = newIndexPath else {
                return
            }
            tableView.insertRows(at: [indexPath], with: .fade)
        case .delete:
            guard let indexPath = indexPath else {
                return
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .move:
            guard indexPath != newIndexPath else {
                return
            }
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            guard let indexPath = indexPath else {
                return
            }
            tableView.reloadRows(at: [indexPath], with: .fade)
        @unknown default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        tableView.scrollToBottom()
    }
}

extension MessageController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        self.viewModel.messageCount = sectionInfo.numberOfObjects
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.isMy {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserMessage", for: indexPath) as! UserMessageCell
            cell.messageText.text = message.text
            switch message.status {
            case "error":
                cell.errorImage.isHidden = false
                cell.progressBar.isHidden = true
            case "loading":
                cell.errorImage.isHidden = true
                cell.progressBar.isHidden = false
                cell.progressBar.rotate()
            default:
                cell.errorImage.isHidden = true
                cell.progressBar.isHidden = true
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Message", for: indexPath) as! MessageCell
            cell.messageText.text = message.text
            cell.author.text = message.username
            return cell
        }
    }
    
    
}
