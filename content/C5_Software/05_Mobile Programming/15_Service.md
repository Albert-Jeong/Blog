---
draft: false
tags:
  - 3-1/모바일프로그래밍
date: 2026-05-01
---
## 1. 서비스 개요
- **서비스** (Service)
	- 화면이 없는 백그라운드 작업을 목적으로 하는 안드로이드 컴포넌트

- **실행 방법**
	- `startService()`와 `bindService()` 두 가지 방식이 있으며,
	- 사용 방식에 따라 생명주기가 달라진다.

- **특징**
	- 시스템에 의해 생명주기가 관리되며,
	- 안드로이드 8.0(API 26)부터는 백그라운드 작업에 엄격한 제약이 추가되었다.

- **외부 앱 서비스**
	- `setPackage()`를 통해 패키지명을 명시해야 하며,
	- Android 11(API 30)부터는 `queries` 태그에 패키지를 등록해야 한다.

### 1.1. startService()
- **생명주기**
	- `onCreate()` → `onStartCommand()`
	- → (종료 시) `onDestroy()` 순으로 실행된다.

### 1.2. bindService()
- 다른 컴포넌트와 데이터를 주고받거나 상호작용할 때 사용한다.
- `ServiceConnection` 객체가 필요하다.

- **생명주기**
	- `onCreate()` → `onBind()`
	- → (종료 시) `onUnbind()` → `onDestroy()` 순으로 실행된다.

## 2. 바인딩 서비스와 AIDL
- **바인딩**
	- 서비스와 액티비티 간 데이터를 주고받기 위한 통신 방식

- **AIDL** (Android Interface Definition Language)
	- 서로 다른 프로세스 간 통신(IPC)을 위한 기술
	- 인터페이스 파일을 생성하고, 서비스에서는 `Stub`를 구현하여 객체를 전달한다.
	- 외부 앱은 `asInterface()`를 통해 바인딩된 서비스의 함수를 호출하여 데이터를 교환한다.

## 3. 백그라운드 제약
- **백그라운드 제약** (Android 8.0+)
	- 앱이 백그라운드 상태일 때 일반적인 방법으로 서비스를 시작하면 오류가 발생한다.

### 3.1. 대응책
- **Foreground Service**
	- `startForegroundService()`를 호출하고,
	- 알림(Notification)을 생성하여 `startForeground()`를 즉시 실행해야 한다.

- **권한 설정**
	- `FOREGROUND_SERVICE`, `POST_NOTIFICATIONS` 권한이 필요하며,
	- `foregroundServiceType`을 매니페스트에 지정해야 한다.

### 3.2. 브로드캐스트 리시버
- 암시적 인텐트 사용이 제한되므로,
- 명시적 인텐트(`setPackage`)를 사용하거나 `registerReceiver()`로 등록해야 한다.

## 4. 잡 스케줄러
- **잡 스케줄러** (Job Scheduler)
	- 배터리 효율이나 네트워크 상태 등
	- 특정 조건이 충족될 때 백그라운드 작업을 실행하도록 시스템에 예약한다.

- **핵심**
	- `onStartJob()`에서 작업이 길어질 경우 `true`를 반환하고,
	- 작업 종료 시 `jobFinished()`를 호출한다.

### 4.1. 구성 요소
1. **잡 인포 (Job Info)**
	- 작업 실행 조건(네트워크, 충전 여부, 주기 등)을 설정

2. **잡 서비스 (Job Service)**
	- 백그라운드 작업을 구현한 서비스
	- (`JobService` 상속)

3. **잡 스케줄러 (Job Scheduler)**
	- 잡 인포를 시스템에 등록