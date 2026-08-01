# Ali Baziar — Portfolio

Bilingual (English / Persian) freelance portfolio for **Ali Baziar**, a Python Automation & AI Integration Developer focused on business solutions for small teams and startups.

Built with Flutter for web (and other targets). Single-page layout with scroll sections, project case-study pages, RTL support, and dark/light themes.

---

## Live demo

Deploy to GitHub Pages or Firebase Hosting (see [Deploy](#deploy) below).

---

## Highlights

- **Freelance positioning** — business outcomes over generic “full-stack” branding
- **Bilingual UI** — English and Persian with full RTL layout
- **Dark & light theme** — toggle from the navigation bar
- **Responsive layout** — desktop, tablet, and mobile (including a mobile contact FAB)
- **Project case studies** — detail pages with problem, solution, and business results
- **Deploy-ready** — GitHub Actions workflow and Firebase Hosting config included

---

## Page sections

| Section | Description |
|---------|-------------|
| **Hero** | Name, role, tagline, availability badge, CTAs, stats, tech marquee |
| **About** | Professional bio and work highlights |
| **Services** | Five freelance service packages with example client problems |
| **Projects** | Featured business projects with case-study detail pages |
| **Experience** | Work history with links to related projects |
| **Skills** | Grouped technologies (supporting stack, not the main pitch) |
| **Education** | Academic background |
| **Contact** | Email, location, social links |

Default section order:

`Hero → About → Services → Projects → Experience → Skills → Education → Contact`

---

## Featured projects

1. **AI Language Learning Platform** — AI tutors, courses, creator monetization  
2. **Product Tracking System** — barcode traceability from production to returns  
3. **Warehouse Management System** — multi-warehouse inventory and reporting  
4. **Business Process Automation Suite** — forms, Excel→printer, scan-to-label tools  

Additional projects are available via “View more” on the homepage.

---

## Tech stack

| Layer | Tools |
|-------|--------|
| **App** | Flutter 3.x / Dart 3.11+ |
| **State** | [Provider](https://pub.dev/packages/provider) — theme & locale |
| **UI** | [flutter_animate](https://pub.dev/packages/flutter_animate), [google_fonts](https://pub.dev/packages/google_fonts) |
| **Icons** | [flutter_svg](https://pub.dev/packages/flutter_svg) + Simple Icons CDN |
| **Links** | [url_launcher](https://pub.dev/packages/url_launcher) |
| **i18n** | Flutter gen-l10n (ARB files) |

---

## Getting started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- Chrome (for web) or a connected device/emulator

### Install & run

```bash
flutter pub get
flutter gen-l10n
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

---

## Customize content

Most editable content lives in **`lib/data/portfolio_data.dart`**.

| File / folder | Purpose |
|---------------|---------|
| `lib/data/portfolio_data.dart` | Profile, bio, services, projects, skills, experience, education, stats |
| `lib/l10n/app_en.arb` | English UI strings (nav, section titles, CTAs) |
| `lib/l10n/app_fa.arb` | Persian UI strings |
| `assets/images/profile.png` | Profile photo |
| `assets/images/projects/` | Project cover images (16:9 recommended; portrait shots use `portraitCover: true`) |
| `docs/freelance-profiles.md` | Copy for LinkedIn, Upwork, PeoplePerHour, GitHub README |

### Bilingual fields

Content fields in `portfolio_data.dart` use the `L('English', 'فارسی')` helper:

```dart
title: L('Product Tracking System', 'سامانه رهگیری محصولات'),
```

After editing ARB files, regenerate localizations:

```bash
flutter gen-l10n
```

### Adding a project

1. Add cover image(s) under `assets/images/projects/`.
2. Append a `ProjectItem` in `portfolio_data.dart`.
3. Set `isFeatured: true` for homepage visibility (max 4 shown initially).
4. Use `PortfolioData.orderedProjects` order via the `featuredOrder` list for homepage ranking.

### Project detail structure

Each project supports:

- `overview` — summary  
- `challenge` — client problem  
- `solution` — what was built  
- `results` — business value  
- `tags`, `galleryAssets`, optional `url` for live demo  

---

## Project structure

```
lib/
├── app.dart                 # MaterialApp, theme, locale
├── main.dart
├── data/
│   ├── portfolio_data.dart  # ← main content file
│   ├── localized_text.dart  # L('en', 'fa') helper
│   └── skill_icons.dart     # skill → icon mapping
├── l10n/                    # ARB + generated localizations
├── providers/               # ThemeProvider, LocaleProvider
├── routes/                  # Home + project detail routing
├── screens/
│   ├── home_screen.dart
│   └── project_detail_screen.dart
├── sections/
│   ├── hero_section.dart
│   ├── about_section.dart
│   ├── services_section.dart
│   ├── projects_section.dart
│   ├── experience_section.dart
│   ├── skills_section.dart
│   ├── education_section.dart
│   └── contact_section.dart
├── theme/                   # AppColors, AppTheme
└── widgets/                 # NavBar, avatar, background, shared UI

docs/
└── freelance-profiles.md      # Platform profile copy (Upwork, LinkedIn, …)

scripts/
├── build_web.ps1              # Web build helper (Windows)
└── deploy_firebase.ps1        # Firebase deploy helper

.github/workflows/
└── deploy.yml                 # GitHub Pages CI on push to main
```

---

## Deploy

### GitHub Pages

1. Push the repo to GitHub.
2. Enable **GitHub Pages** (Settings → Pages → source: **GitHub Actions**).
3. Push to `main` — `.github/workflows/deploy.yml` builds and publishes automatically.

The workflow uses:

```bash
flutter build web --release --base-href /Portfolio/
```

Adjust `--base-href` in the workflow if your repo name or deployment path differs. For a user/org site at the domain root, use `--base-href /`.

**Windows helper:**

```powershell
.\scripts\build_web.ps1 -BaseHref "/Portfolio/"
```

### Firebase Hosting

1. Install the [Firebase CLI](https://firebase.google.com/docs/cli).
2. Set your project ID in `.firebaserc`.
3. Build and deploy:

```bash
flutter build web --release
firebase deploy --only hosting
```

Or on Windows:

```powershell
.\scripts\deploy_firebase.ps1
```

Output is served from `build/web` (see `firebase.json`).

---

## Assets

- Place project images in `assets/images/projects/`.
- Set `imageAsset` (and optional `galleryAssets`) on each `ProjectItem`.
- Asset paths are declared in `pubspec.yaml` under `flutter.assets`.
- App icon: `assets/images/icon.png` (see `flutter_launcher_icons` in `pubspec.yaml`).

---

## Freelance platform copy

Ready-to-use profile text for international platforms is in:

**[`docs/freelance-profiles.md`](docs/freelance-profiles.md)**

Includes LinkedIn headline, Upwork title, PeoplePerHour intro, and GitHub profile README.

---

## License

Private portfolio project. All rights reserved unless otherwise noted.
