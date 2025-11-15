---
draft: false
tags:
  - 2-2/프론트엔드프로그래밍
date: 2025-10-29
---
## 1. 이벤트
- **이벤트**(Event)
	- 웹 페이지에서 사용자의 행동(마우스 클릭, 키보드 입력 등)이나 브라우저의 상태 변화에 따라 발생하는 사건

- **이벤트 처리 절차**
	1.  **이벤트 선정**: 반응할 이벤트를 결정한다. (예: `click`, `mouseover`)
	2.  **이벤트 핸들러 작성**: 이벤트 발생 시 실행될 코드를 함수(이벤트 리스너)로 작성한다.
	3.  **이벤트 핸들러 등록**: 특정 HTML 요소에 작성된 이벤트 핸들러를 연결한다.

- **이벤트 리스너 작성 방법**
	- **인라인 방식**: HTML 태그 내에 `onmouseover`와 같은 속성으로 직접 코드를 작성한다.
	- **속성 대입**: 자바스크립트에서 DOM 객체의 이벤트 속성에 함수를 직접 할당한다.
	- `addEventListener()`: 표준 방식으로, 하나의 요소에 여러 이벤트 리스너를 등록할 수 있다. `removeEventListener()`로 제거도 가능하다.

- **이벤트 전파 방식**
	- **버블링**(Bubbling): 안쪽 요소에서 발생한 이벤트가 바깥쪽 부모 요소로 전파 (기본값)
	- **캡처링**(Capturing): 바깥쪽 요소에서 안쪽 요소 순서로 이벤트가 전파

### 1.1. 실습
```js
function changeColor() {
	document.getElementById("target").style.backgroundColor='blue’;
}
document.getElementById("target").onmouseover = changeColor;

//

let obj = document.getElementById("target");
obj.addEventListener("mouseover", changeColor);
```

```html
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>키 이벤트</title>
	<style>
		td { width:50px; height:50px; border:1px solid darkgray; }
	</style>
</head>
<body onload = paintCell() >
	<h3>상하좌우 키로 셀 이동하기</h3><hr>
	<table>
		<tr><td></td><td></td><td></td><td></td><td></td></tr>
		<tr><td></td><td></td><td></td><td></td><td></td></tr>
		<tr><td></td><td></td><td></td><td></td><td></td></tr>
		<tr><td></td><td></td><td></td><td></td><td></td></tr>
		<tr><td></td><td></td><td></td><td></td><td></td></tr>
	</table>
	<script>
		let tds;
		let prevIndex=0, index=0;
		function paintCell() {
			tds = document.getElementsByTagName("td");
			tds[index].style.backgroundColor = "orchid";
		}
		window.onkeydown = function (e) {
			switch(e.key) {
				case "ArrowDown" :
					if(index/5 >= 4) return; // 맨 위 셀의 경우
					index += 5;
					break;
				case "ArrowUp" :
					if(index/5 < 1) return; // 맨 아래 셀의 경우
					index -= 5;
					break;
				case "ArrowLeft" :
					if(index%5 == 0) return; // 맨 왼쪽 셀의 경우
					index--;
					break;
				case "ArrowRight" :
					if(index%5 == 4) return; // 맨 오른쪽 셀의 경우
					index++;
					break;
			}
			tds[index].style.backgroundColor = "orchid";
			tds[prevIndex].style.backgroundColor = "white";
			prevIndex = index;
		}
	</script>
</body>
</html>
```

## 2. 마우스 관련 이벤트
- 사용자의 마우스 조작과 관련된 다양한 이벤트
	- `click`: 마우스 버튼을 클릭했을 때 발생
	- `mouseover`: 마우스 커서가 요소 위로 올라왔을 때 발생
	- `mouseout`: 마우스 커서가 요소를 벗어났을 때 발생
	- `mousedown`: 마우스 버튼을 누르는 순간 발생
	- `mouseup`: 눌렀던 마우스 버튼을 떼는 순간 발생

```html
<h1 onclick=“change()”> 이것은 클릭 가능한 헤딩입니다. </h1>
```

### 2.1. 실습
```html
<html>
<head>
	<script>
		function cal() {
			let answer = document.getElementById('answer').value;
			let s = document.getElementById("problem").value;
			let solution = eval(s);
			if (answer == solution) {
				alert("정답!");
			} else {
				alert("틀렸습니다! 정답은"+solution);
			}
		}
	</script>
</head>
<body>
	<h1>Math Quiz</h1>
	<input type="text" id="problem" value="12*2+20-30"><br>
	<input type="text" id="answer">
	<button onclick="cal()">정답 알아보기</button>
</body>
```

## 3. 문서 로딩 관련 이벤트
- 웹 페이지의 로딩 상태와 관련된 이벤트
	- `load`: 웹 페이지의 모든 콘텐츠(이미지, 스크립트 등)가 완전히 로드되었을 때 발생
	- `unload`: 사용자가 현재 웹 페이지를 떠날 때 발생

## 4. 입력 값의 유효성 검증
- 사용자가 입력한 데이터가 유효한지 서버로 전송하기 전에 클라이언트 측에서 미리 검사하는 과정
- 불필요한 서버 요청을 줄이고 사용자 경험을 향상
- 공백, 데이터 길이, 형식 등을 검증

## 5. 정규식
- **정규식**(Regular Expression)
	- 특정한 규칙을 가진 문자열의 집합을 표현하는 데 사용되는 형식 언어
	- 입력값의 유효성 검증, 특히 복잡한 패턴(이메일, 전화번호 등)을 검사할 때 유용

- **주요 메타문자**
	- `^`: 문자열 시작
	- `$`: 문자열 끝
	- `[0-9]`: 0부터 9까지의 숫자 중 하나
	- `+`: 1회 이상 반복

## 6. 브라우저 객체 모델
- **브라우저 객체 모델**(BOM: Browser Object Model)
	- 웹 브라우저의 창이나 프레임을 객체처럼 다룰 수 있게 하는 모델

- **주요 객체**
	- `window`
		- BOM의 최상위 객체로, 브라우저 창 자체를 나타낸다.
		- `open()`, `setTimeout()`, `setInterval()` 등의 메서드를 제공한다.
	- `location`
		- 현재 페이지의 URL 정보를 담고 있으며, 페이지를 이동시킬 수 있다.
		- `href`, `reload()`, `replace()`
	- `navigator`
		- 브라우저의 종류, 버전, 운영체제 등의 정보를 제공한다.
	- `history`
		- 사용자의 방문 기록을 제어한다.
		- `back()`, `forward()`, `go()`
	- **`screen`
		- 사용자의 화면 해상도, 색상 깊이 등 디스플레이 정보를 제공합니다.

## 7. 비동기 처리
- **비동기 처리**
	- 서버와 데이터를 교환할 때 페이지 전체를 새로고침하지 않고 일부 데이터만 업데이트하는 방식
	- 더 빠르고 부드러운 사용자 경험을 제공

- **주요 비동기 통신 방식**
	- XMLHttpRequest 객체
	- Promise 객체
	- fetch() 메서드
	- async/await 문법

---

- **XMLHttpRequest 객체**
	- 전통적인 비동기 통신 방식
	- XML 데이터를 주로 사용했지만 현재는 JSON도 널리 사용

- **Promise 객체**
	- 비동기 처리 상태와 처리 결과(성공/실패)를 관리하는 객체
	- 콜백 함수의 문제점인 콜백 헬(가독성, 제어 처리 시점, 에러 처리 한계)을 해결
	- new Promise(), resolve(), then() 구조
	
	- **Promise의 상태**(states)
		- **대기**(pending): 비동기 처리 로직이 아직 완료되지 않은 상태
		- **이행**(fulfilled): 비동기 처리가 완료되어 Promise가 결과 값을 반환해준 상태
		- **실패**(rejected): 비동기 처리가 실패하거나 오류가 발생한 상태

- **fetch() 메서드**
	- 브라우저 전용 API로 개발된 웹 표준
	- Promise 타입의 객체를 반환한다.
	- XMLHttpRequest 객체의 이벤트 기반 콜백 함수보다 적용하기 쉽다.

- **async/await 문법**
	- Promise를 동기 코드처럼 작성해 가독성을 높인 문법
	- function 키워드 앞에 async 키워드를, 비동기로 처리되는 부분 앞에 await 키워드를 선언한다.
	- async 함수 내에서 await 키워드를 사용하여 비동기 작업이 완료될 때까지 기다린다.

---

- **JSON**(JavaScript Object Notation)
	- 서버와 클라이언트 간 데이터 교환에 널리 사용되는 경량의 텍스트 기반 데이터 형식
	- 키-값 쌍으로 구성되어 가독성이 높고 자바스크립트에서 다루기 쉽다.

### 7.1. XMLHttpRequest 객체
```html
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Ajax</title>
	<script>
	function sendRequest(){
		const xhr = new XMLHttpRequest();
		xhr.open("GET","http://0.0.0.0:8080/frontend/RestController?cmd=list");
		xhr.send();
		xhr.onload = function(){
			if(xhr.status === 200){
				alert("success-성공");
				console.log(xhr.responseText);
				let div = document.getElementById("target");
				let table = document.createElement("table");
				table.border = 1;
				table.width = "100%";
				const data = JSON.parse(xhr.responseText);
				for (let i in data) {
					let row = document.createElement("tr");
					let idCell = document.createElement("td");
					let passwdCell = document.createElement("td");
					let usernameCell = document.createElement("td");
					let snumCell = document.createElement("td");
					let departCell = document.createElement("td");
					let mobileCell = document.createElement("td");
					let emailCell = document.createElement("td");
					
					idCell.innerText = data[i].id;
					passwdCell.innerText = data[i].passwd;
					usernameCell.innerText = data[i].username;
					snumCell.innerText = data[i].snum;
					departCell.innerText = data[i].depart;
					mobileCell.innerText = data[i].mobile;
					emailCell.innerText = data[i].email;
					
					row.appendChild(idCell);
					row.appendChild(passwdCell);
					row.appendChild(usernameCell); 
					row.appendChild(snumCell);
					row.appendChild(departCell);
					row.appendChild(mobileCell);
					row.appendChild(emailCell);
					table.appendChild(row);
				}
				div.appendChild(table);
			} else {
				alert("failure");
				console.log(xhr.statusText);
			}
		}
	}
	</script>
</head>
<body>
	<button id="request" onClick="sendRequest()">request-xmlhttprequest</button>
	<div id="target"></div>
</body>
</html>
```

### 7.2. Promise 객체
```html
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Ajax</title>
	<script>
	function sendRequest( ){
		return new Promise((resolve, reject) => {
			const xhr = new XMLHttpRequest();
			xhr.open("GET", "http://0.0.0.0:8080/frontend/RestController?cmd=list");
			xhr.send();
			xhr.onload = function() {
				if(xhr.status === 200){ //
					alert("success-성공");
					resolve(xhr.response);
				} else {
					alert("failure-실패");
					reject(xhr.statusText);
				}
			};
		});
	}
	function doRequest() {
		sendRequest() .then(data => {
			console.log('성공:', data);
		})
		.catch(error => {
			console.error('실패:', error);
		});
	}
	</script>
</head>
<body>
	<button id="request" onClick="doRequest()">request-promise</button>
	<div id="target"></div>
</body>
</html>
```

### 7.3. fetch() 메서드
```html
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Ajax</title>
	<script>
	function sendRequest(){
		fetch("http://0.0.0.0:8080/frontend/RestController?cmd=list")
		.then(response => {
			if(response.ok) { //
				alert("success-성공");
				return response.json();
			} else {
				alert("failure-실패");
				throw new Error(`오류 발생: ${response.status}`);
			}
		})
		.then(data => {
			console.log(data);
			//
		})
	}
	</script>
</head>
<body>
	<button id="request" onClick="sendRequest()">request-fetchapi</button>
	<div id="target"></div>
</body>
</html>
```

### 7.4. async/await 문법
```html
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Ajax</title>
	<script>
	async function sendRequest() { //
		try {
			const response = await fetch("http://0.0.0.0:8080/frontend/RestController?cmd=list")
			const data = await response.json();
			alert("success-성공");
			console.log(data);
		} catch (err) {
			alert("failure-실패");
			console.log(err);
		}
	}
	</script>
</head>
<body>
	<button id="request" onClick="sendRequest()">request-async-await</button>
	<div id="target"></div>
</body>
</html>
```