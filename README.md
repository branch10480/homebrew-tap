# branch10480/homebrew-tap

Personal [Homebrew](https://brew.sh) tap for macOS tools I maintain or fork for myself.

## Usage

```bash
brew tap branch10480/tap
```

## Formulae

### `markdownobserver-fork`

Native macOS Markdown viewer — my personal fork of [larspohlmann/markdownobserver](https://github.com/larspohlmann/markdownobserver) with MathJax bundled, a `user.css` overlay loader, and some rendering tweaks. Source: [branch10480/markdownobserver](https://github.com/branch10480/markdownobserver).

> **⚠️ Status on macOS 26: currently broken.** xcodebuild's Swift Package Manager resolver shells out to `sandbox-exec`, and on macOS 26 the kernel rejects `sandbox_apply` with `Operation not permitted` when the caller is a subprocess of Homebrew's install pipeline. Neither `env :std`, `HOMEBREW_NO_SANDBOX=1`, nor `-skipPackagePluginValidation` fix this — it needs an upstream change in Homebrew or Xcode.
>
> **Reliable install today:** clone the source repo and run its script directly, no tap required.
>
> ```bash
> git clone https://github.com/branch10480/markdownobserver.git
> cd markdownobserver
> ./scripts/install.sh --alias
> ```
>
> The formula is kept in this tap so it's ready to re-enable once the macOS + Homebrew SPM-sandbox interaction is fixed.

```bash
# Once the sandbox issue is resolved upstream, this will work:
brew install --HEAD branch10480/tap/markdownobserver-fork
brew upgrade --fetch-HEAD markdownobserver-fork
```

Xcode 15+ is required at install time because the formula runs `xcodebuild` locally — no Apple Developer ID or notarization needed since the binary never leaves your machine.

## License

MIT — formulae in this tap are published under the same license as the upstream projects unless noted otherwise.
