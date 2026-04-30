---
draft: false
tags:
  - 2-1/자료구조
date: 2025-04-15
---
- 2-1 이산수학
	- [[07_Graph (Discrete Mathematics)]] (그래프의 정의)
- 2-1 자료구조
	- [[07_Tree]]
	- [[08_Graph (Data Structures)]] (그래프의 표현 및 알고리즘 목차)
- 3-1 알고리즘
	- [[06_BST & AVL Trees]]
	- [[07_Elementary Graph Algorithms]]
	- [[08_MST Algorithms]]
	- [[09_Shortest Path Algorithms]]

## 1. 그래프의 표현
|              항목              |  인접 행렬   |             인접 리스트             |
| :--------------------------: | :------: | :----------------------------: |
| **공간 복잡도**(Space Complexity) | $O(V^2)$ |           $O(V+2E)$            |
|       적합한 경우 (공간 효율적)        |  밀집 그래프  |             희소 그래프             |
|           인접 정점 열거           |  $Θ(V)$  |       $Θ(\text{deg}(u))$       |
|     간선 $(u, v)∈E$ 존재 확인      |  $Θ(1)$  | $Θ(\text{deg}(u))$ (최악 $Θ(V)$) |
|           전체 간선 수            | $O(V^2)$ |            $O(V+E)$            |

|     항목      | 인접 행렬 |  인접 리스트   |
| :---------: | :---: | :-------: |
|     메모리     | O(n²) | O(n + 2e) |
| 간선 (u,v) 확인 | O(1)  |  O(d_u)   |
|  v의 차수 계산   | O(n)  |  O(d_v)   |
|   전체 간선 수   | O(n²) | O(n + e)  |

### 1.1. 인접 리스트
- **인접 리스트** (Adjacency List)
	- $|V|$개의 리스트로 구성된 배열 $\text{Adj}$
	- $\text{Adj}[u]$: $u$에 인접한 정점들이 저장됨
	
	- 각 정점마다 인접 정점들을 연결 리스트로 저장 *(가중치 그래프면 가중치도 함께 저장)*

- **Space Complexity**: $O(V+E)$
	- Edge의 수가 적은 희소 그래프(Sparse Graph; $E≈O(V)$)에서 효율적이다.

- **장점**: 희소 그래프에서 공간 효율적, 다양한 변형 지원
- **단점**: 간선 $(u,v)$ 존재 확인이 $Θ(deg(u))$ (최악 $Θ(V)$)

| 그래프 종류  |         합계          |  저장 공간   |
| :-----: | :-----------------: | :------: |
| 방향 그래프  | Σ outdeg(v) = \|E\| | $Θ(V+E)$ |
| 무방향 그래프 |  Σ deg(v) = 2\|E\|  | $Θ(V+E)$ |

### 1.2. 인접 행렬
- **인접 행렬** (Adjacency Matrix)
	- $|V|×|V|$ 행렬 A *(n×n 크기의 2차원 배열 A로 표현)*
	- $A[i,j]=1\text{ if }(i,j)∈E,\quad\text{else }0$
		- 간선 $(i,j)$가 있으면 $\text{adj}[i][j]=1$, 없으면 $0$
	- 무방향 그래프에서는 **대칭 행렬** ($A=A^T$)

- **Space Complexity**: $O(V^2)$
	- Edge의 수가 많은 밀집 그래프(Dense Graph; $E≈O(V^2)$)에서 효율적이다.

- **장점**: $(u,v)$ 존재 확인 $Θ(1)$
- **단점**: 큰 그래프에서 메모리 비효율적

- **특징**
	- **반사성**(Reflexivity)이 있으면 모든 주대각선 1
	- **대칭성**(Symmetric)이 있으면 대칭행렬, 무방향 그래프는 항상 대칭행렬

## 2. Graph Algorithms
### 2.1. Graph Traversal Algorithms
- [[07_Elementary Graph Algorithms#5.1. BFS (Breadth-First Search)|BFS (Breadth-First Search)]]
- [[07_Elementary Graph Algorithms#5.2. DFS (Depth-First Search)|DFS (Depth-First Search)]]

### 2.2. MST Algorithms
- [[08_MST Algorithms#3.1. Kruskal's Algorithm|Kruskal's Algorithm]]
- [[08_MST Algorithms#3.2. Prim's Algorithm|Prim's Algorithm]]

### 2.3. Shortest Path Algorithms
- **Single-Source Shortest Path Algorithms**
	- [[09_Shortest Path Algorithms#2.1. Dijkstra's Algorithm|Dijkstra's Algorithm]]
	- [[09_Shortest Path Algorithms#2.2. Bellman-Ford Algorithm|Bellman-Ford Algorithm]]

- **All-Pairs Shortest Path Algorithms**
	- [[09_Shortest Path Algorithms#4.3. Floyd-Warshall Algorithm|Floyd-Warshall Algorithm]]