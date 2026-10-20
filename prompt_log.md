# Prompt Log — BP-05 작업 대화 기록

사용자가 입력한 프롬프트와 그에 대한 응답 요약을 시간순으로 기록한다.
**규칙: 매 작업(대화 턴)이 끝날 때마다 아래 형식으로 항목을 추가한다.** (agent.md 3절 참조)

형식:

```
## N. (날짜) 프롬프트 요약
- **프롬프트**: 사용자가 입력한 요청 원문 또는 핵심 요약
- **응답/작업 요약**: 수행한 작업과 결과
- **산출물**: 생성·수정된 파일, 실행한 명령 등
```

> 참고: 이 기록은 과제 보고서의 AI 활용 기록(P66~P70: 도구·날짜·목적·요청 원문·반영 위치) 증빙 소스로 활용할 수 있다.

---

## 1. (2026-10-19) 채점 기준 PDF 정리
- **프롬프트**: `"C:\Users\이솔하\Downloads\2026_과제1_공개채점기준.pdf" 이거 파일 읽고 채점 기준 전부 정리해서 md 파일로 정리해줘`
- **응답/작업 요약**: PDF 12쪽 전체를 읽고 과제 개요(마감 2026-10-31 23:59, 공개 80점 + 비공개 20점), 공개 평가기준 8개 영역(P01~P80), 붙임 2(커밋 집계 기준)·붙임 3(보고서 규격)·붙임 4(증빙 기준)를 표 형식으로 정리함.
- **산출물**: `2026_과제1_채점기준.md` 생성

## 2. (2026-10-19) agent.md 작성 (DO/DON'T + Git 계정 규칙)
- **프롬프트**: `agent.md 파일 만들어서 이 채점 기준 md 파일을 기준으로 해야하는것과 하지 말아야할 것을 정리해줘 그리고 항상 commit push 할때는 lotus05f@gmail.com 단독계정으로 push 하도록 md 파일을 작성해줘`
- **응답/작업 요약**: 채점 기준 P01~P80을 기반으로 DO(빌드·배포, 자산·경로, 링크, 반응형·접근성, Git 관리, 콘텐츠, 보고서·AI 기록)와 DON'T(커밋 개수 채우기 금지, localhost 잔존 금지, 테마 예시 문구 방치 금지 등)를 정리. 0절에 모든 commit·push는 `lotus05f@gmail.com` 단독 계정으로만 수행하는 최우선 규칙을 명시. 당시 BP-05가 git 저장소가 아니어서 계정 설정은 보류하고 초기화 후 실행할 명령을 안내함.
- **산출물**: `agent.md` 생성

## 3. (2026-10-19) 원격 연동 + agent.md gitignore 처리
- **프롬프트**: `https://github.com/05solar/BP-05.git 이 계정으로 연동해놓는데 agent.md 파일은 올리지 않도록 gitignore 처리해줘`
- **응답/작업 요약**: `git init -b main`으로 저장소 초기화, 로컬 계정을 05solar / lotus05f@gmail.com으로 설정, origin을 `https://github.com/05solar/BP-05.git`으로 연결. `.gitignore`에 `agent.md`를 등록하고 `git check-ignore`로 제외 확인. 커밋·push는 아직 수행하지 않음(테마 ZIP·수업 스크립트 작업 이후 시작 예정).
- **산출물**: `.gitignore` 생성, git 저장소 초기화·원격 연결

## 4. (2026-10-19) 프롬프트 기록 파일 생성
- **프롬프트**: `내가 지금까지 입력한 프롬프트랑 그 대답에 대한 요약도 정리해서 항상 기록하는 md파일도 하나 만들어줘`
- **응답/작업 요약**: 지금까지의 대화 4건을 시간순으로 정리한 기록 파일을 생성하고, 이후 매 턴마다 항목을 추가하는 규칙을 agent.md 3절에 추가함.
- **산출물**: `prompt_log.md` 생성, `agent.md`에 기록 규칙 추가

## 5. (2026-10-20) hugo-celadon 테마 클론
- **프롬프트**: `https://github.com/Yajie-Xu/hugo-celadon.git 이거 클론 떠봐`
- **응답/작업 요약**: BP-05 하위에 `hugo-celadon/` 폴더로 테마를 클론함. 테마 정보 확인: Celadon — 원페이지 포트폴리오 테마, MIT 라이선스, Hugo 최소 버전 0.120.0, 다크모드·수식·프로젝트 섹션 지원. 과제 절차는 ZIP 다운로드 기준이므로 테마의 `.git` 이력을 제거하고 사용하는 후속 처리가 필요함(원본 테마 이력은 유효 커밋에서 제외됨 — P51).
- **산출물**: `hugo-celadon/` 클론 (archetypes, assets, exampleSite, layouts, static, theme.toml 등)

## 6. (2026-10-20) 클론한 테마 삭제
- **프롬프트**: `그래 클론한거 다 지워봐`
- **응답/작업 요약**: 클론했던 `hugo-celadon/` 폴더를 통째로 삭제함. BP-05에는 `.git`, `.gitignore`, `2026_과제1_채점기준.md`, `agent.md`, `prompt_log.md`만 남음. 테마는 과제 절차대로 원본 저장소의 Download ZIP으로 다시 받을 예정.
- **산출물**: `hugo-celadon/` 삭제

## 7. (2026-10-20) 테마 ZIP 압축 해제·프로젝트 배치
- **프롬프트**: `"C:\Users\이솔하\Downloads\hugo-celadon-main.zip" 이거를 뭐 해봐 압축 풀어서 해봐`
- **응답/작업 요약**: ZIP을 스크래치 폴더에 풀어 내용 확인 후, `hugo-celadon-main/`의 테마 파일 전체(.github 워크플로, archetypes, assets, exampleSite, images, layouts, static, theme.toml, LICENSE.txt 등)를 BP-05 루트로 복사함. 테마의 .gitignore와 기존 .gitignore(agent.md 제외)를 병합하고 Hugo 빌드 산출물(public/, resources/, .hugo_build.lock) 제외 규칙 추가. agent.md가 여전히 ignore되는 것 확인. 테마 동봉 demo.yml 워크플로는 hugo-version 'latest'(P08 위반 소지)·baseURL이 /hugo-celadon/ 고정(P10·P16 위반)·gh-pages 브랜치 배포(과제는 Pages Source=GitHub Actions 요구) 문제가 있어 추후 수정 필요함을 확인.
- **산출물**: 테마 파일 BP-05 루트 배치, `.gitignore` 병합 갱신

## 8. (2026-10-20) 사이트 구조화·배포 워크플로·첫 push
- **프롬프트**: `그래 진행해봐`
- **응답/작업 요약**: (1) 테마 파일을 `themes/celadon/`으로 분리하고 exampleSite의 content·data·static·hugo.toml을 루트로 승격하는 표준 Hugo 구조로 재구성. (2) `hugo.toml`에서 themesDir 제거, baseURL을 `https://05solar.github.io/BP-05/`로, languageCode를 `ko`로, title을 `05solar Portfolio`로 변경 (P10·P16·P48). (3) 테마 demo.yml 삭제 후 공식 Pages 배포 워크플로 `.github/workflows/hugo.yml` 작성 — Hugo 0.148.2 extended 고정(P08), main push 자동 실행(P03), actions/deploy-pages 방식(P05). (4) README에 도구 버전·설치·빌드 명령·수정 파일 위치·재배포 절차·테마 라이선스 고지 작성 (P56·P57·P58). (5) winget으로 Hugo 0.148.2 extended 설치 후 로컬 빌드 성공 확인 — 33페이지 생성, `lang=ko`·`/BP-05/` 경로 정상. (6) lotus05f@gmail.com 계정으로 의미 단위 커밋 5개 생성 후 origin/main 첫 push 완료.
- **산출물**: `themes/celadon/` 구조, `hugo.toml` 수정, `.github/workflows/hugo.yml`, `README.md`, 커밋 5개 push (2cc9cbe~dc214b1)
- **남은 일**: GitHub 웹에서 Settings → Pages → Source를 **GitHub Actions**로 설정(수동 필요), 이후 Actions 성공 확인. 콘텐츠는 아직 테마 예시(가상 인물) 상태 — P80을 위해 본인 내용으로 교체 필요.

## 9. (2026-10-20) 커밋·push 상태 확인
- **프롬프트**: `일단 커밋하고 push 해봐 lotus05f@gmail.com 단독계정으로만 진행해`
- **응답/작업 요약**: 작업 트리가 깨끗한 상태(미커밋 변경 없음)였고, 기존 커밋 6개 모두 `05solar <lotus05f@gmail.com>` 단독 계정으로 작성되어 origin/main에 push 완료된 것을 확인함. 이 확인 기록을 추가로 커밋·push함.
- **산출물**: 커밋 작성자 검증, prompt_log 갱신 커밋 push

## 10. (2026-10-20) PF 포트폴리오의 자기소개로 교체
- **프롬프트**: `C:\Users\이솔하\Desktop\PF 여기에 있는 내용 중에서 자기 소개 부분만 가져와서 교체한 후에 commit 하고 push 해줘`
- **응답/작업 요약**: PF(React/Vite 포트폴리오)의 `src/components/Hero.tsx`와 `src/data/site.ts`에서 자기소개 부분을 추출 — 이름(이솔하/leeosolha), 태그라인(풀스택 개발자), 전북대 IT지능정보공학과 재학, 풀스택 웹 개발·AI 활용 관심, LLM·RAG·MCP 기반 AI 서비스 개발 경험, GitHub(05solar)·LinkedIn 링크, 이메일. 이를 `data/profile.yaml`(이름·요약·소속·관심 목록·링크)과 `hugo.toml` params(description·email·location)에 반영해 테마 데모 인물(Dr. Celadon)을 교체함. 로컬 빌드 후 홈 HTML에 '이솔하' 4회 등장, 'Dr. Celadon'·'alex@example'·'Tampa' 0회 확인.
- **산출물**: `data/profile.yaml` 교체, `hugo.toml` params 수정, 커밋·push

## 11. (2026-10-20) 로컬 실행 오류 해결 안내
- **프롬프트**: 로컬 확인 명령 질문 후 `npm run dev` ENOENT 오류와 `hugo` 명령 인식 불가 오류 공유
- **응답/작업 요약**: (1) BP-05는 Hugo 사이트라 npm/package.json이 없는 것이 정상이며 `hugo server`로 실행해야 함을 안내. (2) `hugo` 미인식 원인은 winget 설치 이전에 열린 PowerShell 창의 PATH 미갱신 — 새 터미널을 열거나 `$env:Path` 갱신 후 실행하도록 안내. 접속 주소는 http://localhost:1313/BP-05/. (3) npm 실행 시도가 만든 불필요한 `package-lock.json`(84B)을 삭제해 작업 트리를 깨끗하게 유지함 (P55).
- **산출물**: `package-lock.json` 삭제, 로컬 실행 방법 안내

## 12. (2026-10-20) 새 터미널에서도 hugo 미인식 — 원인 진단
- **프롬프트**: 새 터미널을 열었는데도 `hugo` 명령이 인식되지 않는다는 오류 공유
- **응답/작업 요약**: 사용자 PATH 레지스트리에 Hugo 설치 경로(`...\WinGet\Packages\Hugo.Hugo.Extended_...`)가 정상 등록되어 있고 hugo.exe도 존재함을 확인. 원인은 이미 실행 중이던 상위 프로그램(VS Code·터미널 앱)의 새 탭이 갱신 전 PATH를 상속받기 때문으로 진단. 현재 세션에서 `$env:Path`에 설치 경로를 추가해 즉시 실행하는 방법과, 터미널 앱 전체 재시작으로 근본 해결하는 방법을 안내함.
- **산출물**: 진단 및 해결 방법 안내 (파일 변경 없음)
