---
tags:
  - 2-1/자료구조
draft: false
---
## 1. 그래프(Graph)
### 1.1. Definition
- **그래프**(Graph)
	- 연결된 객체 사이의 관계를 표현하는 자료구조
	- 이산수학 [[07 그래프|그래프]] 참조
	- 범용성이 매우 뛰어난 자료구조

### 1.2. 표현
#### (1) 인접 리스트(AL, Adjacency List)
- 각 정점마다 연결된 이웃 리스트 유지

- **Space Complexity**: $O(V+E)$
	- Edge의 수가 적은 ==Sparse Graph==($E≈O(V)$)에서 효율적

#### (2) 인접 행렬(AM, Adjacency Matrix)
- n×n 크기의 2차원 배열 A 사용
- `A[i][j]=1` 이면 정점 i와 j에 간선 존재

- **특징**
	- **반사성**(Reflexivity)이 있으면 모든 주대각선 1
	- **대칭성**(Symmetric)이 있으면 대칭행렬, 무방향 그래프는 항상 대칭행렬

- **Space Complexity**: $O(V^2)$
	- Edge의 수가 많은 ==Dense Graph==($E≈O(V^2)$)에서 효율적

## 2. Graph Algorithms
### 2.1. Graph Traversal Algorithms
#### (1) Depth-First Search (DFS)
![|187](https://upload.wikimedia.org/wikipedia/commons/7/7f/Depth-First-Search.gif)
- **Data Structure**: Stack (LIFO)
- **Time Complexity**: $O(V+E)$
- **Space Complexity**: 그래프에서 $O(V)$, 트리에서 $O(h)$

#### (2) Breadth-First Search (BFS)
![|187](https://upload.wikimedia.org/wikipedia/commons/4/46/Animated_BFS.gif)
- **Data Structure**: Queue (FIFO)
- **Time Complexity**: $O(V+E)$
- **Space Complexity**: $O(V)$

### 2.2. Shortest Path Algorithms
#### (1) Dijkstra
![|200](https://upload.wikimedia.org/wikipedia/commons/5/57/Dijkstra_Animation.gif)
- Single Source Shortest Path (하나의 정점에서 다른 모든 정점까지의 최단 거리)
- **Time Complexity**: $O(E\log{V})$
- 음수 가중치 불가능

#### (2) Bellman–Ford
![|200](https://upload.wikimedia.org/wikipedia/commons/7/77/Bellman%E2%80%93Ford_algorithm_example.gif)
- Single Source Shortest Path
- **Time Complexity**: $O(VE)$
- 음수 가중치 가능

#### (3) Floyd–Warshall
- All-Pairs Shortest Path (모든 정점 쌍의 최단 거리)
- **Time Complexity**: $O(V^3)$
- 음수 가중치 가능

### 2.3. MST Algorithms
- **Spanning Tree**
	- 그래프의 모든 정점을 포함하면서 사이클이 없는 트리

- **Minimum Spanning Tree** (MST)
	- Spanning Tree 중에서도 Edge Weight의 합(Cost)이 가장 작은 트리

#### (1) Kruskal
![|200](https://upload.wikimedia.org/wikipedia/commons/b/bb/KruskalDemo.gif)
- **접근 방식**: ==Edge-based==
- **Data Structure**: Union-Find (Disjoint Set)
- **Time Complexity**: $O(E\log{E})$
	- Edge의 수가 적은 ==Sparse Graph==($E≈O(V)$)에서 효율적

#### (2) Prim
![|200](https://upload.wikimedia.org/wikipedia/commons/9/9b/PrimAlgDemo.gif)
- **접근 방식**: ==Vertex-based==
- **Data Structure**: Priority Queue (Heap)
- **Time Complexity**: $O(E\log{V})$
	- Edge의 수가 많은 ==Dense Graph==($E≈O(V^2)$)에서 효율적

## 3. 그래프의 응용
### 3.1. Travelling Salesman Problem
- 해밀턴 순회 문제
	- **결정형 TSP**: NP-Complete
	- **최적화형 TSP**:  NP-Hard

#### (1) Nearest Neighbor
- 가장 가까운 정점으로 이동을 반복하여 순회
- 최적해가 보장되지 않는 근사 알고리즘