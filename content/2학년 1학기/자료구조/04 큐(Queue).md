---
tags:
  - 2-1/자료구조
draft: false
---
## 1. 큐(Queue)
### 1.1. 추상 자료형
- **데이터**
	- 선입선출(FIFO)의 접근 방법을 유지하는 요소들의 모음
- **연산**
	- `init()`: queue 초기화
	- `is_empty()`
		- 공백 상태에서 `dequeue()`, `peek()` → underflow 오류
		- ∴ 공백 상태이면 true 반환
	- `is_full()`
		- 포화 상태에서 `enqueue(e)` → overflow 오류
		- ∴ 포화 상태이면 true 반환
	
	- `enqueue(e)`: rear에 e 추가
	- `dequeue()`: front 꺼내서 반환
	- `peek()`: front 꺼내지 않고 반환

### 1.2. Time Complexity
- **Search**: $O(n)$ (FIFO 특성상 비효율적)
- **Insert/Delete**: $O(1)$

### 1.3. Features
- **FIFO**(First-In First-Out)
	- **삽입:** `rear`
	- **삭제**: `front`

### 1.4. Applications
- 프로세스/스레드 스케줄링 (CPU 작업 큐)
- 버퍼 관리 (프린터 스풀링, 네트워크 패킷 처리)
- BFS 그래프 탐색
- 이벤트 처리 시스템 (이벤트 큐)
- 데이터 스트림 처리 (스트림 버퍼)
- 순서 보장 캐시 시스템 (FIFO 캐시)

### 1.5. 교재에서 소개된 큐
- **배열 구조의 큐**
	- front, rear에 대한 인덱스를 별도로 저장 (+ 구조체로 사용하여 여러 개의 큐 사용 가능)
	- dequeue가 반복되면 front가 증가, enqueue가 반복되면 rear가 증가
	- **선형 큐**(linear queue): front, rear가 MAX_SIZE에 도달하면 요소들을 모두 앞으로 옮긴다.
	- **원형 큐**(circular queue): front, rear가 MAX_SIZE에 도달하면 다시 0으로 만든다.

## 2. 덱(Deque)
- **덱**(deque; double-ended queue)
	- front와 rear에서 모두 삽입과 삭제가 가능한 큐
	- 큐에 전단삽입과 후단삭제를 추가한 것

### 2.1. 추상 자료형
- **데이터**
	- front와 rear를 통한 접근을 허용하는 요소들의 모음
- **연산**
	- `init()`: deque 초기화
	- `is_empty()`: 공백 상태이면 true 반환
	- `is_full()`: 포화 상태이면 true 반환
	
	- `add_front(e)`: front에 e 추가
		- front에 추가할 때 → **반 시계 방향** 회전
	- `delete_front()`: front 꺼내서 반환(dequeue)
		- front를 삭제할 때 → 시계 방향 회전
	- `get_front()`: front 꺼내지 않고 반환(peek)
	
	- `add_rear(e)`: rear에 e 추가(enqueue)
		- rear에 추가할 때 → 시계 방향 회전
	- `delete_rear()`: rear 꺼내서 반환
		- rear를 삭제할 때 → **반 시계 방향** 회전
	- `get_rear()`: rear 꺼내지 않고 반환

## 3. 덱의 활용
### 3.1. DFS, BFS
 - **시행착오법**
	 - 하나의 경로를 선택해 시도하고 막히면 다시 다른 경로 찾기 시도
	 - 저장된 경로를 모두 선택할 수 있다면 어떤 자료구조에 저장하든지 출구를 찾을 수 있음
	 - 가장 대표적인 방법 : DFS, BFS

 - **깊이 우선 탐색**(DFS, Depth First Search)
	 - **가장 최근에 저장한 경로를 선택하여 다시 시도**
	 - 스택을 이용해 구현

 - **너비 우선 탐색**(BFS, Breadth First Search)
	 - **가장 먼저 저장된 경로를 선택하여 다시 시도**
	 - 큐를 이용해 구현

#### (1) 미로 탐색 알고리즘
- 덱에는 경로(칸의 위치)를 저장한다.
	- 삽입을 후단으로 고정하고 **후단에서 삭제**하면 스택으로 동작한다. (DFS)
	- 삽입을 후단으로 고정하고 **전단에서 삭제**하면 큐로 동작한다. (BFS)
- 경로를 저장하는 함수에서는 방문하지 않았고 갈 수 있는 칸이면 후단에 삽입한다.
- 경로를 꺼내는 함수에서는 후단(DFS) 또는 전단(BFS)에서 삭제한다.

#### (2) 그래프의 순회
- *cf. 그래프*
	- 그래프 = 노드 + 링크
	- 그래프의 순회(troversal)
		- stack → DFS
		- queue → BFS