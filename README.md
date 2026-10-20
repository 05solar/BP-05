# BP-05 — 개인 소개 포트폴리오 사이트

Hugo + [Celadon 테마](https://github.com/Yajie-Xu/hugo-celadon)로 만든 개인 소개 웹사이트입니다.

- 공개 사이트: https://05solar.github.io/BP-05/
- 저장소: https://github.com/05solar/BP-05

## 필요한 도구

| 도구 | 버전 | 비고 |
|------|------|------|
| Hugo (extended) | 0.148.2 (최소 0.120.0) | 배포 워크플로와 동일 버전 권장 |
| Git | 최신 | |

Hugo 설치(Windows): `winget install Hugo.Hugo.Extended`

## 로컬에서 확인하기

```bash
git clone https://github.com/05solar/BP-05.git
cd BP-05
hugo server
```

브라우저에서 http://localhost:1313/BP-05/ 접속.

배포와 동일한 정적 빌드만 확인하려면:

```bash
hugo --gc --minify
# 결과물: public/
```

## 수정과 재배포

| 수정 대상 | 파일 위치 |
|-----------|-----------|
| 사이트 기본 설정(제목·baseURL·섹션) | `hugo.toml` |
| 자기소개·프로필 | `data/profile.yaml` |
| 소식(News) | `data/news.yaml` |
| 활동/프로젝트(Research 섹션) | `data/research.yaml` |
| 글 목록 메타 | `data/writing.yaml` |
| 글 본문 | `content/writing/*.md` |
| 이미지 | `static/images/` |
| 테마(레이아웃·스타일) | `themes/celadon/` |

재배포 절차:

1. 파일 수정 후 `git add` → `git commit` → `git push origin main`
2. push되면 GitHub Actions(`.github/workflows/hugo.yml`)가 자동 실행됨
   - 확인: 저장소의 **Actions 탭** → "Deploy Hugo site to Pages" 실행 상태
3. 실행 성공 후 https://05solar.github.io/BP-05/ 에서 변경 반영 확인 (캐시로 안 보이면 강력 새로고침 Ctrl+F5)

GitHub Pages 설정: Settings → Pages → Build and deployment → Source = **GitHub Actions**

## 출처와 라이선스

- 테마: [Celadon](https://github.com/Yajie-Xu/hugo-celadon) by Yajie Xu — MIT License ([themes/celadon/LICENSE.txt](themes/celadon/LICENSE.txt))
- 사이트 콘텐츠(소개·활동 글)는 본인이 직접 작성. AI 도구를 활용한 부분은 제출 보고서의 AI 활용 기록에 명시.
