---
draft: false
tags:
  - 2-2/프론트엔드프로그래밍
date: 2025-09-24
---
## 1. 자바스크립트 개요
### 1.1. 역사 및 표준
- 넷스케이프의 브랜든 아이크가 개발(초기명 LiveScript)
- 1997년 ECMA에서 표준화(ECMAScript)
- 최신 표준의 분기점은 **ES6 (ES2015)**
- 구형 브라우저 호환을 위해 Babel 같은 트랜스파일러를 사용한다.

### 1.2. 특징
- **인터프리터 언어**
	- 브라우저가 즉시 해석 및 실행

- **동적 타이핑**
	- 변수 선언 시가 아닌 할당 시 타입 결정
	- (TypeScript는 정적 타이핑 지원)

- **객체 기반**
	- 프로토타입 기반으로 객체가 공유하는 메서드 정의

- **함수형 프로그래밍**
	- 함수를 객체로 취급
	- 화살표 함수(arrow function): 람다식(lamda expression) 지원
	- 콜백 함수(callback function): 함수를 인수로 전달
	- 고계 함수(high-order funcion): 함수를 반환하는 함수

### 1.3. 활용
- HTML/CSS 동적 제어, 이벤트 처리, 서버 통신(AJAX)

- *cf.*
	- 사용자의 요청인 이벤트에 반응하는 동작을 구현할 수 있다.
	- HTML 컨텐츠를 동적으로 생성, 삭제, 변경할 수 있다.
	- HTML 요소(element)의 속성(CSS)들을 동적으로 변경할 수 있다.
	- 사용자 입력 값들을 계산 또는 검증할 수 있다.
	- 게임, 애니메이션과 같은 대화형 컨텐츠를 구현할 수 있다.
	- 웹 서버와의 통신을 구현할 수 있다.

### 1.4. 확장
- *jQuery*
	- 자바스크립트 라이브러리이며 클라이언트 스크립트를 단순화 할 수 있도록 설계
	- 점차적으로 프론트엔드 프레임워크(가상 돔 활용으로 성능 향상)의 등장으로 필요성 저하

- *JSON*(JavaScript Object Notation)
	- 속성-값 쌍으로 이루어진 데이터 오브젝트를 전달하기 위한 개발형 표준 포맷
	- 브라우저/서버 통신(AJAX)을 위해, 넓게는 XML을 대체하는 주요 데이터 포맷

- *React.js, Vue.js, Angular.js*
	- 프론트엔드 프레임워크
	- 현재 가장 인기 있는 반응형 프레임워크

- *Node.js*
	- 백앤드 프레임워크
	- 서버 환경에서 자바스크립트로 애플리케이션을 작성할 수 있게 한다.
```sh
node var.js # 터미널 실행
```

### 1.5. 코드 위치
- **코드 위치**
	- 내부(`script` 태그)
	- 외부(`src` 속성)
	- 인라인(HTML 태그 내 이벤트 속성)

```html
<head>
	<!-- 내부 자바스크립트 -->
	<script>
		// 주석
		/* 주석 */
		document.write("Hello World!");
	</script>
	
	<!-- 외부 자바스크립트 -->
	<script src="myscript.js"></script>
</head>

<body>
	<!-- 인라인 자바스크립트 -->
	<button type="button" onclick="alert('반갑습니다.')">
		버튼을 누르세요!
	</button>
</body>
```

## 2. 변수
### 2.1. 선언과 할당
- **선언 방식**
	- 자료형을 지정하지 않는다.
	- (`let`, `const`, `var`)

- **키워드 비교**
	- **var**: 재선언/재할당 가능. 구형 방식(문제점 존재)
	- **let (ES6)**: 재할당 가능, **재선언 불가능**
	- **const (ES6)**: **재할당/재선언 불가능** (상수)

```js
var value = "홍길동";
value = "강호동"; // 재할당 가능
var value = 2024; // 재선언 가능
```

- **명명 규칙**
	- 문자, `$`, `_`로 시작한다.
	- 숫자로 시작할 수 없다.
	- 대소문자를 구분한다.

### 2.2. 스코프(scope)
- **전역 스코프**(global scope)
	- 함수 외부에 선언되는 전역 변수는 어디서든 접근할 수 있다.
	- 함수를 제외한 영역(if/for/while 등)에서 ==var로 선언한 변수==는 전역 변수로 취급된다.

- **지역/함수 스코프**(local or function scope)
	- 해당 함수 내에서만 접근할 수 있다.

- **블록 레벨 스코프**(block level scope)
	- 해당 변수가 선언된 중괄호 블록에서만 접근할 수 있다.
	- ==let과 const로 선언된 변수==가 해당한다. (단, var로 선언된 변수는 전역 스코프이다.)

- **스코프 체인**(scope chain)
	- 중첩 함수의 경우 내부 함수는 외부 함수의 변수에 접근할 수 있다.

### 2.3. 호이스팅
- 변수는 선언, 초기화, 할당의 과정을 거쳐서 생성된다.

- 변수/함수를 호출하는 코드가 함수 선언보다 위에 있어도 동작하는 기능
	- JavaScript는 코드 실행 전 준비 단계에서 함수를 미리 찾아 생성해 둔다.

### 2.4. 요약
|    선언     | 재선언 | 재할당 | 선언 호이스팅 | 자동 초기화 | Scope |
| :-------: | :-: | :-: | :-----: | :----: | :---: |
|  **var**  |  ⭕  |  ⭕  |    ⭕    |   ⭕    |  함수   |
|  **let**  |  ❌  |  ⭕  |    ⭕    |   ❌    |  블록   |
| **const** |  ❌  |  ❌  |    ⭕    |   ❌    |  블록   |

## 3. 자료형
### 3.1. 기본형
- **기본형** (Primitive Type)
	- 변경 불가능한(Immutable) 값
	- *재할당은 값을 수정하지 않고 변수의 메모리 주소를 바꾼다.*

- *종류*
	- **숫자**(Number): 정수나 실수
		- Infinity: 무한값 (1/0)
		- NaN(Not a Number): 표현할 수 없는 숫자 (e.g. 1*“Hello”)
	- **문자열**(String): `““`(큰따옴표; double quote) 또는 `‘‘`(작은따옴표; single quote)로 표현
		- ES6 **템플릿 리터럴**(Template Literal): 백틱 `` ` `` 사용
	- **불리언**(Boolean): true 또는 false
	- **Null**: 변수를 선언하고 빈 값을 할당한 상태
	- **Undefined**: 변수를 선언하고 값을 할당하지 않은 상태
	- **Symbol**: 변경 불가능한 원시 타입의 값이며 고유한 값, 객체의 프로퍼티 키로 사용

- ==템플릿 문자열의 작성 ==
```js
const a = 5, b = 3;
console.log(`${a} + ${b} = ${a + b}`);
```

### 3.2. 참조형
- **참조형** (Reference Type)
	- 기본형 이외의 모든 값은 참조형이자 객체(object)형이다.
	- 메모리 주소(Heap)를 참조한다.
	- 변경 가능한(Mutable) 값이다.
	- 종류: ==객체(Object), 배열, 함수==

### 3.3. 형변환
- **형변환** (Type Casting)
	- **암시적**: 엔진이 자동으로 변환 (예: 숫자 + 문자열 = 문자열)
	- **명시적**: `String()`, `Number()` 등을 사용해 직접 변환
```js
// 암시적 형변환
console.log("5" * 2);          // 10
console.log(1 + "2");          // "12"

// 명시적 형변환
console.log(Number("123"));    // 123
console.log(String(123));      // "123"
```

### cf. 인자 전달
- **기본형**: 불리언, 숫자, 문자열 등
	- **call by value**: 함수 내 변경 시 원본 영향 ❌

- **참조형**: 객체, 배열, 함수 등
	- **call by reference**: 함수 내 변경 시 원본 영향 ⭕

## 4. 연산자
- **비교 연산자**
	- `==`, `!=`: 값만 비교
	- **`===`, `!==`**: **값과 데이터 타입**을 모두 엄격하게 비교
		- `===`: *타입과 값 일치할 때 참*
		- `!==`: *타입이 다르거나 값이 다르면 참*

- **논리 연산자**
	- `&&` (AND), `||` (OR), `!` (NOT)

- **3항 연산자**
	- `조건 ? 참일때값 : 거짓일때값`

## 5. 입출력
- **입력**
	- `prompt()`: *사용자에게 어떤 사항을 알려주고, 문자열을 입력할 수 있는 창을 표시한다.*
	- `confirm()`: *사용자에게 어떤 사항을 알려주고, 확인/취소를 요구한다. (불리언 반환)*

- **출력**
	- `document.write()`: *페이지 로딩 후 사용 시 내용 덮어쓴다.*
	- `console.log()`: *디버깅용으로 많이 사용하는 함수이다.*
	- `innerHTML`: *HTML 요소의 내용을 변경한다.*

## 6. 조건문
- **if-else**: 조건의 참/거짓에 따라 코드 분기
```js
let time = new Date().getHours();
let msg;
document.getElementById("test1").innerHTML = "time=“ + time;
if (time < 12) {
	msg = "Good Morning";
} else {
	msg = "Good Afternoon";
}
document.getElementById("test2").innerHTML = msg;
```

- **switch**: 특정 값에 따라 케이스(case)를 선택하여 실행
```js
let day = new Date().getDay();
switch (day) {
	case 0:
	case 6:
		day = "주말";
		break;
	case 1:
	case 2:
	case 3:
	case 4:
	case 5:
		day = "주중";
		break;
}
document.getElementById("test").innerHTML = "오늘은 " + day + "입니다";
```

## 7. 반복문
- **while**: 조건이 참인 동안 반복

- **for**: 초기식, 조건식, 증감식을 이용해 정해진 횟수만큼 반복
```js
document.write("<table border=2 width=50%");
for (let i = 1; i <= 9; i++) {
	document.write("<tr>");
	document.write("<td>" + i + "</td>");
	for (let j = 2; j <= 9; j++) {
		document.write("<td>" + i * j + "</td>");
	}
	document.write("</tr>");
}
document.write("</table>");
```

- **제어**: `break` (루프 탈출), `continue` (다음 반복으로 건너뜀)

## 8. 함수
- **정의**
	- 특정 작업을 수행하는 명령어들의 집합
	- 매개변수 타입을 검사하지 않음

- *cf.*
	- 인수가 매개변수보다 적다면 undefined로 설정된다.
	- JavaScript 내장 함수와 사용자 정의 함수로 구분된다. 사용자 정의 함수는 매개변수와 인수 개수/타입을 확인하지 않는다.
	- **익명 함수**(anonymous function): 함수 이름 없이 만들어 한 번만 사용하는 함수

### 8.1. 종류
- **함수 선언식**: `function 이름() {}` - **호이스팅(Hoisting) 됨** (선언 전 호출 가능)
```js
// 함수 선언식: function을 선언하고 함수명을 기재한다.
function name(a) {
	let b = a + 10;
	return b;
}
```

- **함수 표현식**: `var 변수 = function() {}` - 호이스팅 안 됨
```js
// 함수 표현식: 변수를 선언하고 함수를 대입한다.
var func = function[name](a) { // [name] 생략 시 익명 함수
	let b = a + 10;
	return b;
};
```

- **화살표 함수 (ES6)**: `const 이름 = () => {}` - 람다식 표현, 간결함
```js
// 화살표 함수: Java의 람다식(lama expression)과 유사한 함수 (ES6 추가)
const funcAdd = (a, b) => { // 매개변수가 한 개인 경우, 소괄호 생략 가능
	return a + b; // 한 행으로 반환하는 경우, return 생략 가능
}; // 또는 const funcAdd = (a, b) => a + b;로 return 생략
```

### 8.2. 주요 개념
- **콜백 함수**
	- 다른 함수의 인자로 전달되어 나중에 호출되는 함수

- **스코프 (Scope)**
	- 변수의 접근 가능 범위. `var`는 함수 스코프, `let/const`는 블록 스코프

- **호이스팅 (Hoisting)**
	- 변수 및 함수 선언이 해당 스코프의 최상단으로 끌어올려진 것처럼 동작하는 현상
	- `var`는 `undefined`로 초기화됨
	- `let`, `const`는 호이스팅은 되지만 초기화 전 접근 시 에러 발생(TDZ)

- **내장 함수**
	- `eval()`, `parseInt()`, `setTimeout()` 등

### 8.3. 요약
|     구분     | 세미콜론 | 익명  | 호이스팅 |                 예시                  |
| :--------: | :--: | :-: | :--: | :---------------------------------: |
| **함수 선언식** |  ❌   |  ❌  |  ⭕   |       `function func(a) { }`        |
| **함수 표현식** |  ⭕   |  ⭕  |  ❌   | `var func = function[func](a) { };` |
| **화살표 함수** |  ⭕   |  ⭕  |  ❌   |   `const func = (a, b) => a + b;`   |
