//
//  ViewController.swift
//  ProgressGif
//
//  Created by Zheng on 7/10/20.
//

import UIKit
import Photos
import RealmSwift

class ViewController: UIViewController {
    
    let realm = try! Realm()
    var projects: Results<Project>?
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView! /// the top bar
    
    // MARK: - Collection View
    
    private lazy var collectionViewController: CollectionViewController? = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "CollectionViewController") as? CollectionViewController {
            
            
            viewController.inset = CGFloat(4)
            viewController.topInset = visualEffectView.frame.height
            viewController.projects = self.projects
            viewController.collectionType = .projects
            self.add(childViewController: viewController, inView: view)
            
            return viewController
        } else {
            return nil
        }
        
    }()
    
    // MARK: - Add button
    
    var addButtonIsPressed = false
    @IBOutlet weak var addButton: CustomButton!
    @IBAction func addButtonTouchDown(_ sender: Any) {
        handleAddButtonTouchDown()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        handleAddButtonPress()
    }
    
    @IBAction func addButtonTouchUpOutside(_ sender: Any) {
        handleAddButtonTouchUpOutside()
    }

    // MARK: - Import options
    
    @IBOutlet weak var importVideoLabel: UILabel!
    @IBOutlet weak var importVideoBottomC: NSLayoutConstraint! /// 26
    let importVideoBottomCShownConstant = CGFloat(32)
    let importVideoBottomCHiddenConstant = CGFloat(26)
    
    @IBOutlet weak var filesButton: CustomButton!
    @IBOutlet weak var photosButton: CustomButton!
    @IBOutlet weak var clipboardButton: CustomButton!
    
    @IBAction func filesTouchDown(_ sender: Any) {
        filesButton.scaleDown()
    }
    
    @IBAction func filesPressed(_ sender: Any) {
        filesButton.scaleUp()
        presentImportController()
        handleAddButtonPress()
    }
    
    @IBAction func filesTouchUpOutside(_ sender: Any) {
        filesButton.scaleUp()
    }
    
    
    @IBAction func photosTouchDown(_ sender: Any) {
        photosButton.scaleDown()
    }
    
    @IBAction func photosPressed(_ sender: Any) {
        photosButton.scaleUp()
        importVideo()
        handleAddButtonPress()
    }
    
    @IBAction func photosTouchUpOutside(_ sender: Any) {
        photosButton.scaleUp()
    }
    
    @IBAction func clipboardTouchDown(_ sender: Any) {
        clipboardButton.scaleDown()
    }
    @IBAction func clipboardPressed(_ sender: Any) {
        clipboardButton.scaleUp()
        handleAddButtonPress()
    }
    @IBAction func clipboardTouchUpOutside(_ sender: Any) {
        clipboardButton.scaleUp()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// make the import from files, import from photos, and import from clipboard buttons transparent
        setUpButtonAlpha()
        
        /// load from realm
        projects = realm.objects(Project.self)
        
        if let projs = projects {
            projects = projs.sorted(byKeyPath: "dateCreated", ascending: false)
        }
        
//        for _ in 0...5 {
//            let project = EditableProject()
//            project.title = "Title"
//            projects.append(project)
//        }
        
        /// initialize the collection view
        _ = collectionViewController
        
    }


}






