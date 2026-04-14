# DESIGN.md

# Project Vidyalaxmi: Cyber-India Agent Edition
## Strategic Instruction for K-12 STEM & Social Studies Gamification

### 1. Vision & Core Philosophy
Project Vidyalaxmi is a secular, Indo-futuristic educational ecosystem. It bridges the gap between **Vidya** (Knowledge) and **Laxmi** (Prosperity) by transforming rote learning into "Active-Play."

- **Identity:** High-octane, gamified, and aspirational.
- **Tone:** Encouraging, cool, and technically sharp.
- **Primary Objective:** Build deep conceptual understanding in STEM and Social Studies (Geography, History, Civics, Economics).

### 2. Design System: "Z-Period" Aesthetic
All UI and visual descriptions generated must follow these rules:
- **Atmosphere:** Dark Mode / AMOLED Black (`#050505`).
- **Primary Glow:** Neon Cyan (`#00F2FF`) for STEM/Logic elements.
- **Secondary Glow:** Cyber Magenta (`#FF00E5`) for Rewards/Action elements.
- **Tertiary Glow:** Neon Green (`#39FF14`) for Growth/Success states.
- **Typography:** Lexend (modern, high readability).

### 3. The Mentor Trinity (Original IPs)
Use these characters as the "Teachers" within the app:
1. **Zayn (The Fixer):** Tech-wear enthusiast. Expert in Physics and Tech. Vibe: Cool older brother.
2. **Arya (The Speedster):** Athletic, uses a digital logic-staff. Expert in Math and Economics. Vibe: High-energy leader.
3. **Dhara (The Guardian):** Solarpunk aesthetic. Expert in Biology, Geography, and Civics. Vibe: Calm, wise, and grounded.

### 4. Subject Integration & Quest Logic
- **STEM:** Focus on "Sandbox" mechanics. Instead of lectures, students manipulate variables (gravity, chemical bonds, logic gates) to solve puzzles.
- **Social Studies:** - **Geography:** 3D "Digital Twin" exploration via virtual drones.
    - **History:** RPG mysteries set in historical eras (Mauryan, Industrial, etc.).
    - **Civics:** "City-Manager" sims for governing a Digital Village Council.
    - **Economics:** Trade and supply-chain mini-games using L-Coins.

### 5. The "Learning Loop" Requirements
Every module generated must include:
1. **The Hook:** A 60-second high-energy "Jingle Lesson" concept (Lyrics + Beat description).
2. **The Quest:** An interactive gaming challenge with clear win/loss states.
3. **The Adaptive Logic:** Define how the difficulty shifts if a student is "Bored" (too fast) or "Frustrated" (multiple fails).
4. **The Scroll:** A Manga-style summary generated at the end for revision.

### 6. Technical Execution Directives (For Code Generation)
- **Frontend:** Generate Flutter code using the `DESIGN.md` tokens.
- **State:** Use Riverpod for tracking user behavior and "Knowledge Gems."
- **Backend:** Use Python/FastAPI logic for the Adaptive Difficulty Loop (ADL).
- **Animations:** Prefer Rive or Lottie JSON formats for lightweight motion.

### 7. Constraints
- **NO Religious Imagery:** Keep symbols geometric, digital, or futuristic.
- **NO Rote Testing:** Avoid multiple-choice questions where possible; prefer drag-and-drop, sliders, and logic-puzzles.
- **Language Neutrality:** The logic must be expandable to Telugu, Hindi, English, and other regional languages.


> Single source of truth for all visual and UX decisions. All components, screens,
> and animations must derive their values from this document.

---

## 1. Visual Atmosphere

- **Mood:** High-octane, futuristic, cinematic, and educational.
- **Density:** Spacious (comfortable for kids), but with sharp, technical edges.
- **Philosophy:** "Indo-Futurism" — traditional Indian vibrant colors meeting a Cyberpunk digital grid.
- **References:** Duolingo (habit loops), Valorant (high-contrast UI), Akira (neon manga aesthetic).

---

## 2. Color Palette — Cyber-India Spectrum


| Token             | Hex       | Role                                        |
| ----------------- | --------- | ------------------------------------------- |
| `colorBase`       | `#050505` | Background surface — Deep Space Black       |
| `colorSurface`    | `#0F1117` | Card/panel background — slightly lifted     |
| `colorSurfaceAlt` | `#1A1D27` | Input fields, secondary panels              |
| `colorPrimary`    | `#00F2FF` | Neon Cyan — buttons, active states, links   |
| `colorSecondary`  | `#FF00E5` | Cyber Magenta — "Slice" mechanics, rewards  |
| `colorSuccess`    | `#39FF14` | Neon Green — correct feedback, growth       |
| `colorWarning`    | `#FF3131` | Bright Red — misconception monsters, errors |
| `colorGold`       | `#FFD700` | L-Coin currency, streak fire                |
| `colorText`       | `#EAEAEA` | Primary text                                |
| `colorTextMuted`  | `#6B7280` | Secondary/disabled text                     |


### Subject-Color Mapping


| Subject Domain | Glow Color | Mentor |
| -------------- | ---------- | ------ |
| Physics & Tech | `#00F2FF`  | Zayn   |
| Math & Logic   | `#FF00E5`  | Arya   |
| Bio & Social   | `#39FF14`  | Dhara  |


---

## 3. Typography Rules

- **Font Family:** `Lexend` (Sans-serif, high readability for children and neurodiverse learners).
- **Fallback:** `Inter`, `system-ui`
- **Loading:** Preloaded via `google_fonts` package.

### Type Scale


| Token         | Size | Weight          | Usage                              |
| ------------- | ---- | --------------- | ---------------------------------- |
| `textH1`      | 40px | Bold (700)      | Level titles, screen headings      |
| `textH2`      | 24px | Semi-bold (600) | Quest instructions, section titles |
| `textBody`    | 18px | Regular (400)   | Notes, dialogues, body copy        |
| `textCaption` | 14px | Regular (400)   | Labels, metadata                   |
| `textMicro`   | 12px | Medium (500)    | Badges, tags, coin counts          |


### Line Height

- Headings: `1.2`
- Body: `1.6`
- Captions: `1.4`

---

## 4. Component Stylings

### ZButton (Primary Action)

```
Background:    rgba(255, 255, 255, 0.10)   ← 10% opacity white
Backdrop Blur: 10px
Border:        1px solid #00F2FF
Border Radius: 12px
Padding:       14px 28px
Text:          #00F2FF, Lexend Semi-bold 18px
Box Shadow:    0 0 16px rgba(0, 242, 255, 0.35)
Active State:  scale(0.96) + shadow reduce
Hover State:   shadow intensity × 1.5
```

### ZButton (Secondary / Magenta)

```
Border:     1px solid #FF00E5
Text:       #FF00E5
Box Shadow: 0 0 16px rgba(255, 0, 229, 0.35)
```

### ZCard (Content Surface)

```
Background:    #0F1117
Border:        1px solid rgba(255, 255, 255, 0.06)
Border Radius: 16px
Padding:       20px
Box Shadow:    0 0 24px [subject-color] at 20% opacity
```

### ZProgressBar (Segmented)

```
Track:          #1A1D27
Fill:           subject-color gradient
Segments:       divided by thin #050505 gaps (2px)
Animation:      pulse at 1.5s interval when charging (brightness 80%→120%)
Border Radius:  8px
Height:         10px
```

### ZInput

```
Background:    #1A1D27
Border:        1px solid rgba(0, 242, 255, 0.30)
Border Radius: 10px
Padding:       12px 16px
Focus Border:  1px solid #00F2FF + glow shadow
Text:          #EAEAEA, Lexend Regular 18px
```

### GemCounter / LCoinCounter

```
Icon:     Gold coin SVG with glow (0 0 8px #FFD700)
Text:     #FFD700, Lexend Bold 18px
Animation: roll-count up on earn event (300ms cubic-bezier spring)
```

### StreakBadge

```
Icon:        Lottie fire animation
Text:        #FF3131, Lexend Bold 20px
Pulse:       every 3s, scale 1.0 → 1.05 → 1.0
```

---

## 5. Interaction Principles

### Motion

- **Parallax Backgrounds:** Futuristic Indian city skyline with floating neon sigils.
  - Foreground layer moves at `1.0x`
  - Midground at `0.5x`  
  - Background at `0.2x`
- **All animations:** prefer `60fps`, use Rive state machines for character logic.

### Haptics


| Event          | Pattern                                  |
| -------------- | ---------------------------------------- |
| Correct answer | Short, sharp (50ms, intensity 0.7)       |
| Wrong answer   | Double buzz (80ms + 80ms, intensity 1.0) |
| Level-Up       | Long rumble (400ms, intensity 0.9)       |
| Tap / UI click | Minimal tick (20ms, intensity 0.3)       |
| Reward collect | Triple pulse (30ms×3, intensity 0.8)     |


### Transitions

- **Page navigation:** Spring physics — `stiffness: 400, damping: 30, mass: 1.0`
- **Menu pop-ups / modals:** Scale from `0.85` + fade in over `250ms`
- **Cards:** Hover lift — `translateY(-4px)` over `150ms`
- **Buttons:** Bounce on tap — scale `0.96` → `1.02` → `1.0` over `200ms`

### Boss Fight Feedback

- **Correct Slice:** Neon Green flash overlay (100ms) + particle burst + short haptic
- **Wrong Answer:** Screen shake (3 cycles, 8px amplitude, 200ms) + red flash + double buzz
- **Drag-and-Drop:** Item follows finger with `0.85` scale, drop target glows on hover

---

## 6. Screen-Specific Rules

### Skill Tree Map

- Node states: **locked** (gray `#2A2A2A`, no glow), **available** (primary color glow, pulse), **completed** (success color icon overlay)
- Connector lines: dashed `#2A2A2A` for locked, solid subject-color for unlocked
- Background: parallax city with floating geometric grid overlay

### Jingle Screen

- Full-screen immersive — hide all chrome
- Waveform visualizer: thin neon bars behind mentor character
- Lyrics: bottom overlay, active word highlights in `colorPrimary`
- Language flag chip in top-right for language switching

### Boss Fight Screen

- Timer bar at top — segmented ZProgressBar draining in `colorWarning`
- Lives: heart icons in top-right, animate out on loss
- Question area: ZCard centered, 80% screen width
- Drag targets: glow border on hover, bounce on correct drop

### Reward Screen

- Confetti: Lottie animation, colors from full palette
- L-Coin counter: large `textH1` in `colorGold`, roll-up animation
- Mentor character: celebration pose, scaled up to fill 60% height
- CTA button: ZButton primary "Continue Quest"

---

## 7. Asset Guidelines

### Characters (Zayn / Arya / Dhara)

- Format: Transparent PNG, minimum `512×512px`
- Poses required per character: `idle`, `teaching`, `celebrating`, `thinking`, `reacting_correct`, `reacting_wrong`
- Style: Flat-shaded anime/manhwa with neon outline strokes matching subject color
- Background: Always transparent

### Rive Animations

- All character animations use Rive state machines
- State inputs: `isIdle`, `isTalking`, `isReacting`, `emotion (enum: neutral/happy/sad/excited)`
- Max file size: `500KB` per character

### Lottie

- Confetti, coin burst, fire streak
- Max file size: `200KB`
- Colors must match palette tokens

---

## 8. Accessibility

- Minimum contrast ratio: `4.5:1` for body text, `3:1` for large text
- Touch targets: minimum `44×44px`
- All animations respect `prefers-reduced-motion`
- Screen reader labels on all interactive elements
- Lexend font chosen specifically for dyslexia and reading difficulty reduction

