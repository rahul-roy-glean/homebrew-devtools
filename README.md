# Homebrew Tap for Devtools

A Homebrew tap for developer tools by [rahul-roy-glean](https://github.com/rahul-roy-glean).

## Install

```bash
brew tap rahul-roy-glean/devtools
```

### Sentinel

A local-first developer control plane CLI. PR stacking, unified status dashboard, AI chat for CI failures, and tool version compliance.

```bash
brew install sentinel
```

See [rahul-roy-glean/sentinel](https://github.com/rahul-roy-glean/sentinel) for details.

### dev-cache

Developer disk space manager -- monitors and garbage-collects dev caches.

```bash
brew install dev-cache
```

See [rahul-roy-glean/dev-cache](https://github.com/rahul-roy-glean/dev-cache) for details.

## Upgrade

```bash
brew upgrade sentinel
brew upgrade dev-cache
```

## Rename note

This tap was renamed from `rahul-roy-glean/sentinel` to `rahul-roy-glean/devtools`. If you previously used the old tap name, re-tap with:

```bash
brew untap rahul-roy-glean/sentinel
brew tap rahul-roy-glean/devtools
```
