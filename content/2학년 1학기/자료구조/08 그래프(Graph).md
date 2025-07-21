---
tags:
  - 2-1/자료구조
draft: false
---
## 1. 그래프(Graph)
- **그래프**: 연결된 객체 사이의 관계를 표현하는 자료구조
	- 이산수학 [[07 그래프|그래프]] 참조
	- 범용성이 매우 뛰어난 자료구조

## 2. 그래프의 표현
|     표현 방식     |          인접 행렬           |         인접 리스트          |
| :-----------: | :----------------------: | :---------------------: |
|    메모리 공간     | $O(n^2)$<br>조밀 그래프에서 효과적 | O(n+2e)<br>희소 그래프에서 효과적 |
| 간선 (u, v)의 유무 |           O(1)           |       $O(deg_u)$        |
|   v의 차수 확인    |           O(n)           |       $O(deg_v)$        |
|  v의 모든 인접 정점  |           O(n)           |       $O(deg_v)$        |
|     간선 수      |         $O(n^2)$         |         O(n+e)          |

### 2.1. 인접 행렬(AM; Adjacency Matrix)
$$\begin{array}{c|ccc}
 & a&b&c&d\\
\hline
a& 0&1&0&1\\
b& 1&0&1&1\\
c& 0&1&0&1\\
d& 1&1&1&0\end{array}$$
- **반사**: 모든 주대각선 1
- **대칭**: 대칭행렬, 무방향 그래프는 항상 대칭행렬

- n×n 크기의 2차원 배열 A 사용
- `A[i][j]=1` 이면 정점 i와 j에 간선 존재

### 2.2. 인접 리스트(AL; Adjacency List)
- 각 정점에 대해 포인터
- 같은 리스트 내에서는 순서에 관계가 없음

- 각 정점마다 연결된 이웃 리스트를 유지

## 3. Graph Algorithms
### 3.1. Graph Traversal Algorithms
#### (1) Depth-First Search (DFS)
- **Data Structure**: Stack (LIFO)
- **Time Complexity**: $O(V+E)$
- **Space Complexity**: $O(H)$

![|187](https://upload.wikimedia.org/wikipedia/commons/7/7f/Depth-First-Search.gif)

#### (2) Breadth-First Search (BFS)
- **Data Structure**: Queue (FIFO)
- **Time Complexity**: $O(V+E)$
- **Space Complexity**: $O(V)$

![|187](https://upload.wikimedia.org/wikipedia/commons/4/46/Animated_BFS.gif)

### 3.2. Shortest Path Algorithms
#### (1) Dijkstra’s Algorithm
- ==Single Source Shortest Path== (하나의 정점에서 다른 모든 정점까지의 최단 거리)
- **Time Complexity**: $O((V+E)\log{V})$
- ==음수 가중치 불가능==

![|200](https://upload.wikimedia.org/wikipedia/commons/5/57/Dijkstra_Animation.gif)

#### (2) Floyd–Warshall Algorithm
- ==All-Pairs Shortest Path== (모든 정점 쌍의 최단 거리)
- **Time Complexity**: $O(V^3)$
- ==음수 가중치 가능==

### 3.3. MST Algorithms
- **Spanning Tree**
	- 그래프의 모든 정점을 포함하면서 사이클이 없는 트리

- **Minimum Spanning Tree** (MST)
	- Spanning Tree 중에서도 Edge Weight의 합(Cost)이 가장 작은 트리

#### (1) Kruskal’s Algorithm
- **접근 방식**: ==Edge-based==
- **Data Structure**: Union-Find (Disjoint Set)
- **Time Complexity**: $O(E\log{E})$
	- Edge의 수가 적은 ==Sparse Graph==($E≈O(V)$)에서 효율적

![|200](https://upload.wikimedia.org/wikipedia/commons/b/bb/KruskalDemo.gif)

#### (2) Prim’s Algorithm
- **접근 방식**: ==Vertex-based==
- **Data Structure**: Priority Queue (Heap)
- **Time Complexity**: $O(E\log{V})$
	- Edge의 수가 많은 ==Dense Graph==($E≈O(V^2)$)에서 효율적

![|200](https://upload.wikimedia.org/wikipedia/commons/9/9b/PrimAlgDemo.gif)

## 4. 그래프의 응용
### 4.1. Travelling Salesman Problem
- 해밀턴 순회의 최적화 문제
- NP-Complete, NP-Hard

#### (1) Nearest Neighbor
- 가장 가까운 정점으로 이동을 반복하여 순회
- 최적해가 보장되지 않는 근사 알고리즘