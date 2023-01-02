//
//  MapVC.swift
//  WorldTrotter
//
//  Created by Mohamed Atallah on 22/12/2022.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    //MARK: - Porperties
    var mapView: MKMapView!
    
    
    //MARK: - Life cycle
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        
        let standardString = NSLocalizedString("standard", comment: "Standard map view")
        let hypridString = NSLocalizedString("hybrid", comment: "Hyprid map view")
        let satalliteString = NSLocalizedString("satellite", comment: "Satallite map view")
        let segmentedControl = UISegmentedControl(items: [standardString, hypridString, satalliteString])
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        // Attaching a target-action to segmented controll
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        // segmated Controller Constraints
        let topConstaints = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraints = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraints = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        // Activate Constraints
        topConstaints.isActive = true
        leadingConstraints.isActive = true
        trailingConstraints.isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // MARK: - Actions
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
}
