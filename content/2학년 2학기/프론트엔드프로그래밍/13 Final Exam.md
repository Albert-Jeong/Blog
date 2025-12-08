---
draft: false
tags:
  - 2-2/프론트엔드프로그래밍
date: 2025-12-11
---
## 07 이벤트 BOM 통신
- [[07 이벤트 BOM 통신#1.1. 이벤트 리스너 작성 방법|이벤트 리스너 작성 방법]]
	- 인라인, 속성 대입, `addEventListener("event", listener)`
```html
<!-- HTML 요소 인라인 -->
<div onmouseover="this.style.backgroundColor='blue'">Hello World!</div>

<!-- 객체의 이벤트 리스너 속성에 함수를 대입 -->
<div id="target">Hello World!</div>
<script>
	function changeColor() {
		document.getElementById("target").style.backgroundColor="blue";
	}
	document.getElementById("special").onmouseover = changeColor;
</script>

<!-- 객체의 addEventListener() 함수를 사용 -->
<script>
	let obj = document.getElementById("target");
	obj.addEventListener("mouseover", changeColor);
	
	// 또는 익명 함수로 이벤트 리스너 작성
	obj.addEventListener("mouseover", function() {
		document.getElementById("target").style.backgroundColor="blue";
	});
</script>
```

- **이벤트 전파 방식**
	- **버블링**(bubbling): 안쪽 요소의 이벤트 처리 → 바깥쪽 요소의 이벤트 처리 (기본값)
	- **캡처링**(capturing): 바깥쪽 요소의 이벤트 처리 → 안쪽 요소의 이벤트 처리

- **웹 페이지의 로딩 상태와 관련된 이벤트**
	- `"load"` 이벤트: HTML 문서가 완전히 로드되었을 때 발생하는 이벤트
	- `"unload"` 이벤트: 사용자가 웹 페이지를 떠날 때 발생하는 이벤트

- **브라우저 객체 모델**(BOM; Browser Object Model)
	- 웹 브라우저의 기능을 객체처럼 다루는 모델
	- `window` 객체
		- BOM의 최상위 객체로, 브라우저 창 자체를 나타낸다.
		- `open()`, `setTimeout()`, `setInterval()` 등의 메서드를 제공한다.
	- `navigator` 객체: 브라우저의 정보를 제공한다. (종류, 버전 등)
	- `screen` 객체: 사용자 화면의 정보를 제공한다. (해상도 등)
	- `location` 객체: 브라우저의 URL과 관련된 객체이다.
	- `history` 객체: 브라우저의 방문 기록을 제어한다. (`back()`, `forward()`, `go()`)

- **비동기 통신 방식**
	- [[07 이벤트 BOM 통신#7.1. XMLHttpRequest 객체|XMLHttpRequest 객체]]: XML 데이터를 서버로부터 전송받아 처리하는 객체
	- [[07 이벤트 BOM 통신#7.2. Promise 객체|Promise 객체]]: 비동기 처리 상태(대기/이행/실패)를 관리하는 객체
	- [[07 이벤트 BOM 통신#7.3. fetch() 메서드|fetch() 메서드]]: Promise 객체를 반환하는 메서드
	- [[07 이벤트 BOM 통신#7.4. async await 문법|async await 문법]]: Promise를 동기 코드처럼 작성하는 문법

```js
fetch(url)
  .then(response => {
    return response.json();
  })
  .then(data => {
    console.log(data);
  });

//

async function fetchData(url) {
  try {
    const response = await fetch(url);
    const data = await response.json(); 
    return data;
  } catch (error) {
    console.error(error);
  }
}
```

## 08 jQuery & AJAX
- [[08 jQuery & AJAX#9. JavaScript to jQuery|JavaScript to jQuery]]
	- **DOM 로딩 완료 후 실행**: `$(document).ready(function() {});`

| 구분               | Vanilla JavaScript                           | jQuery                   |
| :--------------- | :------------------------------------------- | :----------------------- |
| **ID로 선택**       | `document.getElementById("target")`          | `$("#target")`           |
| **태그 이름으로 선택**   | `document.getElementsByTagName("p")`         | `$("p")`                 |
| **특정 태그 선택**     | `document.getElementsByTagName("p")[0]`      | `$("p").eq(0)`           |
| **CSS 선택자로 선택**  | `document.querySelector("p")`                | `$("p")`                 |
| **클래스 이름으로 선택**  | `document.getElementsByClassName("myClass")` | `$(".myClass")`          |
| **Name 속성으로 선택** | `document.getElementsByName("firstForm")`    | `($("[name=firstForm]")` |

- **CORS**(Cross-Origin Resource Sharing)
	- 다른 출처의 자원에 접근할 수 있는 권한을 부여하도록 브라우저에 알려주는 체제

## 09 Node.js
- **NPM**(Node Package Manager)
	- Node.js 패키지 관리자
	
	- `npm init` 명령어 (또는 `npm create`)
		- Node.js 프로젝트를 초기화하는 명령어
		- 프로젝트의 메타데이터를 입력받아 `package.json` 파일을 생성한다.
		
		- `package.json` 파일
			- 프로젝트의 메타데이터 (이름, 버전 등)
			- 패키지 의존성 (`npm install` 명령어로 설치)
			- 스크립트 실행 방법 (`npm run start` 등)

- **CJS**(CommonJS)
	- Node.js의 모듈 시스템
	- `require`와 `module.exports` 문장을 사용한다.
	
- **ESM**(ECMAScript Modules)
	- 최신 프레임워크의 모듈 시스템
	- `import`와 `export` 문장을 사용한다.
	- `import { 변수/함수명, ... } from "파일경로"`, `export default` 등

## 10 React Basics
- **React 특징**
	- **JSX**
		- 자바스크립트의 확장 문법
		- HTML 코드를 자바스크립트 내부에 작성할 수 있다.
	- **컴포넌트**
		- 사용자 인터페이스(UI)를 독립적이고 재사용 가능한 단위로 나누어 관리하는 개념
	- **가상 DOM**
		- 실제 브라우저 DOM의 복사본을 메모리에 저장해 둔 것

```jsx
// 함수형 컴포넌트
function Welcome(props) {
	return <h1>Hello, {props.name}</h1>;
}
export default Welcome;

// 클래스형 컴포넌트
import React from 'react';

class Welcome extends React.Component {
	render() {
		return <h1>Hello, {this.props.name}</h1>;
	}
}

export default Welcome;
```

## 11 React Hook & Event
- **컴포넌트 생명주기**(component lifecycle)
	1. **생성**(mount): 컴포넌트가 생성되어 DOM에 삽입되는 단계
	2. **갱신**(update): 컴포넌트의 `props`나 `state`가 변경되어 리렌더링이 발생하는 단계
	3. **제거**(unmount): 컴포넌트가 DOM에서 제거되는 단계

```jsx
// useState();
const [state, setState] = useState(초기값);

// useEffect();
useEffect(() => {}); // 렌더링마다 실행
useEffect(() => {}, []); // 최초 마운트 시 실행
useEffect(() => {}, [dependency]); // 최초 마운트 및 의존성 변수 값이 변경될 때 실행
useEffect(() => {return () => {};}, []); // 언마운트 시 실행
```
- `useRef();`: DOM 요소에 직접 접근하기 위해 사용하는 훅

- **이벤트 핸들링**
	- **표기법**: HTML과 달리 리액트에서는 카멜 표기법(camelCase)을 사용
		- (예: `onclick` → `onClick`)
	- **전달 방식**: 함수 호출 구문이 아닌 **함수 그 자체**를 전달
		- (예: `onClick={handleClick}`)
- **주요 메서드**
	- `event.preventDefault()`: 폼 제출 시 페이지 새로고침 같은 브라우저 고유 동작을 막는다.
	- `event.stopPropagation()`: 이벤트가 상위 엘리먼트로 전파되는 것을 막는다.

## 12 React Router & TypeScript
- **설정 컴포넌트**
	- `<BrowserRouter>`: 라우터를 적용할 최상위 컴포넌트
	- `<Routes>`: `<Route>`들의 상위 엘리먼트
	- `<Route path="경로" element={<컴포넌트 />} />`: URL 경로와 보여줄 컴포넌트 매핑
	- `<Link to="경로">`: 페이지를 새로고침 하지 않고 이동하는 링크 컴포넌트
- **URL 파라미터**
	- `path="/post/:id"`와 같이 설정
	- `useParams()` 훅을 사용하여 파라미터 값(`{id: 값}`)을 읽어옴
- **쿼리 스트링**
	- `?id=7`과 같은 형태
	- `useSearchParams()` 훅을 사용하여 값을 조회 (`params.get('key')`)

- **AXIOS**: Promise 기반의 HTTP 비동기 통신 라이브러리
    - 응답 데이터를 자동으로 JSON 객체로 파싱한다.
    - `npm install axios`로 설치한다.

- **TypeScript**
	- `Tuple`: 고정된 수의 요소를 가지며, 각 요소의 타입이 정해져 있는 배열
	- `unknown`: 모든 값 할당 가능하나, 다른 타입 변수에 할당 불가 (안전한 any)
	- `void`: 주로 함수의 반환 값이 없을 때 사용
	- `never`: 절대 발생할 수 없는 타입 (무한 루프 등)
```ts
type ID = number | string; // Type Alias & Union
let user_id: ID = 123;
user_id = "abc-456";

interface Person {
  name: string;
}

interface Employee {
  salary: number;
}

type FullTimeEmployee = Person & Employee; // Intersection

const jun: FullTimeEmployee = {
  name: "Jun",
  salary: 5000,
};
```
- **tsconfig.json**