#!/usr/bin/env bash
set -euo pipefail

# 원본·대상 디렉터리 (WSL에서 Windows iCloud 경로)
SRC="/mnt/c/Users/sgjeo/iCloudDrive/iCloud~md~obsidian/Vault"
DEST="./content"

# SRC 아래 모든 .md 파일 탐색
find "$SRC" -type f -name '*.md' | while IFS= read -r filepath; do
  # 프런트매터(첫 번째 '---' ~ 두 번째 '---') 안에서 draft: false 여부 검사
  if awk '
    BEGIN   {in_yaml=0; draft_ok=1}           # draft_ok=1 → 실패 상태로 시작
    /^---$/ {in_yaml = !in_yaml; next}        # YAML 블록 토글
    in_yaml && /^draft:[[:space:]]*false([[:space:]]|$)/ {draft_ok=0}
    END     {exit draft_ok}                   # draft_ok=0 이면 성공(exit 0)
  ' "$filepath"; then
    # 상대경로 계산
    relpath="${filepath#"$SRC"/}"
    # 동일한 폴더 구조 생성 후 복사
    mkdir -p "$DEST/$(dirname "$relpath")"
    cp "$filepath" "$DEST/$relpath"
  fi
done

echo "✅  복사가 완료되었습니다."
