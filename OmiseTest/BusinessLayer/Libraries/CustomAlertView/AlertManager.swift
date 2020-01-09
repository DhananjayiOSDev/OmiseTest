//
//  AlertManager.swift
//  DJUtilities
//
//  Created by Dhananjay on 20/06/2019.
//  Copyright © 2019 Dhananjay Pawar. All rights reserved.
//


import UIKit

class AlertManager: NSObject {
    
    typealias AlertActionHandler = () -> Void
    static var alertVC: AlertViewController!

    //show alert message with positive and naegative button. for single button pass negativetitle empty constant.
    static func showCustomAlert(Title title:String, Message message: String,PositiveTitle posBtnTitle:String,NegativeTitle negBtnTitle: String, onPositive positive: @escaping AlertActionHandler, onNegative negative: @escaping AlertActionHandler){
        
        var isCancel = true
        if(negBtnTitle.isEmpty){
           isCancel = false
        }
        
        alertVC = AlertViewController.create().config(title: title, message: message, CancelButton: isCancel)
        alertVC.addAction(AlertAction(title: posBtnTitle, type: .normal, handler: {
            positive()
        }))
        alertVC.addAction(AlertAction(title: negBtnTitle, type: .cancel, handler: {
            negative()
            
        }))
        
        self.alertVC.show(into: UIApplication.shared.keyWindow! )
    }
    
    static func showCustomInfoAlert(Title title:String, Message message: String,PositiveTitle posBtnTitle:String,View view:UIView){
        
        //alertVC = AlertViewController.create().config(title: title, message: message, CancelButton: false)
        if alertVC != nil {
            alertVC.tapNegativeButton(UIButton())
        }
        
        alertVC = AlertViewController.create().config(title: title, message: message, CancelButton: false)
        alertVC.addAction(AlertAction(title: posBtnTitle, type: .normal, handler: {
            view.endEditing(true)
        }))
        
        self.alertVC.show(into: UIApplication.shared.keyWindow! )
    }
}
