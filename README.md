# Portfolio

A bilingual (English / Persian) personal portfolio built with Flutter. Single-page layout with project case studies, RTL support, and dark/light themes.

Inspired by modern portfolio templates such as Fastfolio.

## Features

- **Bilingual UI** — English and Persian with full RTL layout
- **Dark & light theme** — toggle from the navigation bar
- **Sections** — Hero, Projects, Skills, Experience, Education, Contact
- **Project case studies** — detail pages with overview, challenge, solution, and results
- **Responsive layout** — desktop, tablet, and mobile
- **Deploy-ready** — GitHub Pages workflow and Firebase Hosting config included

## Tech stack

- Flutter 3.x / Dart 3.11+
- [Provider](https://pub.dev/packages/provider) — theme & locale state
- [flutter_animate](https://pub.dev/packages/flutter_animate) — section animations
- [google_fonts](https://pub.dev/packages/google_fonts) — typography
- [flutter_svg](https://pub.dev/packages/flutter_svg) — skill brand icons (CDN)
- Flutter gen-l10n — ARB-based localization

## Getting started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- Chrome (for web) or a connected device/emulator

### Run locally

```bash
flutter pub get
flutter run -d chrome
```

Other targets:

```bash
flutter run -d windows
flutter run -d android
flutter run -d ios
```

### Analyze & test

```bash
flutter analyze
flutter test
```

## Customize content

Most editable content lives in one file:

| File | Purpose |
|------|---------|
| `lib/data/portfolio_data.dart` | Profile, projects, skills, experience, education |
| `lib/l10n/app_en.arb` / `app_fa.arb` | UI strings (nav labels, section titles, etc.) |
| `assets/images/profile.png` | Profile photo |
| `assets/images/projects/` | Project cover images (16:9 recommended) |

Bilingual fields use `L('English', 'فارسی')` in `portfolio_data.dart`.

After editing ARB files:

```bash
flutter gen-l10n
```

## Project structure

```
lib/
├── data/           # Portfolio content & skill icon map
├── l10n/           # Localization ARB + generated files
├── providers/      # Theme & locale providers
├── routes/         # App routing (home + project details)
├── screens/        # Home & project detail screens
├── sections/       # Page sections (hero, projects, skills, …)
├── theme/          # Colors & theme configuration
└── widgets/        # Nav bar, avatar, background, shared UI
```

## Deploy

### GitHub Pages

1. Push the repo to GitHub.
2. Enable **GitHub Pages** (Settings → Pages → source: **GitHub Actions**).
3. Push to `main` or `master` — the workflow in `.github/workflows/deploy-github-pages.yml` builds and deploys automatically.

Build command used by CI:

```bash
flutter build web --release --base-href "/<repo-name>/"
```

For a custom domain or root deployment, adjust `--base-href` accordingly.

### Firebase Hosting

1. Install the [Firebase CLI](https://firebase.google.com/docs/cli).
2. Set your project ID in `.firebaserc`.
3. Build and deploy:

```bash
flutter build web --release
firebase deploy --only hosting
```

Output is served from `build/web` (see `firebase.json`).

## Assets

- Add project covers to `assets/images/projects/` and set `imageAsset` on each `ProjectItem`.
- Paths are declared in `pubspec.yaml` under `flutter.assets`.

## License

Private portfolio project. All rights reserved unless otherwise noted.
