//
//  Utility.swift
//  sidebar123
//
//  Created by RAHUL PATEL on 9/13/17.
//  Copyright © 2017 RAHUL PATEL. All rights reserved.
//

import UIKit

class Utility: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

class CustomSearchTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(0, 15, 0, 0))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(0, 15, 0, 0))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(0, 15, 0, 0))
    }
}

class DeviceType{
    class func isIpad()->Bool
    {
        return UIDevice.current.userInterfaceIdiom == .pad ? true : false
    }
    class func isIphone5sAndBelow()->Bool{
        if UIScreen.main.bounds.height < 570 {
            return true
        }
        
        return false
    }
    
    class func isIphone4sOrIpad()->Bool{
        if UIScreen.main.bounds.height < 481 || UIDevice.current.model.hasPrefix("iPad") {
            return true
        }
        
        return false
    }
}

extension UIView {
    
    func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.20
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2.0
    }
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func anchors(left:NSLayoutXAxisAnchor?,right:NSLayoutXAxisAnchor?,top:NSLayoutYAxisAnchor?,bottom:NSLayoutYAxisAnchor?,leftConstant:CGFloat = 0,rightConstant:CGFloat = 0,topConstant:CGFloat = 0,bottomCosntant:CGFloat = 0){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let leftAnchor = left{
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: leftConstant).isActive = true
        }
        
        if let rightAnchor = right{
            self.rightAnchor.constraint(equalTo: rightAnchor, constant: rightConstant).isActive = true
        }
        
        if let topAnchor = top{
            self.topAnchor.constraint(equalTo: topAnchor, constant: topConstant).isActive = true
        }
        
        if let bottomAnchor = bottom{
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomCosntant).isActive = true
        }
    }
    
    
    func fillOnSupperView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        if let subperView = self.superview{
            self.leftAnchor.constraint(equalTo: subperView.leftAnchor, constant: 0).isActive = true
            self.rightAnchor.constraint(equalTo: subperView.rightAnchor, constant: 0).isActive = true
            self.topAnchor.constraint(equalTo: subperView.topAnchor, constant: 0).isActive = true
            self.bottomAnchor.constraint(equalTo: subperView.bottomAnchor, constant: 0).isActive = true
        }
    }
    
    func centerOnSuperView(constantX:CGFloat = 0 , constantY:CGFloat = 0 ){
        self.translatesAutoresizingMaskIntoConstraints = false
        if let subperView = self.superview{
            self.centerXAnchor.constraint(equalTo: subperView.centerXAnchor, constant: constantX).isActive = true
            self.centerYAnchor.constraint(equalTo: subperView.centerYAnchor, constant: constantY).isActive = true
        }
    }
    
    func setHieghtOrWidth(height:CGFloat?,width:CGFloat?){
        self.translatesAutoresizingMaskIntoConstraints = false
        if let heightConst = height{
            self.heightAnchor.constraint(equalToConstant: heightConst).isActive = true
        }
        if let widthAnchor = width{
            self.widthAnchor.constraint(equalToConstant: widthAnchor).isActive = true
        }
    }
    
    func centerOnYOrX(x:Bool?,y:Bool?,xConst:CGFloat=0,yConst:CGFloat=0){
        self.translatesAutoresizingMaskIntoConstraints = false
        if x != nil && y != nil{
            
            self.centerOnSuperView(constantX: xConst , constantY: yConst)
        }else if x != nil{
            self.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor, constant: xConst ).isActive = true
        }else if y != nil{
            self.centerYAnchor.constraint(equalTo: self.superview!.centerYAnchor, constant: yConst).isActive = true
        }
    }
    
    func addSubviews(views:[UIView]){
        for view in views{
            self.addSubview(view)
        }
    }
    
}

extension UIViewController {
    
    func setBackButton(){
        let yourBackImage = #imageLiteral(resourceName: "BackIcon")
        navigationController?.navigationBar.backIndicatorImage = yourBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
    }
   
}
