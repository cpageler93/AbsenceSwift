# AbsenceSwift
Absence.io Client for Swift


# Usage


```swift
let absence = Absence.Client(id: "hawkId",
                             key: "hawkKey")

let options = Absence.Options(skip: 0,
                              limit: 50,
                              filter: Absence.Filter(items: [.assignedTo(.email("you@example.com"))]))
absence.absences(options: options) { result in
    switch result {
    case .success(let absenceResult):
        // do whatever you want with your data
        // absenceResult.data -> [Absence.Entry]
    case .failure(let error):
        // handle error
    }
}
```