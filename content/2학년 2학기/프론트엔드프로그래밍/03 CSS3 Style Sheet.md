---
draft: false
tags:
  - 2-2/프론트엔드프로그래밍
date: 2025-09-17
---
## 1. CSS 개요
- **정의**
	- CSS(Cascading Style Sheets)는 HTML 문서의 스타일(디자인, 레이아웃 등)을 지정하는 표준 언어이다.
	- *W3C 웹 컨소시엄 개발, XML 문서에도 적용 *

- **목적**
	- 문서의 **구조**(HTML)와 **표현**(CSS)을 분리하여 유지보수성과 효율성을 높인다.

- **문법**
	- `선택자 { 속성: 값; }` 형태 (예: `p { color: red; }`). 반드시 끝에 세미콜론(`;`)을 사용한다.

- **주석**
	- `/* ... */`

## 2. 선택자 (Selector)
> 스타일을 적용할 HTML 요소를 선택하는 방법이다.

- **기본 선택자**
	- **타입 선택자**: 태그 이름 사용 (예: `p`)
	- **전체 선택자**: 모든 요소 선택 (`*`)
	- **아이디(ID) 선택자**: 특정 고유 요소 선택 (`#id`), 문서 내 유일해야 함
	- **클래스(Class) 선택자**: 스타일 그룹화, 여러 요소에 적용 가능 (`.class`)
```css
*			/* 전체 선택자 */
태그		/* 태그 선택자 (타입 선택자) */
.class		/* 클래스 선택자 */
#id			/* 아이디 선택자 */
```

- **선택자 그룹**
	- 콤마(`,`)로 구분하여 여러 선택자에 동일 스타일 적용 (예: `h1, p`)
```css
h1, h2, h3	/* 그룹 선택자 */
```

- **결합자 (Combinators)**
	- **하위(자손) 선택자**: 공백 사용, 내부의 모든 해당 요소 (예: `body em`)
	- **자식(직계) 선택자**: `>` 사용, 바로 아래 단계의 자식 요소만 선택 (예: `body > h1`)
```css
div p		/* 자손 선택자 */
div > p		/* 자식 선택자 */
```

- **의사 클래스 (Pseudo-class)**
	- 요소의 특정 상태를 선택
	- (`:link`, `:visited`, `:hover`, `:active`, `:before` 등)

## 3. CSS 선언 및 적용 방법
- **적용 방식 (3가지)**
	1. **외부 스타일 시트 (External)**: `.css` 파일로 분리하여 `<link>` 태그로 연결 (권장, 재사용성 높음)
	2. **내부 스타일 시트 (Internal)**: HTML `<head>` 내 `<style>` 태그에 작성
	3. **인라인 스타일 (Inline)**: 태그 내 `style` 속성에 직접 작성

- **우선순위**: 인라인 > 내부 > 외부 순서로 적용된다

- **상속**: 부모 요소의 스타일(예: 색상, 폰트)은 자식 요소에게 상속된다.

## 4. CSS 주요 속성
- **색상**: 이름(red), 16진수(#FF0000), RGB(rgb(255,0,0)), % 등으로 표현

- **폰트**
	- 단위: `pt`, `px`, `%`, `em`(부모 기준 배수, 권장), 키워드 등
	- 속성: `font-family`(글꼴), `font-size`(크기), `font-weight`(굵기), `font-style`(이탤릭 등)

- **텍스트**: `text-align`(정렬), `text-decoration`(장식), `line-height`(줄 간격), `text-shadow`(그림자)
- **리스트**: `list-style-type`, `list-style-image` 등으로 마커 스타일 변경
- **테이블**: `border`, `border-collapse`(테두리 합치기), `border-spacing`

## 5. 박스 모델
- **박스 모델** (Box Model)
	- ==HTML 요소를 하나의 사각형 박스로 간주==하는 개념이다.

- **구성 요소**
	- **Content (내용물)**: 텍스트나 이미지가 들어가는 실질적 영역
	- **Padding (패딩)**: 내용물과 테두리 사이의 안쪽 여백 (배경색이 적용됨)
	- **Border (테두리)**: 패딩과 마진 사이의 경계선
	- **Margin (마진)**: 테두리 바깥의 외부 여백 (투명함)

- **크기 설정**
	- `width`, `height`로 설정

- **여백 설정**
	- 상, 우, 하, 좌 순서 또는 축약형으로 지정 가능
	- (예: `margin: 10px 20px`)

- **정렬 팁**
	- 블록 요소 중앙 정렬: `margin-left: auto; margin-right: auto;` (width 지정 필요)
	- Flexbox 이용 중앙 정렬: 부모에 `display: flex; justify-content: center;`

## 6. 레이아웃 (Layout)
> 요소의 위치와 크기를 결정하여 배치하는 방식이다.

### 6.1. Display 속성
- **Display 속성**
	- `block`: 줄 바꿈 일어남, 크기 조절 가능
	- `inline`: 줄 바꿈 없음, 크기 조절 불가
	- `inline-block`: 줄 바꿈 없으나 크기 조절 가능
	- `none`: 화면에서 사라짐 (공간도 차지하지 않음)

- **Flexbox (1차원 레이아웃)**
	- ==행(Row) 또는 열(Column) 한 방향으로 배치==
	- `flex-direction`: 배치 방향 설정
	- `justify-content`: 주축(Main axis) 정렬
	- `align-items`: 교차축(Cross axis) 정렬

- **Grid (2차원 레이아웃)**
	- ==행과 열의 격자(Grid) 형태로 배치==
	- `grid-template-columns/rows`, `gap` 등으로 구조 정의
	- `start/end` 속성으로 영역 지정

### 6.2. Float & Position 속성
- **Float**
	- 요소를 왼쪽이나 오른쪽으로 띄움
	- *간단한 좌우 정렬용으로 사용하며, flex나 grid로 대체된다.*
	- (본래 이미지 주위 텍스트 배치를 위해 사용되나 레이아웃용으로도 쓰임, `clear` 필요)

- **Position**
	- *요소의 위치를 직접 제어할 때 사용한다.*
	- `static`: 기본값 (순서대로 배치)
	- `relative`: 원래 위치 기준 상대적 이동
	- `absolute`: 가장 가까운 포지셔닝된 조상 기준 절대적 배치
	- `fixed`: 뷰포트(브라우저 창) 기준 고정
	- cf. [CodePen](https://codepen.io/albert-jeong/pen/qEboQvW)

### 6.3. 시멘틱 요소
- **시멘틱 요소**
	- `<div>` 대신 의미가 있는 태그(`header`, `nav`, `section`, `footer` 등)를 사용하여 레이아웃을 구성하는 것이 권장됨