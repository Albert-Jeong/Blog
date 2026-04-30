---
draft: false
tags:
  - 3-1/알고리즘
date: 2026-04-13
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

## 1. 그래프
- 그래프 $G = (V, E)$
	- $V$: 정점(vertex)들의 집합
	- $E$: 간선(edge; link, arc)들의 집합, $E ⊆ (V×V)$

### 1.1. 간선
- **간선의 종류**
	- **무방향 그래프** (Undirected)
		- 간선 $(u, v) = (v, u)$
		- 자기 루프(self-loop) 없음: $(v,v) ∉ E$
	- **방향 그래프** (Directed, Digraph)
		- $(u, v)$는 $u → v$ 방향의 간선
		- 자기 루프(self-loop) 허용

- **간선의 가중치**
	- **무가중치 그래프** (Unweighted)
	- **가중치 그래프** (Weighted)
		- 각 간선에 가중치 함수 $w : E → R$

- **간선의 수**
	- **희소 그래프** (Sparse)
		- $|E| << |V|^2$ (간선이 적음)
	- **밀집 그래프** (Dense)
		- $|E| ≈ |V|^2$ (간선이 많음)

### 1.2. 차수
- **차수** (Degree)
	- $deg(v)$: 정점 $v$에 부속된 간선의 수
	- 루프는 차수에 2 기여
	
	- 차수 0: 고립 정점 (isolated vertex)
	- 차수 1: 끝 정점 (end-vertex)

- **Out-degree / In-degree**: 방향 그래프에서 나가는/들어오는 arc 수
- **Source**: in-degree 0인 정점
- **Sink**: out-degree 0인 정점

#### (1) 악수 정리
- **악수 정리** (Handshaking Lemma)
	- 임의의 그래프 $G$에서, 모든 정점의 차수의 합은 간선 수의 **2배**와 같다. 
	- $\sum_{v \in V}\deg(v) = 2|E|$ (짝수)
	
	- *모든 간선은 양 끝점에서 각각 1씩 차수에 기여하므로, 차수의 합은 반드시 짝수이다.*

#### (2) 악수 따름정리
- **악수 따름정리** (Handshaking Lemma Corollary)
	- 임의의 그래프 $G$에서, 홀수 차수를 가진 정점의 수는 항상 **짝수**이다.

- **귀류법 증명**
	- **귀류 가정**: 홀수 차수 꼭짓점의 수 **$j$가 홀수라고** 가정한다.

- **Step 1. 차수의 합 분해**
	- 전체 꼭짓점 수 $n=i+j$
		- ($i$: 짝수 차수 꼭짓점 수, $j$: 홀수 차수 꼭짓점 수)
	- 꼭짓점 집합을 두 그룹으로 나눈다.
		- 짝수 차수 꼭짓점들의 차수: $2d_1, 2d_2, \ldots, 2d_i$
		- 홀수 차수 꼭짓점들의 차수: $2d_1'+1, 2d_2'+1, \ldots, 2d_j'+1$
	- 차수의 합을 계산하면:
		- $\sum_{v \in V}\deg(v) = \underbrace{\sum_{p=1}^{i}(2d_p)}_{\text{짝수}} + \underbrace{\sum_{\ell=1}^{j}(2d_\ell' + 1)}_{\text{이 부분 분석}}$

- **Step 2. 홀수 차수 꼭짓점 부분 분석 & 전체 차수의 합**
	- $\sum_{v \in V}\deg(v) = \underbrace{2\sum_{p=1}^{i}d_p}_{\text{짝수}} + \underbrace{2\sum_{\ell=1}^{j}d_\ell'}_{\text{짝수}} + \underbrace{j}_{\text{홀수 (가정)}}$
	- **귀류 가정에 의해 j는 홀수** ($j=2k+1$)

- **Step 3. 모순 도출**
	 - 그런데 악수 정리에 의해: $\sum_{v \in V}\deg(v) = 2|E| \quad \Rightarrow \quad \text{반드시 짝수}$
	 - 이는 **Step 2의 결과(홀수)와 모순**이다.

- **Step 4. 결론**
	- 귀류 가정이 틀렸으므로:
	- $\boxed{j \text{ (홀수 차수 꼭짓점의 수) 는 반드시 짝수이다.}}$

#### (3) 악수 딜레마
- 악수 딜레마 (Handshaking Dilemma; 방향 그래프)
	- 모든 정점의 out-degree 합 = in-degree 합

- **outdeg(v)**: (v, w) 형태의 호의 수 (진출 차수)
- **indeg(v)**: (w, v) 형태의 호의 수 (진입 차수)
- **모든 진출 차수의 합 = 모든 진입 차수의 합**
- **소스(source)**: indeg = 0인 정점
- **싱크(sink)**: outdeg = 0인 정점

### 1.3. 인접
- **인접(Adjacency)**
	- $(u, v) ∈ E$이면 정점 $v$는 정점 $u$에 인접
	- *무방향 그래프*: 대칭적 관계
	- *방향 그래프*: 대칭 관계 아닐 수 있음

- **인접 정점**
	- $(v, w) ∈ E$이면 $v$와 $w$는 인접, 이 간선에 **부속(incident)**

- **인접 간선**
	- 공통 정점을 가지는 두 간선

### 1.4. 연결
> 정점들 간의 연결 여부

- vs. Disconnected

- **연결** (Connected)
	- ==방향 그래프== $D$의 기반 무방향 그래프가 연결되어 있는 경우

- **강연결** (Strongly Connected)
	- 임의의 두 정점 $v, w$에 대해 $v → w$ ==경로가 존재==
	- 강연결이면 연결이지만, 연결이라도 강연결이 아닐 수 있음

## 2. 기타 정의
- **동형** (Isomorphic)
	- 두 digraph의 기본 그래프 사이에 정점 순서를 보존하는 동형사상(isomorphism)이 존재

- **방향 가능** (Orientable)
	- 그래프의 각 간선에 방향을 부여하여 strongly connected digraph로 만들 수 있는 그래프 $G$
	- 오일러 그래프는 항상 orientable

## 3. Special Graphs
- **연결 그래프** (Connected Graph)
	- 모든 정점 쌍 사이에 ==경로 존재==
	- $|E| ≥ |V| - 1$

- **트리** (Tree)
	- 모든 정점 쌍 사이에 정확히 하나의 경로가 존재하는(사이클이 없는) 연결 그래프
	- $|E| = |V|-1$

- **평면 그래프** (Planar Graph)
	- 간선 교차 없이 다시 그릴 수 있는 그래프

- **해밀턴 그래프** (Hamiltonian Graph)
	-  모든 **정점**(vertex)을 정확히 한 번씩 방문하고 시작점으로 돌아오는 경로 존재

- **오일러 그래프** (Eulerian Graph)
	- 모든 **간선**(edge)을 정확히 한 번씩 지나 시작점으로 돌아오는 경로 존재

## 4. Representation of Graphs
- [[08_Graph (Data Structures)#2. Representation of Graphs]]

## 5. Graph Traversal Algorithms
- 그래프 탐색 알고리즘
	- 그래프의 간선을 따라 정점을 체계적으로 방문하는 알고리즘
	- → 그래프의 구조 파악에 사용

- **노드의 상태**
	- 미발견 (Undiscovered): White
	- 발견했지만 미완료 (frontier): Gray
	- 완료 (Finished): Black

|   항목   |        BFS        |        DFS         |
| :----: | :---------------: | :----------------: |
| 탐색 방식  |   너비 우선 (레벨 단위)   |   깊이 우선 (가능한 깊게)   |
|  자료구조  |     큐(Queue)      |       재귀(스택)       |
| 출발 정점  |   필요 (source s)   |        불필요         |
| 시간 복잡도 |     $O(V+E)$      |      $Θ(V+E)$      |
| 주요 출력  | 최단 거리 d[v], BF 트리 | 발견/완료 시간, DF 포레스트  |
|   활용   |   최단 경로, BFS 트리   | 위상 정렬, 사이클 탐지, SCC |

### 5.1. 너비 우선 탐색 (BFS, Breadth-First Search)
![|187](https://upload.wikimedia.org/wikipedia/commons/4/46/Animated_BFS.gif)
> 시작 정점에서 가까운 정점부터 차례로 탐색
> Data structure: Queue(FIFO)*를 사용하여 frontier를 균일하게 확장*

- **입력**
	- 그래프 $G$
	- 시작 정점 $s∈V$

- **출력**
	- $d[v]$: $s$에서 $v$까지의 최단 거리 (*간선 수*; 도달 불가 시 ∞)
	- $π[v]$: 최단 경로 상 $v$의 이전 정점 (predecessor; *경로를 나타내게 된다.*)
	- 루트 $s$를 갖는 **너비 우선 트리** 생성

#### (1) Complexity
- **시간 복잡도** (Time Complexity)
	- 인접 리스트: $O(V+E)$
	- 인접 행렬: $O(V^2)$

```c
// 전체: O(V+E)
BFS(G, s) {
	for (each vertex u in V[G] - {s}) { // 1. 초기화: O(V)
		color[u] ← WHITE
		d[u] ← ∞
		π[u] ← NIL
	}
	color[s] ← GRAY
	d[s] ← 0
	π[s] ← NIL
	Q ← ∅
	
	// 2. 큐 연산 (각 정점 1회 enqueue/dequeue): O(V)
	ENQUEUE(Q, s)
	
	while (Q ≠ ∅) {
		u ← DEQUEUE(Q)
		for (each v in Adj[u]) { // 3. 인접 리스트 탐색: Θ(E)
			if (color[v] = WHITE) {
				color[v] ← GRAY
				d[v] ← d[u] + 1
				π[v] ← u
				ENQUEUE(Q, v)
			}
		}
		color[u] ← BLACK
	}
}
```


```
BFS(r):
    enqueue(r); visited[r] ← TRUE
    while not is_empty():
        v ← dequeue()
        for u ∈ adjacent(v):
            if visited[u] = FALSE:
                visited[u] ← TRUE
                enqueue(u)
```

- cf. **Space Complexity**
	- $O(V)$

#### (2) 너비 우선 트리 (BF Tree)
BFS를 시작 정점 s에서 실행하면, s에서 도달 가능한 모든 정점이 하나의 트리로 묶인다.

- **V_π** (트리의 정점 집합): π[v]가 NIL이 아닌 정점들(=BFS 중에 발견된 정점들)에 시작점 s를 합친 것. 즉 s에서 도달 가능한 정점들이다.
- **E_π** (트리의 간선 집합): 각 정점 v에 대해 "선행자에서 v로 가는 간선" (π[v], v)을 모은 것.
- **|E_π| = |V_π| - 1**: 트리의 기본 성질이다. 정점이 n개면 간선은 n-1개.

핵심 성질: **BF 트리에서 s→v로 가는 경로는 원래 그래프에서의 최단 경로(간선 개수 기준)와 같다**. BFS가 가까운 정점부터 차례로 방문하기 때문에 자연스럽게 최단 경로가 만들어진다.

### 5.2. 깊이 우선 탐색 (DFS, Depth-First Search)
![|187](https://upload.wikimedia.org/wikipedia/commons/7/7f/Depth-First-Search.gif)
> 한 방향으로 갈 수 있는 곳까지 깊이 탐색 후 되돌아옴
> Data structure: Stack(LIFO) 또는 재귀

- **핵심 아이디어**
	- 가능한 한 깊이 먼저 탐색
	- 더 이상 갈 수 없으면 backtrack

- **입력**
	- 그래프 $G$
	- (출발 정점 없음)

- **출력**
	- $d[v]$: 발견 시간 (white → gray)
	- $f[v]$: 완료 시간 (gray → black)
	- $π[v]$: 예측자 (v의 이전 정점)
	- 타임스탬프 범위: $1$ ~ $2|V|$

#### (1) Complexity
- **시간 복잡도** (Time Complexity)
	- 인접 리스트: $O(V+E)$
	- 인접 행렬: $O(V^2)$

```c
DFS(G) {
	for (each vertex u ∈ V[G]) { // 1. 초기화 루프: Θ(V)
		color[u] ← WHITE
		π[u] ← NIL
	}
	time ← 0
	for (each vertex u ∈ V[G]) {
		if (color[u] = WHITE) {
		   DFS-Visit(u)
		}
	}
}

DFS_Visit(u) { // 2. DFS-Visit 호출 총합: Θ(E)
	color[u] ← GRAY // u 발견
	time ← time + 1
	d[u] ← time
	for (each v ∈ Adj[u]) {
		if (color[v] = WHITE) {
			π[v] ← u
			DFS_Visit(v)
		}
	}
	color[u] ← BLACK // u 완료
	f[u] ← time ← time + 1
}
```

```
DFS(v):
    visited[v] ← TRUE
    for u ∈ adjacent(v):
        if visited[u] = FALSE:
            DFS(u)
```

- cf. **Space Complexity**
	- 그래프에서 $O(V)$
	- 트리에서 $O(h)$

#### (2) 깊이 우선 트리 / 포레스트 (DF Forest)
DFS는 BFS와 달리 보통 **모든 정점**을 방문하도록 실행한다.
한 정점에서 시작해서 더 이상 갈 데가 없으면, 아직 방문하지 않은 다른 정점에서 다시 시작한다.
그래서 결과가 **여러 개의 트리**가 되고, 이걸 모아서 **숲**(forest)이라고 부른다.

- **V** (정점 집합): 그래프의 모든 정점. BFS와 달리 "도달 가능한 것만"이 아니라 전체이다.
- **E_π**: BFS와 똑같이 (π[v], v) 형태. 다만 시작점이 여러 개일 수 있어서 결과가 트리 하나가 아니라 여럿(=숲).

#### (3) DFS 결과 간선 분류
- **Tree edge (T)**: DFS 숲에 속하는 간선, $(u, v)$ 탐색으로 발견
- **Back edge (B)**: u가 v의 후손인 간선 $(u,v)$ → 사이클 존재 의미
- **Forward edge (F)**: v가 u의 후손이지만 tree edge가 아닌 간선 $(u,v)$
- **Cross edge (C)**: 그 외 모든 간선

## 6. Topological Sort (위상 정렬)
- **정의**
	- DAG(Directed Acyclic Graph)의 모든 정점을 선형 순서로 나열
	- 간선 (u,v)가 있으면 u가 v보다 먼저 나오도록 함
	
	- 그래프에 사이클이 있으면 위상 정렬 불가능
	- 모든 방향 간선이 왼쪽에서 오른쪽으로 향하도록 정점들을 일렬 배치

- **알고리즘**
	1. DFS(G)를 호출하여 각 정점 $v$의 완료 $f[v]$ 계산
	2. 각 정점이 완료될 때마다 연결 리스트의 앞에 삽입
	3. 정점의 연결 리스트 반환

- **Time Complexity**
	- $Θ(V+E)$