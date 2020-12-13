//
//  ViewController.swift
//  MWM chors
//
//  Created by Евгений Кириллов on 13.12.2020.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var chordDataLabel: UILabel!
    @IBOutlet weak var keyPicker: UIPickerView!
    @IBOutlet weak var chordPicker: UIPickerView!
    
    private let sampleKeys = (0...6).map { "Key \($0)" }
    private let sampleChords1 = (0...9).map { "Sample 1 - \($0)" }
    private let sampleChords2 = (0...9).map { "Sample 2 - \($0)" }
    private let sampleChords3 = (0...9).map { "Sample 3 - \($0)" }
    
    private lazy var selectedChords = sampleChords1 {
        didSet {
            chordPicker.reloadAllComponents()
        }
    }
    
    private lazy var currentChord = (key: sampleKeys.first!, chord: selectedChords.first!) {
        didSet {
            chordDataLabel.text = "\(currentChord.key) – \(currentChord.chord)"
        }
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setDelegates()
    }
    
    private func initialSetup() {
        currentChord = (key: sampleKeys.first!, chord: selectedChords.first!)
        keyPicker.transform = CGAffineTransform(rotationAngle: -(.pi / 2))
        chordPicker.transform = CGAffineTransform(rotationAngle: -(.pi / 2))
    }
    
    private func setDelegates() {
        keyPicker.dataSource = self
        keyPicker.delegate = self
        chordPicker.dataSource = self
        chordPicker.delegate = self
    }

}

// MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerView === keyPicker
            ? sampleKeys.count
            : selectedChords.count
    }
    
}

// MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {
        let label = UILabel()
        label.text = pickerView === keyPicker
            ? sampleKeys[row]
            : selectedChords[row]
        label.transform = CGAffineTransform(rotationAngle: .pi / 2)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        100
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView === keyPicker
            ? updateKey(row)
            : updateChord(row)
    }
    
    private func updateKey(_ newKeyIndex: Int) {
        let newKey = sampleKeys[newKeyIndex]
        currentChord.key = newKey
        let newChordSample = [sampleChords1, sampleChords2, sampleChords3].randomElement()
        selectedChords = newChordSample!
        updateChord(0)
    }
    
    private func updateChord(_ newChordIndex: Int) {
        let newChord = selectedChords[newChordIndex]
        currentChord.chord = newChord
    }
    
}
