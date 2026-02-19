---
draft: false
tags:
  - 2-2/프론트엔드프로그래밍
date: 2025-10-01
---
## 1. 자바스크립트 객체 (Objects)
> 현실 세계의 사물처럼 **데이터**(속성, Property)와 **동작**(메서드, Method)을 하나로 묶은 단위이다.

### 1.1. 종류
- **내장 객체 (Built-in)**
	- 기본 내장(Standard Bulit-in): JS 엔진에 포함된 객체
		- Date, String, Array, Object, Number, Boolean, Json, Math, Reflect
	- 브라우저 객체
		- **DOM**(Document Object Model): 브라우저가 HTML 문서를 파싱하여 요소들을 객체 트리로 정의
		- **BOM**(Browser Object Model): 브라우저 관련 정보 제공

- **사용자 정의 객체 (Custom)**
	- 개발자가 직접 정의한 객체

### 1.2. 객체 생성 방법 (4가지)
1. **객체 리터럴 `{}`**
	- 가장 많이 사용
	- 하나만 생성(싱글톤)할 때 유용

2. **Object 생성자 `new Object()`**
	- 빈 객체 생성 후 속성 추가
	- (리터럴 방식을 더 권장)

3. **생성자 함수**
	- `function` 키워드 사용
	- `new` 연산자로 여러 객체(인스턴스) 생성 가능
	- `this`를 통해 속성 할당

4. **Class (ES6)**
	- `class` 키워드 사용
	- Java나 Python과 유사한 문법 제공

#### (1) 싱글톤 객체
```js
// 객체 리터럴 (권장)
const person1 = {
  name: "Alice",
  sayHello: function() {
    console.log(`Hello, I'm ${this.name}!`);
  }
};

// new Object() (JS 엔진)
const person2 = new Object();
person2.name = "Bob";
person2.sayHello = function() {
  console.log(`Hello, I'm ${this.name}!`);
};
```

#### (2) 여러 객체
```js
// 생성자 함수로 객체 정의
function Person(name) {
  this.name = name;
  this.sayHello = function() {
    console.log(`Hello, I'm ${this.name}!`);
  };
}
const person3 = new Person("Charlie");

// class 키워드로 클래스 정의 (ES6~)
class PersonClass {
  constructor(name) {
    this.name = name;
  }
  sayHello() {
    console.log(`Hello, I'm ${this.name}!`);
  }
}
const person4 = new PersonClass("Diana");
```

### 1.3. 속성 접근 및 관리
- **접근**
	- 점 표기법(`obj.key`) 또는 괄호 표기법(`obj['key']`)
	- (키에 공백이 있거나 변수로 접근 시 괄호 표기법 사용)

- **추가/삭제**
	- 값을 할당하여 추가
	- `delete` 키워드로 삭제

- **탐색**
	- `in` 연산자로 키 존재 여부 확인
	- `for...in` 루프로 모든 속성 순회

## 2. 객체 상속 (Inheritance)
### 2.1. 프로토타입(Prototype) 기반 상속
- 자바스크립트의 모든 객체는 숨겨진 `prototype` 속성을 가진다.
- **프로토타입 체인**: 특정 속성/메서드를 찾을 때 현재 객체에 없으면 상위 프로토타입 링크(`__proto__`)를 따라 부모 객체를 검색하는 메커니즘
- 생성자 함수의 `prototype` 객체를 통해 상속을 구현한다.

```js
function Vehicle(make, model) {
	this.make = make;
	this.model = model;
}
Vehicle.prototype.getDetails = function() {
	return `${this.make} ${this.model}`;
};
Vehicle.prototype.drive = function() {
	return `${this.make} ${this.model}, drive()`;
}
function Car(make, model, doors) {
	Vehicle.call(this, make, model);
	this.doors = doors;
}
Car.prototype = Object.create(Vehicle.prototype);
Car.prototype.constructor = Car;
Car.prototype.getDetails = function() {
	return `${this.make} ${this.model}, ${this.doors} doors`;
};
const car = new Car('Benz', 'E300', 4); console.log(car.getDetails());
console.log(car.drive());
```

- ==프로토타입 상속==
	- JS는 다른 객체를 프로토타입으로 삼아 그 객체의 속성/메서드에 접근할 수 있는 식으로 상속한다.

- ==프로토타입 체인==
	- JS는 객체의 속성/메서드를 찾을 때 먼저 객체 자신에게서 찾고,
	- 없으면 그 객체의 프로토타입에서 찾는다.
	- 그래도 없으면 그 프로토타입의 프로토타입에서 찾는 식이다.

- *cf.*
	- 상속이 실제로는 프로토타입을 공유하며, 따라서 공간이 절약된다.

### 2.2. 클래스(Class) 상속 (ES6)
- `extends` 키워드를 사용하여 상속 구현
- `super()`로 부모 생성자 호출
- **오버라이딩(Overriding)**: 부모의 메서드를 자식 클래스에서 재정의하여 사용 가능

```js
class Vehicle {
	constructor(make, model) {
		this.make = make;
		this.model = model;
	} // 메서드는 Box.prototype에 생성
	getDetails() {
		return `${this.make} ${this.model}`;
	}
	drive() {
		return `${this.make} ${this.model}, drive()`;
	}
} 

class Car extends Vehicle {
	constructor(make, model, doors) {
		super(make, model); // 상위 클래스 생성자
		this.doors = doors;
	}
	getDetails() { // 메서드 오버라이딩
		return `${this.make} ${this.model}, ${this.doors} doors`;
	}
}
const car = new Car('Benz', 'E300', 4); console.log(car.getDetails());
console.log(car.drive()); 
```

## 3. 자바스크립트 배열 (Arrays)
### 3.1. 배열의 특징
- **해시 테이블**(Hash Table)로 구현된 객체이다.
	- (인덱스 접근은 일반 배열보다 느릴 수 있으나, 삽입/삭제/탐색 성능은 우수)

- **희소 배열**
	- 요소가 연속적이지 않을 수 있으며, 비어있는 인덱스는 `undefined` 값을 가진다.

- 하나의 배열에 **여러 가지 자료형(숫자, 문자, 객체 등)을 혼합**하여 저장할 수 있다.

- 크기가 동적으로 조절된다.
	- *현재 배열의 크기보다 큰 인덱스를 사용할 수 있다. 이 때 배열의 크기가 늘어나며, 인덱스에 대응하는 요소가 없는 부분인 홀(hole)이 생기면 undefined처럼 보인다.*

### 3.2. 생성 및 주요 메서드
- ==생성==: 배열 리터럴 `[]` 또는 `new Array()`
```js
// 배열 리터럴
let fruits = ["apple", "banana", "cherry"];

// Array 객체
let fruits = new Array();
myArray[0] = "apple";
myArray[1] = "banana";
myArray[2] = "cherry";

let fruits = new Array("apple", "banana", "cherry");
```

- **조작 메서드**
	- `push()`, `pop()`: 배열 끝에 추가/제거
	- `shift()`, `unshift()`: 배열 앞 요소 제거/추가
	- `splice()`, `slice()`: 배열 자르기 또는 부분 반환
	- `concat()`: 배열 합치기
	- `join()`: 배열을 문자열로 결합

- **고차 함수 (콜백 함수 사용)**
	- **`filter()`**: 조건(return true)을 만족하는 요소만 모아 새로운 배열 반환
	- **`map()`**: ==모든 요소를 함수로 변환하여 새로운 배열 반환==
	- 내부적으로 순회하며 처리하므로 `for`문 없이 데이터 처리가 가능하다.

### 3.3. 다차원 배열
- 배열 안에 배열을 포함하여 2차원, 3차원 배열 생성 가능
```js
let multiArray = [];
for(let i = 0; i < 3; i++) {
	multiArray[i] = [];
	for(let j = 0; j < 3; j++) {
		multiArray[i][j] = i + j;
	}
}
console.log(multiArray) // [ [ 0, 1, 2 ], [ 1, 2, 3 ], [ 2, 3, 4 ] ]

multiArray[1].push(7);
console.log(multiArray); // [ [ 0, 1, 2 ], [ 1, 2, 3, 7 ], [ 2, 3, 4 ] ]

multiArray.pop();
console.log(multiArray); // [ [ 0, 1, 2 ], [ 1, 2, 3, 7 ] ]

multiArray[1].shift();
console.log(multiArray); // [ [ 0, 1, 2 ], [ 2, 3, 7 ] ]
```

## 4. 주요 문법 및 동작 원리
### 4.1. 분할 대입 (Destructuring Assignment)
- ==객체나 배열에서 값을 간편하게 추출하여 변수에 할당하는 문법==
	- **객체**: `let { id, name } = student;` (키 이름과 일치해야 함)
	- **배열**: `let [ id, name ] = student;` (순서대로 할당)

```js
// 객체 분할 대입
const user = {name: "Alice", age: 25};
const {name, age} = user;
console.log(`name: ${name}, age: ${age}`);

// 배열 분할 대입
const arr = [1, 2, 3];
const [a, b, c] = arr;
console.log(`a: ${a}, b: ${b}, c: ${c}`);
```

### 4.2. 인자 전달 방식
- **Call by Value (기본형)**
	- 숫자, 문자열 등은 값이 복사되어 전달
	- (원본 영향 없음)

- **Call by Reference (참조형)**
	- 객체, 배열 등은 **주소 값**이 전달됨
	- 함수 내에서 변경 시 **원본 객체도 변경**됨

```js
const swap = (a, b) => { let tmp = a; a = b; b = tmp; };
let x = 5;
let y = 100;
swap(x, y);
console.log(x, y); // 5, 100

let func = function(b) { b = b + 10; }
x = 20;
func(x);
console.log(x); // 20

let funcA = function(b) { b.a = 5; };
x = {a: 1};
funcA(x);
console.log(x); // { a: 5 }

let funcB = (b) => { b = b.a = 5; b.b = 7; };
y = {c: 9};
funcB(y);
console.log(y); // { c: 9, a: 5 }
```

## 5. 주요 내장 객체
### 5.1. Date 객체
- 날짜와 시간을 저장 및 관리
- `new Date()`로 생성
- `getFullYear()`, `getMonth()`, `getTime()` 등으로 정보 추출 및 설정

### 5.2. String 객체
- 문자열 처리를 위한 객체
- `length`, `charAt()`, `indexOf()`, `split()`, `slice()`, `trim()` 등의 메서드 제공

### 5.3. Math 객체
- 수학 연산을 위한 속성과 메서드 제공
- `new`로 생성하지 않고 **정적(Static)으로 사용** (예: `Math.PI`, `Math.random()`, `Math.round()`)

## 6. 예외 처리 (Exception Handling)
- **목적**
	- 프로그램 실행 중 발생하는 런타임 오류(예외)를 처리하여 프로그램이 비정상 종료되는 것을 방지

- **구조**
	- `try { ... }`: 예외가 발생할 가능성이 있는 코드
	- `catch (e) { ... }`: 예외 발생 시 실행될 코드 (에러 처리)
	- `finally { ... }`: 예외 발생 여부와 상관없이 무조건 실행되는 코드
```js
try {
	// 예외를 처리하길 원하는 실행 코드;
	if (/* 조건 */) throw "예외 내용";
} catch (ex) {
	// 예외가 발생할 경우에 실행될 코드;
} finally {
	// try 블록이 종료되면 무조건 실행될 코드;
} 
```

- **Throw**: 개발자가 의도적으로 예외를 발생시킬 때 사용 (`throw "에러 메시지"`)
```js
const sum = (x, y) => {
	if (typeof x !== 'number' || typeof y !== 'number') {
		throw "숫자를 입력하세요"
	}
	return x + y;
};

try {
	sum("50", 10)
} catch (e) {
	console.log(e); // 숫자를 입력하세요
}
```