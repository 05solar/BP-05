# 기능 검증 기록 (verification log)

과제 공개 평가기준에 대한 검증 수행 기록. 자동 점검은 `scripts/verify-site.sh`로 재현할 수 있다.
보고서의 기능 검증표(배포 / 경로·자산 / 메뉴·링크 / 반응형 / 키보드 5개 영역)는 이 기록을 근거로 작성한다.

## 1차 — 자동 점검 (HTTP 레벨)

- **일시**: 2026-10-23 13:27 KST
- **대상**: https://05solar.github.io/BP-05/
- **도구**: `scripts/verify-site.sh` (curl 기반, 로그인 없는 환경과 동일 조건)
- **결과**: **PASS 14 / FAIL 0**

| 기준 | 확인 동작 | 예상 | 실제 결과 |
|------|-----------|------|-----------|
| P01 | 홈 HTTPS 접속 | 200 | PASS (200) |
| P24 | /writing/, /writing/checkmite/, /writing/edu-msa/, /writing/jbig/ 직접 URL 접근 | 각 200 | PASS (4건 모두 200) |
| P16 | 하위 경로(/BP-05/) 기준 자산 참조 | 참조 존재 | PASS |
| P19 | 배포 HTML 내 localhost·127.0.0.1·file://·로컬 절대 경로 | 없음 | PASS (0건) |
| P20 | http:// 혼합 콘텐츠 참조 | 없음 | PASS (0건) |
| P48 | html lang 속성 | ko | PASS |
| P29 | 의미 없는 href="#" 단독 링크 | 없음 | PASS (0건) |
| P11 | 홈 CSS 요청 | 200 | PASS (fingerprint된 main.min.*.css 200) |
| P13 | 프로필 아바타 이미지 요청 | 200 | PASS |
| P14 | 본문(프로젝트) 이미지 요청 | 200 | PASS |
| — | 미존재 경로의 404 상태 | 404 | PASS (커스텀 404 페이지) |

## 2차 — 브라우저 실측

- **일시**: 2026-11-07 17:49~17:58 KST
- **대상**: https://05solar.github.io/BP-05/ (헤드리스 Edge, puppeteer-core로 자동화된 실측 — viewport·overflow·focus 상태를 직접 DOM에서 측정)
- **환경**: Microsoft Edge (설치 버전, headless 구동) / Windows 11 / 1440×900, 768×1024, 390×844 뷰포트

| 기준 | 확인 동작 | 예상 | 실제 결과 |
|------|-----------|------|-----------|
| P31 | 1440px 홈 `document.scrollWidth` vs `clientWidth` | 가로 넘침 없음 | **PASS** (넘침 0px) |
| P33 | 768px 홈 가로 넘침 | 없음 | **PASS** (넘침 0px) |
| P32 | 390px 홈 가로 넘침 | 없음 | **PASS** (넘침 0px) |
| P36 | CheckMite 글(표 7개+KaTeX 수식) 390px 가로 넘침 | 페이지 넘침 없음, 표만 영역 내 스크롤 | **1차 실측 FAIL → 수정 후 PASS** (아래 "문제 해결" 참조) |
| P34 | 390px 메뉴 사용 | 메뉴 접근 가능 | **PASS** — 이 테마는 390px에서도 상단 메뉴가 항상 노출되는 구조(별도 햄버거 토글 없음), 터치로 바로 선택 가능 |
| P35 | 1440→390→1440 복귀(새로고침 없음) | 메뉴·본문이 숨은 채로 남지 않음 | **PASS** — 복귀 후 `nav` `display`·`visibility` 정상, 폭 > 0 |
| P40 | 데스크톱 200% 확대 근사(뷰포트 720px, 콘텐츠 동일) | 메뉴·본문 사용 가능 | **PASS** — nav 렌더 폭/높이 정상 |
| P41 | Tab으로 주요 메뉴 도달 | 헤더 링크에 포커스 도달 | **PASS** — 2번째 Tab(스킵 링크 다음)부터 헤더 링크 연속 도달 (05solar Portfolio→Home→About→News→Projects) |
| P43 | 초점 표시(outline/box-shadow) | 포커스 시 시각적으로 구별 가능 | **PASS** — 스킵 링크 `outline: solid 3px`, 헤더 링크 `outline: auto 1px`로 전부 outline 렌더링 확인 |
| P42 | Enter로 포커스된 링크 실행 | URL/해시 변경, 대상 섹션으로 이동 | **PASS** — "Projects" 링크(`#research`)에 포커스 후 Enter → `location.hash`가 `''`→`'#research'`로 변경, `#research` 섹션이 뷰포트 상단 139px 지점까지 스크롤되어 보임 확인 |
| P26 | 앵커/페이지 이동 후 뒤로 가기 | 이전 위치로 복귀 | **PASS** — 홈(`/`) → `/writing/checkmite/` 이동 후 `goBack()` → `/`로 정확히 복귀 |
| P24/P25 | `/writing/edu-msa/` 직접 URL 접근 + 새로고침 | 동일 콘텐츠 유지, 오류 페이지 아님 | **PASS** — 접근 시/새로고침 후 모두 타이틀 "edu-msa: 교육청 내부 코드 공유·자동 서비스화 MSA 플랫폼 \| 05solar Portfolio" 동일 |
| P23 | 홈 복귀 링크 존재 | 헤더에 Home 링크 | **PASS** — 헤더 "Home" 링크가 사이트 루트(`https://05solar.github.io/BP-05/`)로 연결됨 확인 |
| P22 | 메뉴 도착 위치 | 표시 이름에 맞는 섹션으로 이동 | **PASS** — About→`#hero`, News→`#news`, Projects→`#research`, Writing→`#writing`로 메뉴 텍스트와 앵커 대상이 일치 |

캡처: `docs/screenshots/fig01_home_1440.png`(1440px 홈) · `fig02_home_390.png`(390px 홈) · `fig03_home_768.png`(768px 홈) · `fig04_checkmite_390_fixed.png`(수정 후 CheckMite 390px 전체) · `fig04b_checkmite_390_before_fix.png`(수정 전 넘침 상태) · `fig05_keyboard_focus_1440.png`(Tab 포커스) · `fig06_zoom200.png`(200% 확대 근사) · `fig07_mobile_menu_390.png`(390px 메뉴)

## 문제 해결과 재검증 — CheckMite 글 390px 가로 넘침 (P36→P32 연쇄 영향)

- **관찰**: 2차 실측 1차 시도에서 `/writing/checkmite/`를 390px로 열자 `document.documentElement.scrollWidth`(467px)가 `clientWidth`(390px)보다 77px 커서 페이지 전체가 가로로 스크롤됨. 홈 등 다른 페이지는 정상이었음.
- **원인 분석**: DOM을 요소별로 대조한 결과 두 가지 원인이 겹쳐 있었음.
  1. `site/assets/css/main.css`의 `.article-content table { display:block; overflow-x:auto; }` 규칙이 `<table>` 자체에 걸려 있었는데, `display:block`으로 바뀐 테이블의 하위 `tr`/`td`는 여전히 `display:table-row`/`table-cell`로 남아 테이블 박스의 클리핑을 따르지 않고 부모 밖으로 새어나감 (table의 `offsetWidth`는 310px로 정상이었지만, 내부 `tr`의 `getBoundingClientRect().right`는 479~503px까지 나가는 것으로 확인).
  2. CheckMite 글의 `$$...$$` KaTeX 블록 수식(`stride=tile_size×(1−overlap)` 등)을 렌더링하는 벤더 CSS(`site/themes/template/static/vendor/katex/katex.min.css`)에 `.katex-display`의 `overflow-x` 규칙이 없어, 긴 수식이 그대로 뷰포트를 넘어감 (culprit 요소 탐지 결과 `<semantics>`/`<mrow>`가 `right: 495~547px`까지 확장됨을 확인). 실제로 표 수정만으로는 페이지 넘침이 그대로(467px) 남아 있어 수식이 진짜 원인임을 재확인.
- **수정**:
  - `site/layouts/_default/_markup/render-table.html` 신규 — Hugo 표 렌더 훅으로 `<table>`을 `.table-scroll` wrapper `<div>`로 감싸 스크롤을 wrapper가 담당하도록 변경.
  - `site/assets/css/main.css` — `.article-content .table-scroll`에 `overflow-x:auto`, `.article-content table`은 `width:max-content; min-width:100%`로 조정. `.article-content .katex-display`에 `overflow-x:auto; overflow-y:hidden` 추가.
  - 커밋 `2785d03`: `fix: 390px에서 CheckMite 글의 표·KaTeX 수식으로 인한 페이지 가로 넘침 해결`
- **재검증**: 로컬(`hugo server`)과 실제 배포 파이프라인(`python .github/pages_build.py --build`) 양쪽에서 재빌드 후 puppeteer로 홈/Writing 목록/CheckMite/edu-msa/JBIG 5개 페이지 × 1440·768·390px 3개 폭을 전수 재측정 — **15개 조합 전부 overflow 0px**. push 후 Actions 실행(`42357509228`, 커밋 `2785d03`) 성공 확인, 배포된 실제 URL에서도 동일하게 overflow 0px 재확인 (수정 전/후 비교: `docs/screenshots/fig04b_checkmite_390_before_fix.png` → `fig04_checkmite_390_fixed.png`).
- **남은 한계**: 이번 수정은 마크다운 표·KaTeX 블록 수식 2종에 한정된 대응이며, 향후 매우 긴 단일 토큰(예: 줄바꿈 없는 영문 URL)이 본문에 직접 들어가는 경우는 별도 확인이 필요함.
