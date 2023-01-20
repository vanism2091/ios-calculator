# Calculator

## 👊🏻 트러블슈팅

### 🤔 문제 상황

- 객체들이 잘 동작하는지 테스트할 때 각 객체를 XCTAssertEqual로 테스트하고 싶었어요.
  - 그렇지 않으면, enqueue와 dequeue를 반복하며 각 element들을 1:1 비교해야 했는데, 이것이 번거로웠기 때문입니다.
- 테스트를 위해 객체간 값 비교를 해야했는데 protocol인 `CalculateItem`이 빈 프로토콜이라 값비교가 되지 않았어요.

### 👨‍💻 해결 과정

1. **각 객체는 Test 모듈 안에서만 `Equatable`을 adopt합니다.**
   - 비교하려는 객체가 `Equatable` 프로토콜을 adopt하고 `static func ==` method를 구현하면 이를 해결할 수 있어요.
   - 그런데 이 부분은 구현하려는 모듈 내에서는 필요하지 않은 기능이예요.
   - 그러므로 Test 모듈 안에서만 `Equatable`을 conform하도록 해당 모듈 안에서 `Extension.swift` 파일을 만들어서 이를 구현했습니다.
2. **CalculatorItemQueue는 CalculateItem Protocol을 따르는 Element를 받도록 Generic을 활용한다.**

   - 기존 구현에서 `CalculatorItemQueue`의 items의 타입은 `[CalculateItem]` 이었어요.
   - `Formula`는 `CalculatorItemQueue`로 이루어져있고, `CalculatorItemQueue`는 `CalculateItem`으로 이루어져 있기 때문에 두 객체가 `Equatable`하기 위해서 `CalculateItem` 역시 `Equatable`해야 한다고 생각했어요.
   - 그러나 `CalculateItem`은 빈 프로토콜이므로 Equatable일 수 없고, 따라서 기존의 코드로는 Queue와 Formula가 Equatable할 수 없다고 판단했어요.
   - 이를 해결하기 위해 `CalculatorItemQueue`에 `Generic`을 추가했어요.
     ```swift
     struct CalculatorItemQueue<Element: CalculateItem>: CalculatorItemQueueProtocol { }
     struct Formula {
         var operands: CalculatorItemQueue<Double>
         var operators: CalculatorItemQueue<Operator>
     }
     ```
   - 그리고 Tests 모듈에는 아래와 같이 각 객체에 `Equatable`을 구현한 `Extension.swift`를 작성했어요.

     ```swift
     extension Formula: Equatable {
         public static func == (lhs: Self, rhs: Self) -> Bool {
             return lhs.operands == rhs.operands && lhs.operators == rhs.operators
         }
     }

     extension CalculatorItemQueue where Element: Equatable {
         public static func == (lhs: Self, rhs: Self) -> Bool {
             return lhs.values == rhs.values
         }
     }
     ```

   - `Element`가 `Equatable`인 `CalculatorItemQueue`에 한해 `Equatable`을 정의할 수 있게 되었습니다.
   - `Formula`의 `CalculatorItemQueue` 타입 properties는 `Double`, `Operator`로 모두 `Equatable`인 `Element`입니다.
   - 객체의 `Equatable`의 기반이 Equatable을 준수하는 `Double`과 `Operator`로부터 나오므로, 이제 두 객체 모두 Equatable을 정의할 수 있게 되었어요!
   - 거기다가 기존 모듈 구현부에는 Formula의 result를 수행할 때 operand와 operator를 Double, Operator로 다운 캐스팅을 해야했는데, 제네릭을 사용하면서 다운캐스팅이 필요 없어지는 부수 효과도 있었습니다😆.

## 🧹 이번주 학습내용 요점 정리

### 🚥 TDD

- `테스트`(🔴)를 먼저 추가하고 이를 위한 `구현`(🟢)을 진행하고 마지막으로 필요하다면 `리팩토링`(🔵)을 하여 TDD를 진행했습니다.

<img width="1600" alt="스크린샷 2023-01-20 13 57 37" src="https://user-images.githubusercontent.com/22979718/213620489-3740b10a-3360-4d1e-ad43-8cc4753c7543.png">

### ❓ Optional과 Non-optional value의 equality

- 옵셔널과 일반 타입은 서로 다른 타입으로 알고 있어서 `==`를 통한 단순비교가 안될 것이라 생각했는데, 실제로 값 비교가 가능하여 조사를 진행했습니다. swift 레포지토리의 `public static func ==` 구현부분([링크](https://github.com/apple/swift/blob/e032b3191d8a3244ba1ee177c447d74325c602b1/stdlib/public/core/Optional.swift#L399))을 참고하여 실제 구현내용을 확인했고 아래와 같이 동작하는 것을 확인했습니다.
  1. Double == Optional(Double) -> Optional(Double) == Optional(Double)
  2. nil == nil
  3. Double == Double -> Double == Double

<img width="913" alt="스크린샷 2023-01-20 14 21 40" src="https://user-images.githubusercontent.com/22979718/213623174-2a756f68-8295-4748-80a9-744685ae554c.png">

### 📂 iOS 폴더 구조

- iOS 프로젝트 관련하여 MVC(Model, View, Controller) 패턴 및 Protocol, Extension 파일 관련하여 폴더를 나누는 방법에 대해 고민해봤습니다.
- 참고할 수 있는 공식문서가 있으면 좋았겠지만 찾지 못해서 Firefox 오픈소스를 참고하여 아래와 같이폴더 구조를 나눠봤습니다.

  <img width="330" alt="스크린샷 2023-01-20 14 06 00" src="https://user-images.githubusercontent.com/22979718/213621606-3f5396e8-922e-4f0f-afc1-d3122979d457.png">

## 다음주 프로젝트 계획

- [ ] 두 번째 리뷰에 대한 피드백
- [ ] UI 만들기
