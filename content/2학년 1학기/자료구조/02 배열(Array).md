---
tags:
  - 2-1/자료구조
draft: false
---
- *cf. C 언어에서의 배열과 구조체*
	- [[08 배열]]
	- [[14 다차원 배열과 포인터 배열]]
	- [[17 사용자 정의 자료형]]

## 1. 배열(Array)
### 1.1. Time Complexity
|  Array   |          Search          |  Best  |       Average        |    Worst     |
| :------: | :----------------------: | :----: | :------------------: | :----------: |
| Unsorted |    **Linear Search**     | $O(1)$ |        $O(n)$        |    $O(n)$    |
|  Sorted  |    **Binary Search**     | $O(1)$ |     $O(\log{n})$     | $O(\log{n})$ |
|  Sorted  | **Interpolation Search** | $O(1)$ | $O(\log{(\log{n})})$ |    $O(n)$    |
- Binary Search의 Best Case는 탐색의 관점에서 $O(1)$, 탐색 차수의 관점에서 $O(\log{n})$
- Interpolation Search는 직선 형태의 균등 분포에서 $O(\log{(\log{n})})$, 불균등 분포에서 $O(n)$

- **Insert/Delete**: $O(n)$

### 1.2. Features
- 연속된 메모리 공간에 저장됨
	- → ==Random Access==(임의 접근): 빠른 인덱스 접근 가능
	- → 메모리 접근 패턴이 일정해 캐시 친화적
- (동적 배열 제외) 크기 고정
	- → 메모리 낭비 가능성
	- → 삽입/삭제 시 데이터 이동 발생 (삽입/삭제가 빈번하면 부적합)

### 1.3. Applications
- 기본적인 자료구조 구현
- 다차원 데이터 처리
- 인덱스 접근을 활용하는 비디오 프레임 버퍼
- 자주 변경되지 않는 정적 데이터 저장

## 2. 배열의 탐색
- **탐색**: 테이블(레코드의 집합)에서 ==원하는 탐색키를 가진 레코드를 찾는 작업==

- **테이블 구성 방법**: 배열, BST, 해시 테이블 등
	- 테이블 구조에 따라 탐색·삽입·삭제 성능이 달라짐

### 2.1. Linear Search
- **순차 탐색**(선형 탐색): 일렬로 늘어선 레코드를 앞에서부터 순차적으로 비교하며 탐색
	- 배열이나 연결 리스트로 구성

- **동작**: 배열의 `left`부터 `right`까지 순서대로 탐색키와 비교
	- 같으면 성공(인덱스 반환), 끝까지 없으면 실패(-1 반환)
	- **시간 복잡도**: 최선 O(1), 평균/최악 O(n)
	- **분석**: 비효율적이지만, 비정렬 테이블이라면 별다른 대안은 없음

```c
for (int i = left; i <= right; i++)
	if (A[i] == key) {
		// if (i != left) { i -= int; swap(A[i], A[i+1])} // 교환 전략
		return i;
	]
return -1;
```

- **개선 - 자기 구성 순차 탐색**: 자주 탐색되는 레코드를 테이블의 앞쪽으로 옮겨 탐색 효율 증가
    - **move to front**: 찾은 레코드를 맨 앞으로 이동
    - **transpose**: 찾은 레코드를 한 칸씩 앞쪽으로 교환
    - **count-based**: 탐색 횟수 집계 후 빈도 순으로 재배치

### 2.2. Binary Search
```c
int binary_search(int A[]. int key, int low, int high) {
	while (low <= high) {
		int mid = (low + high) / 2;
		if (key == A[mid]) return mid; // 탐색키와 레코드가 같으면 반환
		else if (key < A[mid]) high = mid - 1; // 레코드가 크면 왼쪽으로
		else low = mid + 1; // 레코드가 작으면 오른쪽으로
	}
	return -1;
}
```

- **이진 탐색**: 정렬된 배열에서 가운데 요소와 비교하여 탐색 범위를 절반씩 줄여 나가는 방법
    - **구현**: 재귀(recursive) 또는 반복(iterative) 구조

- 분석
	- **삽입/삭제**: O(n), **탐색**: O(log n) (매 단계마다 범위를 절반으로 축소)
	- 삽입/삭제가 빈번하면 AVL 트리
	- 탐색 연산만 주로 처리하면 효율적

### 2.3. Interpolation Search
$$M=L+(R-L)\frac{(K-A[L])}{(A[R]-A[L])}$$
- **보간 탐색**(Interpolation Search)
	- 탐색키가 존재할 위치를 예측하여 탐색하는 방법
	- 래코드의 키값과 탐색키의 비율을 고려해 탐색 위치 계산