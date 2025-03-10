# CustomKeyboard - iOS
프리온보딩 두번째 과제 📱

> CustomKeyboard는 한글 오토마타 알고리즘을 적용해서 만든 나만의 Keyboard App 입니다.

<br>

## 🧑‍💻 Developers
|Seocho(조성빈)|
|---|
|<img width = "200" alt= "서초(조성빈)" src = "https://user-images.githubusercontent.com/64088377/177668277-f9db3eb2-b252-4795-9eec-4f8cc5e10304.jpeg">|
<br>

## 👀 미리보기
|Basic function|Extension|
|---|---|
|<img width = "250" alt="page1-VoiceRecorder" src = "https://user-images.githubusercontent.com/73249915/180597545-5c5d502f-7b42-4078-807f-c5fae3cd23f5.gif">|<img width = "250" alt= "page2-VoiceRecorder" src = "https://user-images.githubusercontent.com/73249915/180597790-60bc5e75-c19d-4045-bed0-69c9b8c2eb9a.gif">|

<br>

## 🛠 개발환경
<img width="90" alt="스크린샷 2021-11-19 오후 3 52 02" src="https://img.shields.io/badge/iOS-13.0+-silver"> <img width="90" alt="스크린샷 2021-11-19 오후 3 52 02" src="https://img.shields.io/badge/Xcode-13.4-blue">

<br>

## 구현

<br>

|Basic Function|Extension|
|-----|---|
|<br> 1. 한글 오토마타 알고리즘을 적용해서 Custom Keyboard 구현 <br><br> 2. 앱 실행시 URLSession을 사용해서 받아온 데이터를 tableView에 표현 <br><br> 3. Post시 받아온 데이터를 화면에 업데이트 <br><br>|1. Custom Keyboard Extension을 통해 다른 앱에서도 사용할 수 있도록 구현 <br>|

<br>

### 한글 오토마타 알고리즘

<br>

![Flowchart Template (1)](https://user-images.githubusercontent.com/73249915/180601444-27930f5a-1599-49ad-9244-c8f785a9ede8.jpg)


<br>

## ⚠️ Trouble Shooting

### “종성 이후의 문자에 대한 표시”

- 문제점
    - 종성 이후에 입력되는 문자를 지우거나 추가하는 것을 반복했을 때 조합이 잘 되지 않음.
- 원인
    - 조합표에 의해 조합이 완성된 단어를 고정시켜버리는 바람에 수정했을 때 변화가 일어나지 않음
- 해결방안
    - 버퍼에서 추가 입력이 일어났을 때 처음부터 계속 계산할 수 있도록 구현
    <br>
    
    ```swift
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    			if keyboardViewModel.keyboardLayout[indexPath.row] == "Return" || keyboardViewModel.keyboardLayoutWithShift[indexPath.row] == "Return" {
    		      pressEnter()
    		  }
    		  keyboardViewModel.handleKeyboardInput(indexPath.row)
    		  keyboardViewModel.automata()
    		  keyboardView.reviewTextLabel.text = KoreanAutomata.AutomataInfo.finalArray.joined(separator: "")
    }
    ```
    

---

## **🤔** 고민한 점

### “버퍼에 글자가 쌓일수록 계산할 때 시간이 오래걸리는데 이를 어떻게 해결해야할까?”

- 고민에 대한 노력
    - 자료구조를 배열에서 트리로 변경하여 탐색에 좀 더 유용하게 변경하면 어떨까?
        - 트리는 탐색에 효율적으로 시간 복잡도에 있어서 좋을지 모르지만, 공간 복잡도에서는 효율이 그다지 좋지 못하기 때문에, 위 두개의 사항을 고려해서 최적의 알고리즘을 구현하면 괜찮을 것 같다.
    - 현재 입력된 글자들은 하나의 버퍼에 담겨져서 입력될 때마다 그 버퍼를 선형 탐색법을 이용하여 계산하는 중인데, 이를 버퍼의 크기가 커졌을 때를 대비하여 해쉬 탐색법으로 변경하여 시간에 대한 효율을 끌어올리는 방법
        - 해쉬 탐색법의 구현은 기존의 탐색법에 비해 러닝 커브가 있기 때문에, 접근이 쉽지 않지만 자료구조 자체를 바꾸는 것보다는 코드의 수정이 적을 것 같아서 이를 적용할 예정이다.

### “싱글톤 패턴을 굳이 사용해야할까?”

- 고민에 대한 노력
    - 싱글톤 패턴은 전역에서 싱글톤 인스턴스에서 접근하여 상태를 변경할 수 있는 문제가 있는데, 이번 과제의 규모가 크지 않고 또 싱글톤 인스턴스에 접근할 경우가 많지 않기 때문에, 굳이 변경에 대한 위험을 감수하면서 싱글톤으로 구현할 필요가 없다고 판단

<br>

## 🔀  Git Branch

개별 브랜치 관리 및 병합의 안정성을 위해 `Git Forking WorkFlow`를 적용했습니다.

Branch를 생성하기 전 Git Issues에 구현내용을 작성하고,

`<Prefix>/ <구현내용>` 의 양식에 따라 브랜치 명을 작성합니다.

#### 1️⃣ prefix

- `develop` : feature 브랜치에서 구현된 기능들이 merge될 브랜치. **default 브랜치이다.**
- `feature` : 기능을 개발하는 브랜치, 이슈별/작업별로 브랜치를 생성하여 기능을 개발한다
- `main` : 개발이 완료된 산출물이 저장될 공간
- `release` : 릴리즈를 준비하는 브랜치, 릴리즈 직전 QA 기간에 사용한다
- `bug` : 버그를 수정하는 브랜치
- `hotfix` : 정말 급하게, 제출 직전에 에러가 난 경우 사용하는 브렌치

#### 2️⃣ Git forking workflow 적용

1. 팀 프로젝트 repo를 포크한다.(이하 팀 repo)
2. 포크한 개인 repo(이하 개인 repo)를 clone한다.
3. 개인 repo에서 작업하고 개인 repo의 원격저장소로 push한다.
4. pull request를 한다
5. reviewer가 코드리뷰를 진행하고 이상 없을시 팀 repo로 merge 혹은 피드백을 준다.
5. pull 받아야 할 때에는 팀 repo에서 pull 받는다.

</br>

## ⚠️  Issue Naming Rule
#### 1️⃣ 기본 형식
`[<PREFIX>]: <Description>` 의 양식을 준수하되, Prefix는 협업하며 맞춰가기로 한다.

#### 2️⃣ 예시
```
[Feat]: 기능 구현
[Fix]: 원격/로컬 파일 동기화 안되던 버그 수정
```

#### 3️⃣ Prefix의 의미

```bash
[Feat] : 새로운 기능 구현
[Design] : just 화면. 레이아웃 조정
[Fix] : 버그, 오류 해결, 코드 수정
[Add] : Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 View 생성
[Del] : 쓸모없는 코드, 주석 삭제
[Refactor] : 전면 수정이 있을 때 사용합니다
[Remove] : 파일 삭제
[Chore] : 그 이외의 잡일/ 버전 코드 수정, 패키지 구조 변경, 파일 이동, 파일이름 변경
[Docs] : README나 WIKI 등의 문서 개정
[Comment] : 필요한 주석 추가 및 변경
[Merge] : 머지
```

</br>

##  Commit Message Convention

#### 1️⃣ 기본 형식
prefix는 Issue에 있는 Prefix와 동일하게 사용한다.
```swift
[prefix]: 이슈제목
1. 이슈내용
2. 이슈내용
```

#### 2️⃣ 예시 : 아래와 같이 작성하도록 한다.

```swift
// 새로운 기능(Feat)을 구현한 경우
[Feat]: 기능 구현
1. TableView CRUD 구현
// 레이아웃(Design)을 구현한 경우
[Design]: 레이아웃 구현
1. page1 레이아웃 완료
```

</br>

