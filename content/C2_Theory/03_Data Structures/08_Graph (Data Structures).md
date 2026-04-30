---
draft: false
tags:
  - 2-1/자료구조
date: 2025-04-15
---
## 1. 그래프(Graph)
### 1.1. Definition
- **그래프**(Graph)
	- 연결된 객체 사이의 관계를 표현하는 자료구조
	- 이산수학 [[07_Graph (Discrete Mathematics)|그래프]] 참조
	- 범용성이 매우 뛰어난 자료구조

## 2. Representation of Graphs
> *그래프의 자료구조*

|              항목              |             인접 리스트             |  인접 행렬   |
| :--------------------------: | :----------------------------: | :------: |
| **공간 복잡성**(Space Complexity) |            $Θ(V+E)$            | $Θ(V^2)$ |
|       적합한 경우 (공간 효율적)        |             희소 그래프             |  밀집 그래프  |
|           인접 정점 열거           |       $Θ(\text{deg}(u))$       |  $Θ(V)$  |
|     간선 $(u, v)∈E$ 존재 확인      | $Θ(\text{deg}(u))$ (최악 $Θ(V)$) |  $Θ(1)$  |

### 2.1. 인접 리스트
- **인접 리스트** (Adjacency List)
	- $|V|$개의 리스트로 구성된 배열 $\text{Adj}$
	- $\text{Adj}[u]$: $u$에 인접한 정점들이 저장됨
	
	- *각 정점마다 연결된 이웃 리스트 유지*
	- *가중치 그래프면 가중치도 함께 저장*

- **Space Complexity**: $O(V+E)$
- Edge의 수가 적은 ==Sparse Graph==($E≈O(V)$)에서 효율적

- **장점**: 희소 그래프에서 공간 효율적, 다양한 변형 지원
- **단점**: 간선 $(u,v)$ 존재 확인이 $Θ(deg(u))$ (최악 $Θ(V)$)

| 그래프 종류  |         합계          |  저장 공간   |
| :-----: | :-----------------: | :------: |
| 방향 그래프  | Σ outdeg(v) = \|E\| | $Θ(V+E)$ |
| 무방향 그래프 |  Σ deg(v) = 2\|E\|  | $Θ(V+E)$ |

### 2.2. 인접 행렬
- **인접 행렬** (Adjacency Matrix)
	- $|V|×|V|$ 행렬 A
		- *n×n 크기의 2차원 배열 A
	- $A[i,j]=1\text{ if }(i,j)∈E,\quad\text{else }0$
		- *`A[i][j]=1` 이면 정점 i와 j에 간선 존재*
	- 무방향 그래프에서는 $A = A^T$ (대칭)

- **Space Complexity**: $O(V^2)$
- Edge의 수가 많은 ==Dense Graph==($E≈O(V^2)$)에서 효율적

- **장점**: $(u,v)$ 존재 확인 $Θ(1)$
- **단점**: 큰 그래프에서 메모리 비효율적

- **특징**
	- **반사성**(Reflexivity)이 있으면 모든 주대각선 1
	- **대칭성**(Symmetric)이 있으면 대칭행렬, 무방향 그래프는 항상 대칭행렬

## 3. Graph Algorithms
### 3.1. Graph Traversal Algorithms
- **Graph Traversal Algorithms**
	- [[07_Elementary Graph Algorithms#5.1. BFS (Breadth-First Search)|BFS (Breadth-First Search)]]
	- [[07_Elementary Graph Algorithms#5.2. DFS (Depth-First Search)|DFS (Depth-First Search)]]

### 3.2. MST Algorithms
- **신장 트리 (Spanning Tree)**
	- 연결 그래프의 모든 정점을 포함하면서 사이클이 없는 부분 그래프이다.
	- 정점이 n개이면 간선은 항상 n-1개이다.

- **최소 신장 트리 (MST, Minimum Spanning Tree)**
	- 신장 트리 중에서 간선 가중치의 합이 가장 작은 것을 말한다.

- **MST Algorithms**
	- [[08_MST Algorithms#3.1. Kruskal's Algorithm|Kruskal's Algorithm]]
	- [[08_MST Algorithms#3.2. Prim's Algorithm|Prim's Algorithm]]

### 3.3. Shortest Path Algorithms
- **Single-Source Shortest Path Algorithms**
	- [[09_Shortest Path Algorithms#2.1. Dijkstra's Algorithm|Dijkstra's Algorithm]]
	- [[09_Shortest Path Algorithms#2.2. Bellman-Ford Algorithm|Bellman-Ford Algorithm]]

- **All-Pairs Shortest Path Algorithms**
	- [[09_Shortest Path Algorithms#4.3. Floyd-Warshall Algorithm|Floyd-Warshall Algorithm]]

## 4. 그래프의 응용
### 4.1. Travelling Salesman Problem
- 해밀턴 순회 문제
	- **결정형 TSP**: NP-Complete
	- **최적화형 TSP**:  NP-Hard

#### (1) Nearest Neighbor
- 가장 가까운 정점으로 이동을 반복하여 순회
- 최적해가 보장되지 않는 근사 알고리즘