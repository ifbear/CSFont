//
//  ViewController.swift
//  CSFont
//
//  Created by dexiong on 2023/1/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var cfBundle: CFBundle?
        var resourceRequest: NSBundleResourceRequest?
        let bundle = Bundle(for: type(of: self))
        resourceRequest = NSBundleResourceRequest(tags: Set(arrayLiteral: "fonts"), bundle: bundle)
        cfBundle = CFBundleCreate(kCFAllocatorDefault, bundle.bundleURL as CFURL)
        resourceRequest?.beginAccessingResources(completionHandler: { error in
            if let error = error {
                print(error)
            } else {
                var fonts: [String] = []
                let weights: [String] = ["_Black", "_Bold", "_Light", "_Medium", "_Regular", "_Thin"]
                let types: [String] = ["", "_SC", "_TC", "_Naskh_Arabic_UI", "_Naskh_Arabic", "_Italic", "_Condensed_Italic", "_Condensed"]
                for type in types {
                    for weight in weights {
                        fonts.append("HarmonyOS_Sans\(type)\(weight)")
                    }
                }
                CTFontManagerRegisterFontsWithAssetNames(fonts as CFArray, cfBundle, .persistent, true) { errors, finish in
                    print(errors, finish)
                    return finish
                }
            }
        })
    }

}

