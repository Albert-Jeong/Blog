---
draft: false
tags:
  - 3-1/네트워크프로그래밍
date: 2026-05-05
---
## 요약
- `CreateThread()` vs `_beginthreadex()` 선택 기준 — **표준 C 함수 호출 시 반드시 `_beginthreadex`를 써야 하는 이유** (CRT 초기화 문제)
- Signaled / non-signaled 상태 개념 — 쓰레드·프로세스는 **종료 시** signaled로 전환
- `WaitForSingleObject()` 반환값 구분 (`WAIT_OBJECT_0` vs `WAIT_TIMEOUT`)
- `WaitForMultipleObjects()`의 `bWaitAll` 파라미터 — `TRUE`면 전체, `FALSE`면 하나라도
- auto-reset vs manual-reset 모드 차이

## 1. 커널 오브젝트
- **커널 오브젝트** (Kernel Objects)
	- 시스템 리소스를 관리하기 위해 운영체제가 만드는 데이터 블록

- 운영체제가 만들고 관리하는 리소스
	1. 프로그램 실행과 관련된 프로세스·쓰레드
	2. 입출력 도구인 소켓·파일
	3. 쓰레드 간 동기화에 쓰이는 세마포어·뮤텍스

- 핵심
	- 커널 오브젝트의 **소유자가 운영체제**
	- 생성·관리·소멸이 모두 운영체제의 몫
	- 리소스 종류에 따라 커널 오브젝트의 형태도 달라진다.

## 2. 윈도우 기반의 쓰레드 생성
- **프로세스와 쓰레드의 관계**
	- 현대 운영체제는 쓰레드를 OS 레벨에서 지원하므로 `main` 함수 호출조차도 하나의 쓰레드가 수행한다.
	- 즉 프로세스는 "쓰레드를 담는 상자"로 이해하면 되고,
	- 추가 쓰레드를 만들지 않으면 단일 쓰레드 모델,
	- 추가로 만들면 멀티 쓰레드 모델 프로그램이 된다.

### 2.1. CreateThread()
- **쓰레드 생성 함수**
```c
#include <windows.h>
HANDLE CreateThread( // 성공 시 쓰레드 핸들, 실패 시 NULL이 반환
	LPSECURITY_ATTRIBUTES lpThreadAttributes,
	SIZE_T dwStackSize,
	LPTHREAD_START_ROUTINE lpStartAddress,	// ** 쓰레드가 실행할 main 함수 **
	LPVOID lpParameter,						// ** main 함수에 전달할 인자 **
	DWORD dwCreationFlags,
	LPDWORD lpThreadId
);
```

- **환경설정 주의사항**
	- 멀티 쓰레드 프로그램을 작성할 때는 프로젝트 속성에서 런타임 라이브러리를 "다중 스레드(/MT)" 또는 "다중 스레드 디버그(/MTd)" 등 멀티 쓰레드용으로 지정해야 C/C++ 표준 함수가 안정적으로 호출된다.

### 2.2. \_beginthreadex()
- **C 표준 함수의 안전한 호출**
```c
#include <process.h>
uintptr_t _beginthreadex(
    void *security,
    unsigned stack_size,
    unsigned (*start_address)(void *),
    void *arglist,
    unsigned initflag,
    unsigned *thrdaddr
);
```

- 매개변수의 의미와 순서는 `CreateThread`와 동일하지만, 이 함수로 생성된 쓰레드는 표준 C/C++ 함수에 대해 안정적으로 동작한다.
- 따라서 ==표준 C 함수를 호출하는 경우에는 반드시== `_beginthreadex`를 써야한다.

- *cf.*
	- `CreateThread()`는 단순히 OS 레벨 스레드만 생성한다.
	- CRT(C 런타임 라이브러리)는 새 스레드가 생긴 걸 모른다.
	- 그래서 CRT가 필요한 내부 구조를 초기화하지 않는다.

- ==리눅스와 달리 윈도우의 쓰레드는 쓰레드 함수가 반환되면 자동으로 소멸==된다.

## 3. 커널 오브젝트의 두 가지 상태
> 커널 오브젝트는 두 가지 상태를 가진다.

1. **non-signaled 상태**
	- 이벤트가 아직 발생하지 않은(특정 상황에 이르지 않은) 상태

2. **signaled 상태**
	- 이벤트가 발생한(특정 상황에 도달한) 상태

- 예를 들어
	- 프로세스나 쓰레드의 커널 오브젝트는 생성 시
	- non-signaled 상태였다가 종료 시 signaled 상태로 바뀐다.
	- 이 상태 정보를 통해 우리는 리소스의 상황을 인식할 수 있다.

### 3.1. WaitForSingleObject()
- **상태 확인 함수**
	- 전달된 핸들의 커널 오브젝트가 signaled 상태가 되어야 함수가 반환된다.

```c
DWORD WaitForSingleObject(HANDLE hHandle, DWORD dwMilliseconds);

WaitForSingleObject(hThread, INFINITE);
// signaled가 될 때까지 무한 대기
// WAIT_OBJECT_0: signaled로 인한 반환
// WAIT_TIMEOUT: 타임아웃으로 인한 반환
```

### 3.2. WaitForMultipleObjects()
- 여러 커널 오브젝트를 한 번에 관찰
	- `bWaitAll`이 TRUE면 모든 오브젝트가 signaled가 되어야 반환하고,
	- FALSE면 하나라도 signaled가 되면 반환한다.

1. **auto-reset 모드**
	- Wait 계열 함수가 반환되면서 자동으로 다시 non-signaled 상태로 돌아오는 커널 오브젝트

2. **manual-reset 모드**
	- 그렇지 않은 커널 오브젝트

```c
DWORD WaitForMultipleObjects(
    DWORD nCount, const HANDLE* lpHandles,
    BOOL bWaitAll, DWORD dwMilliseconds
);
```