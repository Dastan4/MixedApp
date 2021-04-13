//
//  Location.swift
//  MapKit
//
//  Created by Dastan Mambetaliev on 13/4/21.
//
import YandexMapKit
import Foundation

extension ViewController: YMKUserLocationObjectListener {
    
    func addLocationModel() {
    mapView.mapWindow.map.isRotateGesturesEnabled = false
    mapView.mapWindow.map.move(with:
        YMKCameraPosition(target: YMKPoint(latitude: 0, longitude: 0), zoom: 14, azimuth: 0, tilt: 0))
    
    let scale = UIScreen.main.scale
    let mapKit = YMKMapKit.sharedInstance()
    let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)

    userLocationLayer.setVisibleWithOn(true)
    userLocationLayer.isHeadingEnabled = true
    userLocationLayer.setAnchorWithAnchorNormal(
        CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale),
        anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))
    userLocationLayer.setObjectListenerWith(self)
}

func onObjectAdded(with view: YMKUserLocationView) {
    view.arrow.setIconWith(UIImage(named:"UserArrow")!)
    
    let pinPlacemark = view.pin.useCompositeIcon()
    
    
    pinPlacemark.setIconWithName(
        "pin",
        image: UIImage(named:"Location")!,
        style:YMKIconStyle(
            anchor: CGPoint(x: 0.5, y: 0.5) as NSValue,
            rotationType:YMKRotationType.rotate.rawValue as NSNumber,
            zIndex: 1,
            flat: true,
            visible: true,
            scale: 1,
            tappableArea: nil))

    view.accuracyCircle.fillColor = UIColor.blue
}

func onObjectRemoved(with view: YMKUserLocationView) {}

func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {}

}
