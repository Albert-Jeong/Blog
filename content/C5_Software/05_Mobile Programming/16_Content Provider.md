---
draft: false
tags:
  - 3-1/모바일프로그래밍
date: 2026-05-22
---
## 1. 콘텐트 프로바이더 개요
- **콘텐트 프로바이더** (Content Provider)
	- **앱의 데이터를 다른 앱과 공유할 때 사용하는 컴포넌트**
	- 안드로이드는 기본적으로 외부 앱에서 다른 앱의 데이터에 직접 접근하면 보안 문제가 발생하기 때문에, 이를 안전하게 중개하는 역할을 함
	- 공유 대상 앱의 DB, 파일, 메모리 데이터를 공유·수정 가능
	- 구글 기본 앱(주소록, 갤러리, 카메라, 지도, 전화 등)과 연동할 때 자주 사용됨
	- 데이터를 공개하려는 앱은 반드시 콘텐트 프로바이더를 구현해야 외부에서 접근 가능

### 1.1. 콘텐트 프로바이더 작성
> `ContentProvider` 클래스를 상속받아 다음 함수들을 재정의

|      함수      |             역할              |
| :----------: | :-------------------------: |
| `onCreate()` | 생명주기 함수, 시스템이 객체 생성 시 자동 호출 |
| `getType()`  |         MIME 타입 반환          |
|  `query()`   |           데이터 조회            |
|  `insert()`  |           데이터 삽입            |
|  `update()`  |           데이터 수정            |
|  `delete()`  |           데이터 삭제            |

### 1.2. 매니페스트 등록
- 콘텐트 프로바이더도 컴포넌트이므로 매니페스트 등록 필수
	- **name**: 등록할 클래스명
	- **authorities**: 외부에서 식별하는 고유 문자열 (개발자가 지정)

```xml
<provider
    android:name=".MyContentProvider"
    android:authorities="com.example.test_provider"
    android:enabled="true"
    android:exported="true" />
```

### 1.3. 콘텐트 프로바이더 이용하기
- 인텐트와는 무관하며, 시스템이 자동 생성한 객체의 함수만 호출

- **외부 앱에서 사용 시** 매니페스트에 패키지 공개 설정 필요
```xml
<queries>
    <package android:name="com.example.test_outter" />
</queries>
```

- **ContentResolver 객체**를 통해 데이터 조작
    - `query(uri, projection, selection, selectionArgs, sortOrder)`
    - `insert(uri, values)`
    - `update(uri, values, where, selectionArgs)`
    - `delete(uri, where, selectionArgs)`

### 1.4. URI 구조
```
content://com.example.test_provider/user/1
└─프로토콜─┘└──── 호스트(authorities) ──┘└경로┘
```

- URI 구조
	- 경로가 **단어로 끝남** → 해당 카테고리의 모든 데이터
	- 경로가 **숫자로 끝남** → 해당 ID로 식별되는 단일 데이터

- `ContentValues`
	- insert/update 시 사용하는 Map 형태의 키-값 집합 객체

## 2. 안드로이드 기본 앱과 연동
| 연동 대상 |      액션       |                       데이터(URI)                       |
| :---: | :-----------: | :--------------------------------------------------: |
|  주소록  | `ACTION_PICK` | `ContactsContract.CommonDataKinds.Phone.CONTENT_URI` |
|  갤러리  | `ACTION_PICK` |    `MediaStore.Images.Media.EXTERNAL_CONTENT_URI`    |
|  지도   | `ACTION_VIEW` |                     `geo:위도,경도`                      |
|  전화   | `ACTION_CALL` |                      `tel:전화번호`                      |

### 2.1. 주소록 앱 연동
- **퍼미션 설정**
```xml
<uses-permission
	android:name="android.permission.READ_CONTACTS" />
```

- **연동 절차**
	1. `Intent.ACTION_PICK` + `ContactsContract.CommonDataKinds.Phone.CONTENT_URI`로 주소록 목록 띄우기
	2. 사용자가 선택한 항목의 URI를 콜백에서 받음
	3. 해당 URI를 이용해 `contentResolver.query()`로 이름, 전화번호 등 구체적 정보 조회

- **주요 상수**
	- `ContactsContract.Contacts.CONTENT_URI`: 모든 사람
	- `ContactsContract.CommonDataKinds.Phone.CONTENT_URI`: 전화번호 보유자
	- `ContactsContract.CommonDataKinds.Email.CONTENT_URI`: 이메일 보유자

### 2.2. 갤러리 앱 연동
- **안드로이드 이미지**
	- `Drawable`(리소스용)
	- `Bitmap`(파일/네트워크용)
		- `Bitmap`은 `BitmapFactory`로 생성
		- (`decodeByteArray`, `decodeFile`, `decodeResource`, `decodeStream`)

- **OOM(Out Of Memory) 문제 해결**
	- 큰 이미지를 그대로 불러오면 메모리 오류 발생
	- → `BitmapFactory.Options`의 `inSampleSize`로 축소
```kotlin
val option = BitmapFactory.Options()
option.inSampleSize = 4 // 가로/세로 1/4 → 전체 1/16 크기
val bitmap = BitmapFactory.decodeStream(inputStream, null, option)
```

- **연동 절차**
	1. `Intent.ACTION_PICK` + `MediaStore.Images.Media.EXTERNAL_CONTENT_URI` + `type = "image/*"`로 갤러리 실행
	2. 선택된 이미지의 원본 크기를 `inJustDecodeBounds = true`로 미리 측정
	3. 화면 출력 크기와 비교해 적절한 `inSampleSize` 계산
	4. 계산된 비율로 비트맵 생성 후 ImageView에 출력

### 2.3. 지도 앱 연동
- 위도/경도 값으로 지도 앱 실행
	- 액션: `Intent.ACTION_VIEW`
	- URI 형식: `geo:위도,경도`
```kotlin
val intent = Intent(
	Intent.ACTION_VIEW, Uri.parse("geo:37.5662952,126.9779451")
)
startActivity(intent)
```

### 2.4. 전화 앱 연동
- **매니페스트 설정**
```xml
<uses-feature
    android:name="android.hardware.telephony"
    android:required="false" />
<uses-permission
	android:name="android.permission.CALL_PHONE" />
```

- **전화 걸기**
```kotlin
val intent = Intent(
	Intent.ACTION_CALL, Uri.parse("tel:02-120")
)
startActivity(intent)
```