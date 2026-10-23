#!/usr/bin/env bash
# 배포 사이트 자동 점검 스크립트 — 과제 공개 평가기준 중 HTTP로 검증 가능한 항목을 확인한다.
# 사용법: bash scripts/verify-site.sh
set -u
BASE="https://05solar.github.io/BP-05"
PASS=0; FAIL=0

check() { # check <설명> <조건식 결과(0=성공)>
  if [ "$2" -eq 0 ]; then echo "PASS | $1"; PASS=$((PASS+1));
  else echo "FAIL | $1"; FAIL=$((FAIL+1)); fi
}

code() { curl -s -o /dev/null -w "%{http_code}" "$1"; }

echo "== CheckMite 배포 사이트 자동 점검 =="
echo "대상: $BASE/  ($(date '+%Y-%m-%d %H:%M %Z'))"
echo

# P01 HTTPS 공개 접속
[ "$(code "$BASE/")" = "200" ]; check "P01 홈 HTTPS 200 응답" $?

# P24 직접 URL 접근 (내부 페이지·앵커 URL)
[ "$(code "$BASE/writing/")" = "200" ]; check "P24 /writing/ 직접 접근 200" $?
[ "$(code "$BASE/writing/checkmite/")" = "200" ]; check "P24 /writing/checkmite/ 직접 접근 200" $?
[ "$(code "$BASE/writing/edu-msa/")" = "200" ]; check "P24 /writing/edu-msa/ 직접 접근 200" $?
[ "$(code "$BASE/writing/jbig/")" = "200" ]; check "P24 /writing/jbig/ 직접 접근 200" $?

HOME_HTML=$(curl -s "$BASE/")

# P16 홈의 배포 경로 — 하위 경로 자산 참조 존재
echo "$HOME_HTML" | grep -q "/BP-05/"; check "P16 하위 경로(/BP-05/) 자산 참조 사용" $?

# P19 개인 PC 주소 제거
! echo "$HOME_HTML" | grep -Eq "localhost|127\.0\.0\.1|file://|C:\\\\Users"; check "P19 배포 HTML에 localhost·127.0.0.1·file·로컬 경로 없음" $?

# P20 HTTPS 자산 — http:// 혼합 콘텐츠 참조 없음
! echo "$HOME_HTML" | grep -Eq "(src|href)=[\"']?http://"; check "P20 http:// 혼합 콘텐츠 참조 없음" $?

# P48 문서 언어
echo "$HOME_HTML" | grep -q 'lang=ko\|lang="ko"'; check "P48 html lang=ko 설정" $?

# P29 빈 링크 — href="#" 단독(정상 앵커 #section 제외) 없음
! echo "$HOME_HTML" | grep -Eq "href=[\"']#[\"']"; check "P29 의미 없는 href=\"#\" 없음" $?

# P11 스타일시트 로딩
CSS_URL=$(echo "$HOME_HTML" | grep -o "$BASE/css/main\.min\.[a-f0-9]*\.css" | head -1)
[ -n "$CSS_URL" ] && [ "$(code "$CSS_URL")" = "200" ]; check "P11 CSS 요청 200 ($CSS_URL)" $?

# P13 대표 이미지(아바타) 로딩
[ "$(code "$BASE/images/profile-avatar.png")" = "200" ]; check "P13 프로필 아바타 200" $?

# P14 본문(프로젝트) 이미지 샘플 로딩
[ "$(code "$BASE/images/projects/checkmitev1.png")" = "200" ]; check "P14 프로젝트 이미지 200 (checkmite)" $?

# 404 페이지 동작
[ "$(code "$BASE/no-such-page/")" = "404" ]; check "404 미존재 경로에서 404 상태 반환" $?

echo
echo "결과: PASS $PASS / FAIL $FAIL"
exit $FAIL
