---
draft: false
tags:
  - 3-1/모바일프로그래밍
date: 2026-05-01
---
## 1. 브로드캐스트 리시버 개요
- **브로드캐스트 리시버** (Broadcast Receiver)
	- **안드로이드 4대 컴포넌트** 중 하나이며, 줄여서 리시버라고도 부른다.
	- 사용자의 액션이 아닌, **시스템에서 발생하는 이벤트**(예: 부팅 완료, 배터리 부족 등)로 인해 실행된다.
	- 시스템의 특정 상황을 알리는 정보를 전달받고, 이를 처리하는 역할을 한다.
	- 액티비티와 유사하게 **인텐트**(Intent)를 시스템에 전달하여 실행한다.

### 1.1. 구현
- `BroadcastReceiver` 클래스를 상속받아 구현한다.

### 1.2. 실행 방식 (인텐트 전달)
- 리시버를 실행하려면
	- 인텐트가 필요하며,
	- `sendBroadcast(intent)` 함수를 사용해 시스템에 전달한다.

- **액티비티 인텐트 vs 리시버 인텐트 비교**
    - **대상 없음**: 액티비티는 오류 발생 / 리시버는 오류 발생하지 않음
    - **대상 1개**: 둘 다 정상 실행
    - **대상 여러 개**: 액티비티는 사용자가 1개 선택 / 리시버는 **조건에 맞는 모든 리시버 실행**

### 1.3. 생명주기
- `onReceive()` 함수 단일로 구성된다.
- 리시버가 실행되어 인텐트를 받으면 `onReceive()`가 자동 호출되며, 호출한 인텐트 객체를 매개변수로 전달받는다.
- **10초 이내**에 처리를 완료해야 한다.

## 2. 등록 방식
|   등록 방식   |           등록 위치            |                     비고                     |    주요 활용 사례    |
| :-------: | :------------------------: | :----------------------------------------: | :------------: |
| **정적 등록** |    AndroidManifest.xml     |            exported,<br>enabled            | BOOT_COMPLETED |
| **동적 등록** | 코드 내<br>registerReceiver() | RECEIVER_EXPORTED,<br>unregisterReceiver() | SCREEN_ON/OFF  |

### 2.1. 정적 등록
- **정적 등록** (매니페스트 등록)
	- 컴포넌트이므로 기본적으로 `AndroidManifest.xml`에 등록한다.

- 속성
    - `exported`: 외부 앱의 이벤트 처리 여부 (`true`/`false`)
    - `enabled`: 리시버의 활성화 여부 (`true`/`false`)

- 주의
	- 매니페스트에 `<intent-filter>`를 선언했더라도,
	- 최신 안드로이드 버전에서는 암시적 인텐트로는 실행이 제한될 수 있다.

### 2.2. 동적 등록
- **동적 등록** (코드 내 등록)
	- 매니페스트에 등록하지 않고,
	- 특정 액티비티나 서비스가 **실행 중일 때만 동작**하도록 코드에서 등록한다.

- **등록**
	- `registerReceiver(리시버 객체, 인텐트 필터, 공개 상태 정보)` 사용
    - 암시적 인텐트 실행 시 `RECEIVER_EXPORTED` 지정
	    - (반대는 `RECEIVER_NOT_EXPORTED`)

- **해제**
	- 불필요해지면 반드시 `unregisterReceiver(리시버 객체)`를 호출하여 해제해야 한다.

## 3. 시스템 상태 분석 (주요 활용 사례)
### 3.1. 부팅 완료 상태 (`BOOT_COMPLETED`)
- 기기 전원이 켜지고 부팅이 완료되면 발생하는 이벤트이다.
- 부팅 직후 백그라운드 작업을 수행하려면 **매니페스트(정적) 등록**이 필수이다.

- **필수 권한**
	- 매니페스트에 `RECEIVE_BOOT_COMPLETED` 권한을 반드시 추가해야 한다.

- **액션 문자열**
	- `android.intent.action.BOOT_COMPLETED`

### 3.2. 화면 켬/끔 상태 (`SCREEN_ON` / `SCREEN_OFF`)
- **특징**
	- 매니페스트에 정적으로 등록하면 **실행되지 않는다.**
	- 반드시 코드에서 **동적 등록**(`registerReceiver`)을 해야 한다.

- **액션 문자열**
	- `android.intent.action.SCREEN_ON`,
	- `android.intent.action.SCREEN_OFF`

- 수시로 발생하는 이벤트이므로,
	- 불필요한 상황에서는 반드시 등록을 해제하여 리소스 낭비를 막아야 한다.

### 3.3. 배터리 상태 정보
#### (1) 배터리 상태 변경 이벤트 수신 (리시버 사용)
- 배터리 상태가 변할 때마다 이벤트를 받는다.

- **주요 액션 문자열**
    - `BATTERY_LOW`: 배터리 부족
    - `BATTERY_OKAY`: 배터리 정상
    - `BATTERY_CHANGED`: 충전 상태 변경
    - `ACTION_POWER_CONNECTED`: 전원 연결됨
    - `ACTION_POWER_DISCONNECTED`: 전원 연결 끊김

#### (2) 현재 배터리 정보 즉시 파악 (리시버 이벤트 대기 없이 파악)
- `registerReceiver()`의
	- 첫 번째 인자(리시버 객체)에 `null`을 전달하면,
	- 현재 배터리 상태를 담은 인텐트를 즉시 반환받을 수 있다.
    - 코드 예: `val batteryStatus = registerReceiver(null, intentFilter)`

- **인텐트(Extras)에서 추출할 수 있는 정보**
    - `EXTRA_STATUS`: 충전 상태 파악 (예: `BATTERY_STATUS_CHARGING`)
    - `EXTRA_PLUGGED`: 충전기 종류 파악 (USB: 저속 충전, AC: 고속 충전)
    - `EXTRA_LEVEL`: 현재 배터리 충전량 (0 ~ SCALE)
    - `EXTRA_SCALE`: 배터리 최대 충전량 (기기마다 다름)
    - **배터리 잔량(%) 계산식**: `(LEVEL / SCALE) * 100`