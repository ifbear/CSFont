//
//  ViewController.swift
//  CSFont
//
//  Created by dexiong on 2023/1/28.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "这是什么字体"
        label.font = UIFont(name: "HarmonyOS_Sans_SC", size: 17.0)
        return label
    }()
    private lazy var label2: UILabel = {
        let label = UILabel()
        label.text = "这是什么字体2"
        label.font = UIFont.systemFont(ofSize: 17.0)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(CTFontManagerCopyRegisteredFontDescriptors(.persistent, true))
        view.addSubview(label)
        label.frame = .init(x: 100, y: 100, width: 300, height: 32)
        
        
        view.addSubview(label2)
        label2.frame = .init(x: 100, y: 200, width: 300, height: 32)
        
        
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

