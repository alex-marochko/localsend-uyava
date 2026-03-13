# LocalSend Uyava Fork

This repository is a fork of [localsend/localsend](https://github.com/localsend/localsend) focused on integrating [Uyava](https://uyava.io/) into LocalSend as:

- an architecture graph,
- a runtime debugging surface,
- a transfer-flow observability layer,
- and a lightweight form of living documentation.

This fork is meant for architecture exploration and instrumentation work. If you want the stock app for daily use, use the upstream LocalSend project and its releases.

![Uyava graph inside LocalSend](docs/assets/uyava-screenshot.png)

## How To View The Uyava Graph

To inspect the Uyava graph while LocalSend is running, open the `Uyava` tab in DevTools.

If you prefer a standalone viewer, or you want to use recording and replay features for debugging sessions, you can also connect through the Uyava desktop app available from [uyava.io](https://uyava.io/).

## Fork Status

- Upstream project: [localsend/localsend](https://github.com/localsend/localsend)
- Fork repository: [alex-marochko/localsend-uyava](https://github.com/alex-marochko/localsend-uyava)
- `origin`: this fork
- `upstream`: original LocalSend repository

The fork keeps attribution to the original project and follows its license. The goal here is not to replace upstream documentation, but to document what is different in this repository.

## Why This Fork Exists

LocalSend already has a clean, modular structure, but most of that architecture is not visible from outside the codebase. This fork adds Uyava so the app can expose:

- static module relationships,
- key UI and state surfaces,
- runtime lifecycle changes,
- transfer metrics,
- and send/receive event chains.

The purpose is pragmatic: make LocalSend easier to inspect, debug, optimize, and explain.

## What Is Different From Upstream

Compared to upstream LocalSend, this fork currently adds:

- a dedicated Uyava graph model for LocalSend modules and pages,
- runtime lifecycle instrumentation for modeled pages,
- richer event chains for send/receive flows,
- transfer-focused metrics and diagnostic nodes,
- and documentation describing the fork-specific architecture surface.

The app itself still remains a LocalSend fork. This repository should not pretend to be the canonical upstream source.

## Documentation

- [Uyava showcase notes](docs/uyava-showcase.md)
- [Uyava documentation](https://uyava.io/docs/)
- [Uyava package on pub.dev](https://pub.dev/packages/uyava)
- [LocalSend upstream repository](https://github.com/localsend/localsend)
- [LocalSend protocol documentation](https://github.com/localsend/protocol)

## Working With Upstream

Recommended sync flow:

```bash
git fetch upstream
git checkout main
git merge --ff-only upstream/main
git push origin main
```

When changing docs in this fork, document fork-specific behavior explicitly instead of silently inheriting upstream wording where behavior has diverged.

## Repository Layout

- [`app/`](app): Flutter application
- [`app/lib/uyava/`](app/lib/uyava): LocalSend-specific Uyava graph and runtime instrumentation
- [`docs/uyava-showcase.md`](docs/uyava-showcase.md): fork-specific showcase and usage notes

## Getting Started

From the application directory:

```bash
cd app
flutter pub get
flutter run
```

## Verification

Run checks from [`app/`](app):

```bash
flutter analyze
flutter test
```

Use the platform-specific `flutter build <platform>` command that matches your environment if you also need a local build artifact.
