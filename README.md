# 쥬스 자판기 프로젝트: Mango, SwainYun

## 참여자 : SwainYun, Mango
|SwainYun|Mango|
|:--:|:--:|
|<img src="https://avatars.githubusercontent.com/u/99116619?v=4" width=300>|<img src="https://avatars.githubusercontent.com/u/97822621?v=4" width=300>|



## 단계별 핵심 경험
### Step1
    1.Swift API Design Guide에 따른 이름짓기
    2.소스코드에 불필요한 코드 및 코멘트 남기지 않기
    3.메서드의 기능단위 분리
    4.요구사항에 따른 타입의 정의
    5.타입의 캡슐화/은닉화
    6.상황에 알맞는 상수/변수의 올바른 선택
     
### Step2
    1.내비게이션 바 및 바 버튼 아이템 활용
    2.얼럿 컨트롤러 활용
    3.Modality의 활용
    4.화면 사이의 데이터 공유
### Step3
    1.내비게이션 바 및 바 버튼 아이템의 활용
    2.얼럿 컨트롤러 활용
    3.Stepper 활용
    4.Modality의 활용
    5.화면 사이의 데이터 공유
    6.오토레이아웃 시작하기



## 스크린샷

<p>
    <img src="https://hackmd.io/_uploads/HkMvB-bl6.png" width=600>
    <img src="https://hackmd.io/_uploads/r1OwBbbl6.png" width=600>
    <img src="https://hackmd.io/_uploads/HyaDSW-g6.png" width=600>
</p>

## 트러블 슈팅
1. **반복되는 숫자를 별도로 관리하기**
```swift
init() {
    let initialQuantity: Int = 10

    var inventory: [FruitType: Int] = [:]

    for fruitType in FruitType.allCases {
        inventory[fruitType] = initialQuantity
    }

    self.inventory = inventory
}
```
> 초기 재고 수량 '10개'를 모든 과일에 대해 일일이 넣어주지 않고
> 반복문을 통해 초기화 해주었다.

2. **enum case 분리**
```swift
enum FruitType {
    case strawberry, banana, kiwi, pineapple, mango
}

enum FruitType {
    case strawberry
    case banana
    case kiwi
    case pineapple
    case mango
}
```
> 위와 아래처럼 케이스를 일렬로 나열하는 것과 케이스를 분리하는 것에 리뷰 주셨음.
> 별도의 원시값이 없는 상태에서는 일렬로 나열하는 것이 코드량과 가독성 측면에서 더 좋다고 보았음.

3. **Modality의 활용**
화면 전환 간 어떤 모달 방식을 사용해야 하는지에 대하여

```swift
// 얼럿창 띄우는 작업은 present 방식 채택
private func showAlertOutOfStock(_ error: Error) {
    let alert = UIAlertController(title: "\(error)", message: nil, preferredStyle: .alert)
    let yes = UIAlertAction(title: "예", style: .default) { _ in
      self.moveAdjustStorageView()                                                   }
    let no = UIAlertAction(title: "아니오", style: .destructive, handler: nil)
    alert.addAction(yes)
    alert.addAction(no)
    present(alert, animated: true, completion: nil)
}

// 뷰 이동하는 작업은 navigation push 방식 채택
private func pushAdjustStockViewController() {
    guard let adjustStockViewController = self.storyboard?.instantiateViewController(withIdentifier: "AdjustStockViewController") as? AdjustStockViewController
    else { return }
    
    self.navigationController?.pushViewController(adjustViewController, animated: true)
}
```
> 얼럿창을 띄우는 것은 기존의 작업에서 벗어나 사용자의 주의를 잠깐 돌리는 것이기 때문에 `present` 방식이 적절하다고 판단,
> 재고 수정 화면으로 이동하는 것은 다른 계층의 뷰를 올리는 것이기 때문에 `push` 방식이 적절하다고 판단함.

4. **화면 사이의 데이터 공유**
```swift
extension JuiceMakerViewController: InventorySendDelegate {
    func sendInventory(inventory: [FruitName: Int]) {
        self.inventory = inventory
        syncStockLabels()
        juiceMaker.updateFruitStoreInventory(with: inventory)
    }
}
```
>delegate를 만들어서 JuiceMakerViewController와 AdjustStockViewController 간에 데이터를 공유하도록 만들었다.



## 각자의 피드백
* **SwainYun** : 본격적인 UIKit 찍먹이 시작되고 어색한 개념에 적응하기 쉽지 않았다. 이 프로젝트로 알게된 기본기를 확실히 다지고 넘어갈 수 있었으면 좋겠다.
* **Mango** : 오토레이아웃을 사용하는 프로젝트가 시작되어서 delegate, Modality 등 새로운 개념을 요구하는 프로젝트였다. 새로운 개념을 프로젝트에 적용해 보는 경험을 해봐서 좋았다.
