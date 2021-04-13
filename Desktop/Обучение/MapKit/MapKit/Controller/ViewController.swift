//
//  ViewController.swift
//  MapKit
//
//  Created by Dastan Mambetaliev on 9/4/21.
//
import YandexMapKitSearch
import YandexMapKitPlaces
import YandexMapKitDirections
import Foundation
import YandexMapKit
import UIKit

class ViewController: UIViewController, YMKClusterListener, YMKClusterTapListener  {

    @IBOutlet weak var mapView: YMKMapView!
    private var imageProvider = UIImage(named: "Store")!
    private let CLUSTER_CENTERS: [YMKPoint] = [
        YMKPoint(latitude: 42.8746, longitude: 74.5902),
        YMKPoint(latitude: 42.8574, longitude: 74.6095),
        YMKPoint(latitude: 42.855597, longitude: 74.584980),
        YMKPoint(latitude: 42.874886, longitude: 74.618721)
    ]
    private let FONT_SIZE: CGFloat = 15
    private let MARGIN_SIZE: CGFloat = 3
    private let STROKE_SIZE: CGFloat = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        addLocationModel()

        // Note that application must retain strong references to both
        // cluster listener and cluster tap listener
        let collection = mapView.mapWindow.map.mapObjects.addClusterizedPlacemarkCollection(with: self)

        collection.addPlacemarks(with: CLUSTER_CENTERS, image: self.imageProvider, style: YMKIconStyle())

        // Placemarks won't be displayed until this method is called. It must be also called
        // to force clusters update after collection change
        collection.clusterPlacemarks(withClusterRadius: 60, minZoom: 15)
    }

    func clusterImage(_ clusterSize: UInt) -> UIImage {
        let scale = UIScreen.main.scale
        let text = (clusterSize as NSNumber).stringValue
        let font = UIFont.systemFont(ofSize: FONT_SIZE * scale)
        let size = text.size(withAttributes: [NSAttributedString.Key.font: font])
        let textRadius = sqrt(size.height * size.height + size.width * size.width) / 2
        let internalRadius = textRadius + MARGIN_SIZE * scale
        let externalRadius = internalRadius + STROKE_SIZE * scale
        let iconSize = CGSize(width: externalRadius * 2, height: externalRadius * 2)

        UIGraphicsBeginImageContext(iconSize)
        let ctx = UIGraphicsGetCurrentContext()!

        ctx.setFillColor(UIColor.red.cgColor)
        ctx.fillEllipse(in: CGRect(
            origin: .zero,
            size: CGSize(width: 2 * externalRadius, height: 2 * externalRadius)));

        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fillEllipse(in: CGRect(
            origin: CGPoint(x: externalRadius - internalRadius, y: externalRadius - internalRadius),
            size: CGSize(width: 2 * internalRadius, height: 2 * internalRadius)));

        (text as NSString).draw(
            in: CGRect(
                origin: CGPoint(x: externalRadius - size.width / 2, y: externalRadius - size.height / 2),
                size: size),
            withAttributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.black])
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }

    func onClusterAdded(with cluster: YMKCluster) {
        // We setup cluster appearance and tap handler in this method
        cluster.appearance.setIconWith(clusterImage(cluster.size))
        cluster.addClusterTapListener(with: self)
    }

    func onClusterTap(with cluster: YMKCluster) -> Bool {
        let alert = UIAlertController(
            title: "Tap",
            message: String(format: "Tapped cluster with %u items", cluster.size),
            preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)

        // We return true to notify map that the tap was handled and shouldn't be
        // propagated further.
        return true
    }
    
}
