//
//  ViewController.swift
//  ABCDiscovery
//
//  Created by Ye David on 4/24/17.
//  Copyright © 2017 YeDavid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var traceViewController: TraceViewController?
    var buttonList: [String:[Int:UIImage]]?
    var generateButtonList: [UIView]?
    
    let yPadding: CGFloat = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        buttonList = getButtonList()
        generateButtonList = []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        generateButtonList?.forEach({ cb in
            cb.removeFromSuperview()
        })
        generateButtonList?.removeAll()
    }
    
    func setupMenu() -> Void {
        generateButtons(list: buttonList!).forEach({ cb in
            scrollView.addSubview(cb)
            generateButtonList?.append(cb)
        })
        
        scrollView.contentSize = scrollView.subviews.reduce(CGSize.zero, { r,v in
            return CGSize(width: r.width, height: r.height + v.frame.size.height + yPadding)
        })
    }
    
    func colorButtonPressed(_ sender: CustomUIButton) {
        let nibName: String = UIDevice.current.model.contains("iPad") ? "TraceView-iPad" : "TraceView"
        traceViewController = TraceViewController(nibName: nibName, bundle: nil, letter: sender.title)
        self.present(traceViewController!, animated: true, completion: nil)
    }
    
    func getFrameForItem(item: [Int:UIImage]) -> CGRect {
        return CGRect(x: self.scrollView.frame.width / 4, y: (CGFloat(item.first!.key) * (self.scrollView.frame.height / 4 + yPadding) + 40), width: self.scrollView.frame.width / 2, height: self.scrollView.frame.height / 4)
    }
    
    func getButtonList() -> [String:[Int:UIImage]] {
        if let url = Bundle.main.url(forResource: "ImagesConfig", withExtension: "plist") {
            do {
                let data: Data = try Data(contentsOf: url)
                let dict: [String:String] = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:String]
                let result: [String:[Int:UIImage]] = [:]
                
                let sortedList = dict.sorted(by: { a, b in
                    return a.key < b.key
                }).enumerated().map({ i, v in
                    return [v.key:[i:UIImage(named: v.value)!]]
                }).reduce(result, { r, v in
                    var myResult = r
                    myResult[v.first!.key] = v.first!.value
                    return myResult
                })
                return sortedList
            } catch {
                print(error)
                return [:]
            }
        } else {
            return [:]
        }
    }
    
    func generateButtons(list: [String:[Int:UIImage]]) -> [CustomUIButton] {
        let customButtonList: [CustomUIButton] = list.map({ item in
            let cb = CustomUIButton(frame: getFrameForItem(item: item.value), image: item.value.first!.value, title: item.key)
            cb.addTarget(self, action: #selector(colorButtonPressed), for: UIControlEvents.touchUpInside)
            return cb
        })
        return customButtonList
    }


}

