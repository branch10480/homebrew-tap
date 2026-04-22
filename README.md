# branch10480/homebrew-tap

Personal [Homebrew](https://brew.sh) tap for macOS tools I maintain or fork for myself.

## Usage

```bash
brew tap branch10480/tap
```

## Formulae

### `markdownobserver-fork`

Native macOS Markdown viewer — my personal fork of [larspohlmann/markdownobserver](https://github.com/larspohlmann/markdownobserver) with MathJax bundled, a `user.css` overlay loader, and some rendering tweaks. Source: [branch10480/markdownobserver](https://github.com/branch10480/markdownobserver).

```bash
# Install from the current HEAD of the fork's feature branch (source build)
HOMEBREW_NO_SANDBOX=1 brew install --HEAD branch10480/tap/markdownobserver-fork

# Upgrade later to pick up new commits on the tracked branch
HOMEBREW_NO_SANDBOX=1 brew upgrade --fetch-HEAD markdownobserver-fork
```

`HOMEBREW_NO_SANDBOX=1` is required because xcodebuild's Swift Package Manager resolution uses `sandbox-exec` internally and cannot nest inside Homebrew's own sandbox. This is a limitation of every Homebrew formula that source-builds an Xcode project with SPM dependencies.

Xcode 15+ is required at install time because the formula runs `xcodebuild` locally — no Apple Developer ID or notarization needed since the binary never leaves your machine.

After install, see the `caveats` output for the launch alias / `/Applications/` symlink recipes, or edit `~/Library/Application Support/MarkdownObserver/themes/user.css` to customize rendering.

## License

MIT — formulae in this tap are published under the same license as the upstream projects unless noted otherwise.
