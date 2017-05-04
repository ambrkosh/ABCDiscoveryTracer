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
        return CGRect(x: self.scrollView.frame.width / 4, y: (CGFloat(item.first!.key) * (self.scrollView.frame.height / 4 + yPadding)), width: self.scrollView.frame.width / 2, height: self.scrollView.frame.height / 4)
    }
    
    func getButtonList() -> [String:[Int:UIImage]] {
        return ["A a":[0:UIImage(named: "apple.png")!], "B b":[1:UIImage(named: "banana.png")!],
                "C c":[2:UIImage(named: "cookie.png")!], "D d":[3:UIImage(named: "duck.png")!],
                "E e":[4:UIImage(named: "egg.png")!], "F f":[5:UIImage(named: "fish.png")!],
                "G g":[6:UIImage(named: "guitar.png")!], "H h":[7:UIImage(named: "horse.png")!],
                "I i":[8:UIImage(named: "igloo.jpg")!], "J j":[9:UIImage(named: "jam.jpg")!],
                "K k":[10:UIImage(named: "kite.png")!], "L l":[11:UIImage(named: "lamb.png")!],
                "M m":[12:UIImage(named: "melon.png")!], "N n":[13:UIImage(named: "net.gif")!],
                "O o":[14:UIImage(named: "onion.png")!], "P p":[15:UIImage(named: "pencil.png")!],
                "Q q":[16:UIImage(named: "question.jpg")!], "R r":[17:UIImage(named: "rabbit.png")!],
                "S s":[18:UIImage(named: "sun.png")!], "T t":[19:UIImage(named: "tent.png")!],
                "U u":[20:UIImage(named: "umbrella.png")!], "V v":[21:UIImage(named: "violin.png")!],
                "W w":[22:UIImage(named: "watermelon.png")!], "X x":[23:UIImage(named: "xylophone.jpg")!],
                "Y y":[24:UIImage(named: "yacht.png")!], "Z z":[25:UIImage(named: "zebra.png")!]]
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

