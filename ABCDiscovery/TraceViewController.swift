//
//  TraceView.swift
//  ABCDiscovery
//
//  Created by Ye David on 4/25/17.
//  Copyright © 2017 YeDavid. All rights reserved.
//

import Foundation
import UIKit

class TraceViewController: UIViewController {
    
    var letter: String = ""
    var lastPoint: CGPoint = CGPoint.zero
    var currentColor: UIColor = UIColor.black
    var currentStrokeSize: CGFloat = 5.0
    var currentFont: String = "Helvetica Bold"
    
    let buttonBoldBorderWidth: CGFloat = 3.0
    let buttonNormalBorderWidth: CGFloat = 0.8
    
    @IBOutlet weak var canvas: UIImageView!
    @IBOutlet weak var letterImage: UIImageView!
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    
    @IBOutlet weak var exLargeButton: UIButton!
    @IBOutlet weak var largeButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var smallButton: UIButton!
    @IBOutlet weak var exSmallButton: UIButton!
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(UIImage(view: self.canvas), self, #selector(onImageSaved(image:error:contextInfo:)), nil)
    }
    
    @IBAction func strokerSizeButtonPressed(_ sender: UIButton) {
        currentStrokeSize = CGFloat(sender.tag)
        exLargeButton.backgroundColor = exLargeButton.tag == sender.tag ? UIColor.gray : nil
        largeButton.backgroundColor = largeButton.tag == sender.tag ? UIColor.gray : nil
        mediumButton.backgroundColor = mediumButton.tag == sender.tag ? UIColor.gray : nil
        smallButton.backgroundColor = smallButton.tag == sender.tag ? UIColor.gray : nil
        exSmallButton.backgroundColor = exSmallButton.tag == sender.tag ? UIColor.gray : nil
    }
    
    @IBAction func colorButtonPressed(_ sender: UIButton) {
        switch sender.tag {
            case redButton.tag:
                currentColor = UIColor.red
            case blueButton.tag:
                currentColor = UIColor.blue
            case greenButton.tag:
                currentColor = UIColor.green
            case blackButton.tag:
                currentColor = UIColor.black
            case yellowButton.tag:
                currentColor = UIColor.yellow
            default:
                currentColor = UIColor.black
        }
        resetButtonBorderColor(sender: sender)
    }
    
    func onImageSaved(image: UIImage, error: NSError?, contextInfo: UnsafeRawPointer) {
        var title: String = "Image saved"
        var message: String = "Image has been saved."
        
        if let e = error {
            title = "Image save error"
            message = "An error has occurred saving the image: \(e.localizedDescription)"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func resetButtonBorderColor(sender: UIButton) {
        redButton.layer.borderWidth = sender.tag == redButton.tag ? buttonBoldBorderWidth : buttonNormalBorderWidth
        blueButton.layer.borderWidth = sender.tag == blueButton.tag ? buttonBoldBorderWidth : buttonNormalBorderWidth
        greenButton.layer.borderWidth = sender.tag == greenButton.tag ? buttonBoldBorderWidth : buttonNormalBorderWidth
        blackButton.layer.borderWidth = sender.tag == blackButton.tag ? buttonBoldBorderWidth : buttonNormalBorderWidth
        yellowButton.layer.borderWidth = sender.tag == yellowButton.tag ? buttonBoldBorderWidth : buttonNormalBorderWidth
    }
    
    init(nibName: String?, bundle: Bundle?, letter: String?) {
        self.letter = letter ?? ""
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //UIGraphicsBeginImageContext(self.view.frame.size)
        lastPoint = getTouchedPoint(touches: touches) ?? lastPoint
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentPoint: CGPoint? =  getTouchedPoint(touches: touches)
        if let cPoint = currentPoint {
            canvas.image = canvas.image!.drawWithOptions(from: lastPoint, to: cPoint, size: self.canvas.frame.size, strokeSize: currentStrokeSize, strokeColor: currentColor.cgColor) ?? UIImage()
            lastPoint = cPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentPoint: CGPoint? =  getTouchedPoint(touches: touches)
        if let cPoint = currentPoint {
            canvas.image = canvas.image!.drawWithOptions(from: lastPoint, to: cPoint, size: self.canvas.frame.size, strokeSize: currentStrokeSize, strokeColor: currentColor.cgColor) ?? UIImage()
            lastPoint = cPoint
        }
    }
    
    func setView() -> Void {
        canvas.image = UIImage()
        letterImage.image = UIImage()
        letterImage.image = letterImage.image!.drawTextWithOptions(rect: letterImage.frame, text: NSString(string: letter), font: currentFont, fontSize: 150, alpha: 0.9) // drawText(rect: letterImage.frame, view: letterImage.image!, text: NSString(string: letter))
        setStrokeSizeButton(name: "brushExSmall.png", button: exSmallButton)
        setStrokeSizeButton(name: "brushSmall.png", button: smallButton)
        setStrokeSizeButton(name: "brushMedium.png", button: mediumButton)
        setStrokeSizeButton(name: "brushLarge.png", button: largeButton)
        setStrokeSizeButton(name: "brushExLarge.png", button: exLargeButton)
        
        exLargeButton.setBorder(width: 0.8, color: UIColor.black.cgColor, cornerRadius: 5.0)
        largeButton.setBorder(width: 0.8, color: UIColor.black.cgColor, cornerRadius: 5.0)
        mediumButton.setBorder(width: 0.8, color: UIColor.black.cgColor, cornerRadius: 5.0)
        smallButton.setBorder(width: 0.8, color: UIColor.black.cgColor, cornerRadius: 5.0)
        exSmallButton.setBorder(width: 0.8, color: UIColor.black.cgColor, cornerRadius: 5.0)
        
        redButton.setBorder(width: 0.8, color: UIColor.lightGray.cgColor, cornerRadius: 5.0)
        blueButton.setBorder(width: 0.8, color: UIColor.lightGray.cgColor, cornerRadius: 5.0)
        greenButton.setBorder(width: 0.8, color: UIColor.lightGray.cgColor, cornerRadius: 5.0)
        blackButton.setBorder(width: 0.8, color: UIColor.lightGray.cgColor, cornerRadius: 5.0)
        yellowButton.setBorder(width: 0.8, color: UIColor.lightGray.cgColor, cornerRadius: 5.0)
        
        resetButtonBorderColor(sender: blackButton)
        strokerSizeButtonPressed(exLargeButton)
    }
    
    func setStrokeSizeButton(name: String, button: UIButton) -> Void {
        let image: UIImage = UIImage(named: name)!
        let sub = UIImageView(image: UIImage(named: name))
        sub.frame = CGRect(x: (button.frame.width - image.size.width) / 2, y: (button.frame.height - image.size.height) / 2, width: image.size.width, height: image.size.height)
        button.addSubview(sub)
        sub.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
    }
    
    func getTouchedPoint(touches: Set<UITouch>) -> CGPoint? {
        var point: CGPoint?
        if let touch = touches.first {
            point = touch.location(in: self.canvas)
        }
        return point
    }
    
}
