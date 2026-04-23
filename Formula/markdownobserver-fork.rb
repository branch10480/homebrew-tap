class MarkdownobserverFork < Formula
  desc "Native macOS Markdown viewer (branch10480 personal fork of MarkdownObserver)"
  homepage "https://github.com/branch10480/markdownobserver"
  license "MIT"
  head "https://github.com/branch10480/markdownobserver.git", branch: "develop"

  depends_on xcode: ["15.0", :build]
  depends_on :macos

  # Use the standard system environment so xcodebuild's internal tooling
  # (SwiftPM resolver, sandbox-exec invocations, Xcode's own shims) can see
  # a normal PATH / HOME / TMPDIR. Homebrew's default superenv strips too
  # much for Xcode-based builds to succeed.
  env :std

  def install
    xcodebuild "-project", "minimark.xcodeproj",
               "-scheme", "minimark",
               "-configuration", "Release",
               "-destination", "platform=macOS",
               "-derivedDataPath", "build",
               "-skipPackagePluginValidation",
               "-skipMacroValidation",
               "IDEPackageSupportDisableManifestSandbox=YES",
               "IDEPackageSupportDisablePluginExecutionSandbox=YES",
               "OTHER_SWIFT_FLAGS=$(inherited) -disable-sandbox",
               "APP_BUNDLE_IDENTIFIER=com.github.branch10480.markdownobserver.fork",
               "TESTS_BUNDLE_IDENTIFIER=com.github.branch10480.markdownobserver.fork.tests",
               "UITESTS_BUNDLE_IDENTIFIER=com.github.branch10480.markdownobserver.fork.uitests",
               "CODE_SIGN_IDENTITY=",
               "CODE_SIGNING_REQUIRED=NO",
               "CODE_SIGNING_ALLOWED=NO",
               "build"

    prefix.install "build/Build/Products/Release/MarkdownObserver.app"
  end

  def caveats
    <<~EOS
      MarkdownObserver.app has been installed to:
        #{opt_prefix}/MarkdownObserver.app

      Quick launch (add to ~/.zshrc):
        alias mdo='open -a "#{opt_prefix}/MarkdownObserver.app"'

      To have Finder recognise it as a normal app, symlink into /Applications/:
        ln -s "#{opt_prefix}/MarkdownObserver.app" "/Applications/MarkdownObserver-Fork.app"

      Customize rendering by editing:
        ~/Library/Application Support/MarkdownObserver/themes/user.css

      Upgrade to the latest feature branch HEAD:
        brew upgrade --fetch-HEAD markdownobserver-fork

      If the build fails with "sandbox_apply: Operation not permitted",
      disable Homebrew's outer sandbox as a fallback:
        HOMEBREW_NO_SANDBOX=1 brew install --HEAD markdownobserver-fork
    EOS
  end

  test do
    assert_path_exists prefix/"MarkdownObserver.app/Contents/MacOS/MarkdownObserver"
  end
end
