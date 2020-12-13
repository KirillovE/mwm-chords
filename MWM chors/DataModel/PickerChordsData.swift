//
//  PickerChordsData.swift
//  MWM chors
//
//  Created by Евгений Кириллов on 13.12.2020.
//

struct PickerChords {
    let chords: [SingleChord]
}

extension PickerChords {
    init(withAllData allData: AllChordsData) {
        chords = allData.keys.map { key in
            let chordSuffixes = key.chordIds.map { allData.chords[$0].suffix }
            return SingleChord(keyName: key.name, chordSuffixes: chordSuffixes)
        }
    }
}

struct SingleChord {
    let keyName: String
    let chordSuffixes: [String]
}
