---
draft: false
tags:
date: 2026-07-24
---
## 1. Algorithms
- **알고리즘의 방법**
	1. **Iterative** (Loop) - #2-1/자료구조 강의의 중심
	2. **Recursive** (Divide & Conquer) - #3-1/알고리즘 강의의 중심

### 1.1. 기초
1. [[12_Algorithms (이산수학)]]
	- 정의, 복잡도 분석, 시간 복잡도(Time Complexity), 프로시저

2. [[01_Data Structures & Algorithms]]
	- ADT, 복잡도 분석 예시

### 1.2. 분석 도구
1. [[02_Growth of Functions & Asymptotics]]
	- 점근 표기법, T(n)

2. [[03_Recurrence & Heap]]
	- 점화식

### 1.3. 심화 주제
1. [[13_오토마타, 형식 언어, 문법]]
2. [[10_Max Flow & P-NP]]

## 2. Linear Data Structures
| 자료구조               | 탐색       | 삽입       | 삭제    |
| ------------------ | -------- | -------- | ----- |
| **Unsorted Array** | O(n)     | O(1) (끝) | O(n)  |
| **Sorted Array**   | O(log n) | O(n)     | O(n)  |
| **연결리스트**          | O(n)     | O(1)     | O(1)* |
| **스택/큐**           | O(n)     | O(1)     | O(1)  |

### 2.1. Arrays & Linked Lists
1. [[02_Array & Struct]]
	- C 배열: [[08_Arrays & Strings]]
	- C 구조체: [[17_struct, union, enum]]
	- 자료구조 배열
	- 응용: 희소 행렬, 다항식

2. [[06_List]]
	- C 포인터/동적 할당
	- 연결 구조: [[05_Pointer & Linked Structure]]
	1. 배열 리스트
	2. 단순 연결 리스트
	3. 이중 연결 리스트

### 2.2. Queues & Stacks
1. [[04_Queue]]
	- **선입선출**; FIFO(First-In First-Out)
	- 삽입/삭제 $O(1)$, 탐색 $O(n)$
	
	- 선형 큐, 원형 큐, 덱(Deque)
	- 응용: BFS/DFS 피보나치, 미로 탐색

2. [[03_Stack]]
	- **후입선출**; LIFO(Last-In First-Out)
	- 삽입/삭제 $O(1)$, 탐색 $O(n)$
	
	- 배열/구조체 스택
	- 응용: 괄호 검사, 후위 표기식 계산, 시스템 스택, 재귀 호출

## 2. Non-linear Data Structures
### 2.1. Graph
1. 그래프의 정의: [[07_Graph (이산수학)]]
2. 그래프의 표현: [[08_Graph (자료구조)]]
3. Graph Algorithms
	- **Graph Traversal Algorithms**
		- [[07_Elementary Graph Algorithms#2.1. 너비 우선 탐색 (BFS, Breadth-First Search)|BFS (Breadth-First Search)]], 인접 리스트 $O(V+E)$
		- [[07_Elementary Graph Algorithms#2.2. 깊이 우선 탐색 (DFS, Depth-First Search)|DFS (Depth-First Search)]], 인접 리스트 $O(V+E)$
	- **MST Algorithms**
		- [[08_MST Algorithms#2.1. Kruskal's Algorithm|Kruskal's Algorithm]], $O(E\lg{E})$
		- [[08_MST Algorithms#2.2. Prim's Algorithm|Prim's Algorithm]], 우선순위 큐 $O(E\lg{V})$
	- **SSSP** (Single-Source Shortest Path Algorithms)
		- (음수 가중치 X) [[09_Shortest Path Algorithms#2.1. Dijkstra's Algorithm|Dijkstra's Algorithm]], 우선순위 큐 $O(E\lg{V})$
		- (음수 가중치 O) [[09_Shortest Path Algorithms#2.2. Bellman-Ford Algorithm|Bellman-Ford Algorithm]], $O(VE)$
	- **APSP** (All-Pairs Shortest Path Algorithms)
		- [[09_Shortest Path Algorithms#4.3. Floyd-Warshall Algorithm|Floyd-Warshall Algorithm]], $O(V^3)$

### 2.2. Tree
| 자료구조         | Search       | Insert/Delete | 특징                     |
| :----------- | :----------- | :------------ | :--------------------- |
| Tree         | $O(n)$       | $O(n)$(위치 탐색) | -                      |
| Binary Tree  | $O(n)$       | $O(n)$(위치 탐색) | 자식 최대 2개, 다양한 순회 방법    |
| Heap         | $O(n)$       | $O(\log{n})$  | 완전 이진 트리, 최대/최소값 빠른 접근 |
| BST          | $O(\log{n})$ | $O(\log{n})$  | 유일키, $L<V<R$, 정렬된 탐색   |
| Skewed BST   | $O(n)$       | $O(n)$        | 연결 리스트와 유사해짐           |
| Balanced BST | $O(\log{n})$ | $O(\log{n})$  | -                      |

1. 트리의 정의: [[08_Tree (이산수학)]] (트리, 이진 트리, 힙 트리, BST, BBST)
	- 이진 힙 트리를 활용한 [[03_Recurrence & Heap#5. 우선순위 큐|우선순위 큐]]
2. 트리의 구현: [[07_Tree (자료구조)]] (표현, 연산, Traversal)
3. AVL 트리: [[06_BST & AVL Trees]] (BST 연산, AVL 상세)

## 3. Sort & Search
### 3.1. Sort
> [[09_Sort]]

| 정렬     | 최선           | 평균           | 최악           | 안정  |    제자리     | 특징         |
| :----- | :----------- | :----------- | :----------- | :-: | :--------: | :--------- |
| **선택** | $O(n^2)$     | $O(n^2)$     | $O(n^2)$     | 불안정 |     ✅      | -          |
| **삽입** | $O(n)$       | $O(n^2)$     | $O(n^2)$     |  ✅  |     ✅      | -          |
| **버블** | $O(n)$       | $O(n^2)$     | $O(n^2)$     |  ✅  |     ✅      | -          |
| **퀵**  | $O(n\lg{n})$ | $O(n\lg{n})$ | $O(n^2)$     | 불안정 |     ✅      | D&C(pivot) |
| **힙**  | $O(n\lg{n})$ | $O(n\lg{n})$ | $O(n\lg{n})$ | 불안정 |     ✅      | -          |
| **병합** | $O(n\lg{n})$ | $O(n\lg{n})$ | $O(n\lg{n})$ |  ✅  | 외부($O(n)$) | D&C        |
| **계수** | -            | -            | -            |  -  |     -      | -          |
| **기수** | -            | -            | -            |  -  |     -      | -          |

1. **비교 정렬** - $O(n^2)$
	- 선택 정렬
	- [[01_Overview & Insertion & Merge#2. Insertion Sort|삽입 정렬 (Insertion Sort)]]
	- 버블 정렬

2. **비교 정렬** - $O(n\log{n})$
	- [[04_Quick Sort|퀵 정렬 (Quick Sort)]]
	- [[03_Recurrence & Heap#4. Heap Sort|힙 정렬 (Heap Sort)]]
	- [[01_Overview & Insertion & Merge#5. Merge Sort|병합 정렬 (Merge Sort)]]

3. **비비교 정렬** - $O(n)$
	- [[05_Counting & Radix Sort#2. Counting Sort|계수 정렬 (Counting Sort)]]
	- [[05_Counting & Radix Sort#3. Radix Sort|기수 정렬 (Radix Sort)]]

### 3.2. Search
> [[10_Search]]

- **Comparison-based Search**
	1. **Linear Search** (선형 탐색, 순차 탐색): 비정렬 원소, $O(n)$
	2. **Binary Search** (이진 탐색): 기정렬 원소, $O(n\lg{n})$
	3. **Interpolation Search**

- **Hash-based Search**
	- **Hashing**: 탐색 및 삽입/삭제의 평균 $O(1)$, 최악 $O(n)$