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
    
    private let modelProvider = ModelProvider()
    
    private var chordsData = [SingleChord]() {
        didSet {
            DispatchQueue.main.async {
                self.currentKeyIndex = 0
                self.keyPicker.reloadAllComponents()
                self.chordPicker.reloadAllComponents()
            }
        }
    }
    
    private lazy var selectedChords = sampleChords1 {
        didSet {
            chordPicker.reloadAllComponents()
        }
    }
    
    private var currentKeyIndex = 0 {
        didSet {
            updateChordLabel(keyIndex: currentKeyIndex, suffixIndex: 0)
        }
    }
    
    private var currentChordIndex = 0 {
        didSet {
            updateChordLabel(keyIndex: currentKeyIndex, suffixIndex: currentChordIndex)
        }
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setDelegates()
        getChords()
    }
    
    private func initialSetup() {
        currentKeyIndex = 0
        keyPicker.transform = CGAffineTransform(rotationAngle: -(.pi / 2))
        chordPicker.transform = CGAffineTransform(rotationAngle: -(.pi / 2))
    }
    
    private func setDelegates() {
        keyPicker.dataSource = self
        keyPicker.delegate = self
        chordPicker.dataSource = self
        chordPicker.delegate = self
    }
    
    private func getChords() {
        modelProvider.provideData { [weak self] allChords in
            self?.chordsData = allChords.chords
        }
    }
    
    private func updateChordLabel(keyIndex: Int, suffixIndex: Int) {
        let chord = chordsData[safe: keyIndex]
        let key = chord?.keyName ?? "key"
        let suffix = chord?.chordSuffixes[safe: suffixIndex] ?? "suffix"
        chordDataLabel.text = "\(key) – \(suffix)"
    }

}

// MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerView === keyPicker
            ? chordsData.count
            : chordsData[safe: currentKeyIndex]?.chordSuffixes.count ?? 0
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
            ? chordsData[safe: row]?.keyName
            : chordsData[safe: currentKeyIndex]?.chordSuffixes[safe: row]
        label.transform = CGAffineTransform(rotationAngle: .pi / 2)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        100
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView === keyPicker {
            currentKeyIndex = row
        } else {
            currentChordIndex = row
        }
    }
    
}
