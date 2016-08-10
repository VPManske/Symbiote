// Copyright (c) 2016 Vectorform LLC
// http://www.vectorform.com/
// http://github.com/vectorform/symbiote
//
//  Symbiote/Core
//  UIViewController+Hook.swift
//
import UIKit

extension UIViewController: SwizzleCompatible {
    
    internal static let SwizzleMethods = [
        Selector("viewDidAppear:"): Selector("SYMBIOTE_viewDidAppear_SW:"),
        Selector("viewWillDisappear:"): Selector("SYMBIOTE_viewWillDisappear_SW:"),
        
    ]
    
    internal func SYMBIOTE_viewDidAppear_SW(animated: Bool) {
        // we don't want to use swizzled method on analytics compatable class. logging is handled already
        if !(self is AnalyticsCompatible) {
            Symbiote.SharedInstance.logEvent(Event(method: Event.Methods.SwizzleHook, sender: Event.Senders.View, action: Event.Actions.Appear, data: [Event.DataDescriptors.ViewName: description], senderObject: self))
        }
        
        SYMBIOTE_viewDidAppear_SW(animated)

    }
    internal func SYMBIOTE_viewWillDisappear_SW(animated: Bool) {
        // we don't want to use swizzled method on analytics compatable class. logging is handled already
        if !(self is AnalyticsCompatible) {
            Symbiote.SharedInstance.logEvent(Event(method: Event.Methods.SwizzleHook, sender: Event.Senders.View, action: Event.Actions.Disappear, data: [Event.DataDescriptors.ViewName: description], senderObject: self))
        }
        
        SYMBIOTE_viewWillDisappear_SW(animated)
        
    }
}
