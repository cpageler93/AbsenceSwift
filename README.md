# AbsenceSwift
Absence.io Client for Swift

## Usage

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


## Tests

### Run tests in Xcode

- Xcode > Product > Scheme > Edit Scheme > "AbsenceSwift-Package" > Run > Arguments
- Add hawkId and hawkKey to "Environment Variables"
- Close "Edit Schemes"
- Run Tests in Xcode (cmd + u)

### Run tests in command line

```shell
hawkId=... hawkKey=... swift test
```


### Run tests for linux

```shell
hawkId=... hawkKey=... ./run_docker_tests.sh
```