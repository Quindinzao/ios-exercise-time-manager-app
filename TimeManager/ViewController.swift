//
//  ViewController.swift
//  TimeManager
//
//  Created by João Victor Fernandes on 13/03/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var outletButton: [UIButton]!
    @IBOutlet weak var countText: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var timeTraining: [String: Int] = [
        "walk": 1,
        "run": 2,
        "exercise": 3
    ]

    var totalTime: Int = 0
    var timer = Timer()

    let buttonDisableColor = UIColor(named: "DisableColor");
    let buttonPlayColor = UIColor(named: "PlayColor");
    let buttonPauseColor = UIColor(named: "PauseColor");
    let buttonStopColor = UIColor(named: "StopColor");
    
    override func viewDidLoad() {
        for item in outletButton {
            item.layer.cornerRadius = 28
        }

        playButton.backgroundColor = buttonDisableColor
        pauseButton.backgroundColor = buttonDisableColor
        stopButton.backgroundColor = buttonDisableColor

        playButton.isEnabled = false
        pauseButton.isEnabled = false
        stopButton.isEnabled = false

        super.viewDidLoad()
    }

    @IBAction func selectedTime(_ sender: UIButton) {
        timer.invalidate()
        let pressedTime: String = sender.titleLabel!.text!
        totalTime = timeTraining[pressedTime]! * 60
        let (h, m, s) = secondsToHoursMinutesSeconds(totalTime)
        countText.text = "\(h):\(m):\(s)"
        
        playButton.backgroundColor = buttonPlayColor
        pauseButton.backgroundColor = buttonDisableColor
        stopButton.backgroundColor = buttonDisableColor
        
        playButton.isEnabled = true
        pauseButton.isEnabled = false
        stopButton.isEnabled = false
    }
    
    @IBAction func handlePlay() {
        playButton.backgroundColor = buttonDisableColor
        pauseButton.backgroundColor = buttonPauseColor
        stopButton.backgroundColor = buttonStopColor

        playButton.isEnabled = false
        pauseButton.isEnabled = true
        stopButton.isEnabled = true

        timer.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateCountdown),
            userInfo: nil,
            repeats: true
        )
        
    }

    @IBAction func handlePause() {
        playButton.backgroundColor = buttonPlayColor
        pauseButton.backgroundColor = buttonDisableColor

        playButton.isEnabled = true
        pauseButton.isEnabled = false

        timer.invalidate()
    }

    @IBAction func handleStop() {
        playButton.backgroundColor = buttonDisableColor
        pauseButton.backgroundColor = buttonDisableColor
        stopButton.backgroundColor = buttonDisableColor

        playButton.isEnabled = false
        pauseButton.isEnabled = false
        stopButton.isEnabled = false
        
        timer.invalidate()
        totalTime = 0
        countText.text = "00:00:00"
    }
    
    @objc func updateCountdown() {
        let (h, m, s) = secondsToHoursMinutesSeconds(totalTime)
        if totalTime >= 0 {
            totalTime -= 1
            countText.text = "\(h):\(m):\(s)"
        } else {
            timer.invalidate()
            handleStop()
        }
    }

    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (String, String, String) {
        return (
            addZero(seconds / 3600),
            addZero((seconds % 3600) / 60),
            addZero((seconds % 3600) % 60)
        )
    }
    
    func addZero(_ number: Int) -> (String) {
        if number < 10 {
            return "0\(number)"
        } else {
            return String(number)
        }
    }
}
