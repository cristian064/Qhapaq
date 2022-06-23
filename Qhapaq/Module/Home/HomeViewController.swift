//
//  ViewController.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 13/07/21.
//

import UIKit
import MapKit
import GenericUtilities
import Combine

class HomeViewController: UIViewController {

    var locationProvider: LocationProvider?
    let mapView = MapView()
    let currentLocationButton = UIButton()
    let startAdventureButton = UIButton()
    let saveAdventure = UIButton()
    let viewModel: HomeViewModelProtocol = HomeViewModel()
    let distanceAdventureLabel = UILabel()
    lazy var containerOptionStackView = UIStackView(arrangedSubviews: [startAdventureButton,
                                                                       saveAdventure,
                                                                       currentLocationButton,
                                                                       textView])
    let textView = UITextView()
    private var cancellables = Set<AnyCancellable>()
    var isFirstLoaded = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        setupView()
        setupNavigationController()
        setupBinding()
        viewModel.viewDidLoad()
//        viewModel.getArtWork()
//        viewModel.getLocation()
//        viewModel.stopLocationUpdate()
//        if let path = Bundle.main.path(forResource: "Info",
//                                       ofType: "plist") {
//            let dictionary = NSDictionary(contentsOf: URL(fileURLWithPath: path))
//            print(dictionary?["SERVER_URL"])
//        }
            
    }
    
    func setupBinding() {
        viewModel.locationSubject.sink {[weak self] location in
            self?.mapView.location = location
        }.store(in: &cancellables)
        
        viewModel.distanceOfAdventureSubject.sink {[weak self] distance in
            self?.distanceAdventureLabel.text = "\(String(format: "%.3f", distance/1000)) Km"
        }.store(in: &cancellables)
        
        viewModel.locationsSubject.sink {[weak self] locations in
            self?.mapView.addOverlay(with: locations)
        }.store(in: &cancellables)
        
        viewModel.titleAdventureSubject.sink {[weak self] titleAdventure in
            self?.startAdventureButton.setTitle(titleAdventure, for: .normal)
        }.store(in: &cancellables)
        
        viewModel.statusAdventureSubject.sink {[weak self] statusOfAdventure in
            if let isFirstLoaded = self?.isFirstLoaded, isFirstLoaded {
                self?.isFirstLoaded = false
                return
            }
            self?.saveAdventure.isHidden = statusOfAdventure
            
            self?.mapView.currentLocation(isShowed: statusOfAdventure)
        }.store(in: &cancellables)
    }
    
    func setupNavigationController() {
        self.navigationItem.title = "Home"
    }
    
    func setupView() {
        self.view.addSubview(mapView)
        self.view.addSubview(containerOptionStackView)
        self.view.addSubview(distanceAdventureLabel)
        mapView.anchor(top: self.view.topAnchor,
                       leading: self.view.leadingAnchor,
                       bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                       trailing: self.view.trailingAnchor)
        
        distanceAdventureLabel.anchor(top: self.view.topAnchor,
                                      leading: self.view.leadingAnchor,
                                      bottom: nil,
                                      trailing: self.view.trailingAnchor)
        
        distanceAdventureLabel.backgroundColor = .gray
        distanceAdventureLabel.textAlignment = .center
        containerOptionStackView.anchor(top: self.view.topAnchor,
                                     leading: nil,
                                     bottom: nil,
                                     trailing: self.view.trailingAnchor,
                                     padding: .init(top: 16, left: 0, bottom: 0, right: 16))

        containerOptionStackView.spacing = 10
        containerOptionStackView.axis = .vertical
        containerOptionStackView.alignment = .trailing
        currentLocationButton.constrainWidth(constant: 50)
        currentLocationButton.constrainHeight(constant: 50)
        self.currentLocationButton.backgroundColor = .black
        self.currentLocationButton.layer.cornerRadius = 25
        self.startAdventureButton.layer.cornerRadius = 25
        self.startAdventureButton.constrainWidth(constant: 200)
        
        startAdventureButton.backgroundColor = .green
        
        saveAdventure.setTitle("Save adventure", for: .normal)
        saveAdventure.backgroundColor = .gray
        saveAdventure.isHidden = true
        
        startAdventureButton.addTarget(self, action: #selector(startAdventureButtonAction),
                                       for: .touchUpInside)
        
        saveAdventure.addTarget(self, action: #selector(saveAdventureAction),
                                for: .touchUpInside)
        
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonPressed),
                                        for: .touchUpInside)
        
        currentLocationButton.setImage(UIImage(systemName: "location"), for: .normal)
        currentLocationButton.backgroundColor = .white
        
        currentLocationButton.layer.shadowColor = UIColor.black.cgColor
        currentLocationButton.layer.shadowOffset = .init(width: 1, height: 1)
        
        
        textView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        textView.backgroundColor = .white
        textView.delegate = self
        textView.text = "Por favor escribe"
        textView.textColor = UIColor.gray
    }
    
    @objc func currentLocationButtonPressed() {
        viewModel.getLocation()
        self.mapView.currentLocation(isShowed: true)
        
    }
    
    @objc func startAdventureButtonAction() {
//        viewModel.startAdventure()
        self.view.endEditing(true)
    }
    
    @objc func saveAdventureAction() {
        presentPopUpSave()
    }
    
    func presentPopUpSave() {
        let alerView = UIAlertController(title: "adventure",
                                         message: "con que nombre te gustaria guardar la aventura",
                                         preferredStyle: .alert)
        
        alerView.addTextField { textfield in
            textfield.placeholder = "name adventure"
        }
        
        alerView.addAction(UIAlertAction(title: "save",
                                         style: .default, handler: {[weak self] _ in
            if let nameAdventure = alerView.textFields?.first?.text {
                self?.saveAdventure(name: nameAdventure)
            }
            alerView.dismiss(animated: false, completion: nil)
        }))
        
        alerView.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        
        self.present(alerView, animated: false, completion: nil)
    }
    
    func saveAdventure(name: String) {
        self.viewModel.saveAdventure(name: name)
    }
    
}

extension HomeViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Por favor escribe" {
                textView.text = ""
                textView.textColor = UIColor.black
            }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = UIColor.gray
            textView.text = "Por favor escribe"
        }
    }
}
