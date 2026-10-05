<!-- Vorlage für Anforderungen (D-005). Der Bootstrap legt sie unter
     docs/requirements/ ab. Überschriften folgen der Projektsprache; die
     deutsche Fassung steht in der Tabelle in D-005. Keys bleiben immer
     unübersetzt: F-<nr>, FA-<n>, NFA-<n>.
     Nach der Umsetzung ist das Dokument eingefroren (D-038): Es bekommt die
     Zeile „Umgesetzt“. Ersetzt es Verhalten eines früheren Features, nennt
     „Ersetzt“ die betroffenen FAs. -->

# F-<nr> — <feature name>

Ersetzt: <!-- F-<nr> FA-<n>, oder: nichts -->
Umgesetzt: <!-- PR #<nr> (<datum>), trägt die KI im PR vor dem Review ein -->

## Goal
<!-- 1–2 sentences: what and why -->

## Functional Requirements
<!-- numbered, individually testable; basis for E2E tests (D-004) -->
- FA-1: …
- FA-2: …

## Non-Functional Requirements
<!-- qualities: performance, accessibility, security, … -->
- NFA-1: …

## Technical Constraints
<!-- prescribed choices: APIs, packages, techniques. Constraints, not qualities. -->

## Tier Check
<!-- D-003: does this feature change login, user data or public exposure? -->
Tier before: <n> · after: <n>

## Out of Scope
<!-- deliberately not part of this feature -->
