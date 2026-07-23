# EU Vignette

An iOS app for planning European motorway travel, tracking digital vignettes, and opening official government purchase portals.

## Features

- **Map** — Interactive Europe map with a 12-month timeline slider; countries color-coded by vignette status on any selected date
- **Countries** — Browse 9 vignette-required countries (Austria, Switzerland, Slovenia, Hungary, Czech Republic, Slovakia, Romania, Bulgaria, Moldova) with pricing, tips, and official shop links
- **My Vignettes** — Track purchased vignettes by license plate with expiry dates and status
- **Trip Planner** — Select countries on your route and see which vignettes you need
- **Expiry Reminders** — Local notifications before vignettes expire

### Map color legend

| Color | Meaning |
|-------|---------|
| Green | Valid vignette on the selected date |
| Yellow | Vignette valid but expiring within 30 days |
| Red | Vignette required but none valid |
| Gray | No motorway vignette required |
- **Settings** — Save a default license plate and manage notification preferences

## Requirements

- macOS with **Xcode 16** or later
- **iOS 17.0+** device or simulator
- Apple Developer account (for running on a physical device)

## Build on your Mac

1. Clone the repository:

```bash
git clone https://github.com/unefoutuebete/eu-vignette.git
cd eu-vignette
```

### HTML preview (no Mac required)

Open the interactive browser demo on your phone or desktop — includes the map with timeline slider:

**https://htmlpreview.github.io/?https://raw.githubusercontent.com/unefoutuebete/eu-vignette/cursor/map-timeline-f827/demo/index.html**

2. Open the Xcode project:

```bash
open EuVignette.xcodeproj
```

3. In Xcode, select the **EuVignette** scheme and choose an iPhone simulator or your connected device.

4. Set your **Development Team** under Signing & Capabilities (required for device builds):
   - Select the EuVignette target
   - Open **Signing & Capabilities**
   - Choose your team from the **Team** dropdown

5. Build and run: **Product → Run** (⌘R)

## Project structure

```
eu-vignette/
├── EuVignette.xcodeproj/     # Xcode project
├── EuVignette/
│   ├── EuVignetteApp.swift   # App entry point
│   ├── ContentView.swift     # Tab navigation
│   ├── Models/               # SwiftData models
│   ├── Data/                 # Country catalog
│   ├── Services/             # Notifications, settings
│   ├── Views/                # SwiftUI screens
│   └── Assets.xcassets/      # App icon and colors
└── README.md
```

## Tech stack

- **SwiftUI** for the user interface
- **SwiftData** for local persistence (vignettes and trips)
- **UserNotifications** for expiry reminders

## Important notes

- This app does **not** process payments. It links to official government portals for vignette purchases.
- Vignette prices in the app are indicative — always confirm current tariffs on the official portal before buying.
- Add an App Icon image (1024×1024) to `EuVignette/Assets.xcassets/AppIcon.appiconset/` before App Store submission.

## License

MIT
