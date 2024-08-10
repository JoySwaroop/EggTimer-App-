import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft":3 , "Hard":4 , "Medium" :7]
    var totaltime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLable: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totaltime = eggTimes[hardness]!
        progressBar.progress = 0.0
        titleLable.text = hardness
        secondsPassed = 0
        
                
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
       }

        
    @objc func updateCounter() {
        
        if secondsPassed < totaltime {
            secondsPassed  += 1
            let percentProgress = Float(secondsPassed)/Float(totaltime)
            progressBar.progress = percentProgress
            
            
            
        } else {

            titleLable.text = "Done"
            playSound()
            timer.invalidate()
            
            func playSound() {
                guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)

                    player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                    guard let player = player else { return }

                    player.play()

                } catch let error {
                    print(error.localizedDescription)
                }
            }
                    }
        
        
        
    }
    

}
