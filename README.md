# BP-05 — 개인 소개 포트폴리오 사이트

Hugo + [Celadon 테마](https://github.com/Yajie-Xu/hugo-celadon)로 만든 개인 소개 웹사이트입니다.
수업 제공 `prepare_github_pages.py` 스크립트로 배포 구조를 구성했습니다.

- 공개 사이트: https://05solar.github.io/BP-05/
- 저장소: https://github.com/05solar/BP-05

## 저장소 구조

| 경로 | 설명 |
|------|------|
| `site/` | 실제 배포되는 사이트 (콘텐츠·데이터·설정) |
| `site/hugo.toml` + `site/pages.json` | 사이트 설정 (빌드 시 두 파일을 함께 사용) |
| `archetypes/` `assets/` `layouts/` `static/` 등 루트 | Celadon 테마 원본 (Download ZIP 그대로) |
| `prepare_github_pages.py` | 수업 제공 배포 준비 스크립트 (v3.1) |
| `.github/workflows/hugo-pages.yml` | 스크립트가 생성한 배포 워크플로 (Hugo 0.167.0 고정) |
| `.github/pages_build.py` | 워크플로가 호출하는 빌드 스크립트 (prepare 스크립트 사본) |

## 필요한 도구

| 도구 | 버전 | 비고 |
|------|------|------|
| Python | 3.9+ | 빌드 스크립트 실행용 |
| Hugo (extended) | 0.167.0 (배포 기준) / 0.120.0 이상 | 로컬 미리보기용 |
| Git | 최신 | |

Hugo 설치(Windows): `winget install Hugo.Hugo.Extended`

## 로컬에서 확인하기

```bash
git clone https://github.com/05solar/BP-05.git
cd BP-05
```

배포와 동일한 빌드 (결과물 `public/`):

```bash
python .github/pages_build.py --build
```

실시간 미리보기 (저장 시 자동 새로고침):

```bash
cd site
hugo server --config hugo.toml,pages.json --themesDir themes --theme template
```

브라우저에서 http://localhost:1313/BP-05/ 접속.

## 수정과 재배포

| 수정 대상 | 파일 위치 |
|-----------|-----------|
| 사이트 기본 설정(제목·소개문) | `site/hugo.toml` |
| 자기소개·프로필 | `site/data/profile.yaml` |
| 소식(News) | `site/data/news.yaml` |
| 활동/프로젝트(Research 섹션) | `site/data/research.yaml` |
| 글 목록 메타 | `site/data/writing.yaml` |
| 글 본문 | `site/content/writing/*.md` |
| 이미지 | `site/static/images/` |
| 글꼴·스타일 오버라이드 | `site/assets/css/main.css` |
| 테마(레이아웃) | `site/themes/template/` |

재배포 절차:

1. 파일 수정 후 `git add` → `git commit` → `git push origin main`
2. push되면 GitHub Actions(`.github/workflows/hugo-pages.yml`)가 자동 실행됨
   - 확인: 저장소의 **Actions 탭** → "Deploy Hugo to GitHub Pages" 실행 상태
3. 실행 성공 후 https://05solar.github.io/BP-05/ 에서 변경 반영 확인 (캐시로 안 보이면 강력 새로고침 Ctrl+F5)

GitHub Pages 설정: Settings → Pages → Build and deployment → Source = **GitHub Actions**

## 출처와 라이선스

- 테마: [Celadon](https://github.com/Yajie-Xu/hugo-celadon) by Yajie Xu — MIT License ([LICENSE.txt](LICENSE.txt), 원본 안내는 [site/themes/template/README.md](site/themes/template/README.md))
- 글꼴: [Pretendard](https://github.com/orioncactus/pretendard) — SIL Open Font License 1.1 (jsDelivr CDN 로드)
- 배포 스크립트: 수업 제공 `prepare_github_pages.py` v3.1
- 사이트 콘텐츠(소개·활동 글)는 본인이 직접 작성. AI 도구를 활용한 부분은 제출 보고서의 AI 활용 기록에 명시.
