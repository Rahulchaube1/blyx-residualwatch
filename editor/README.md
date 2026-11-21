# Blyx ResidualWatch

Monitor prediction drift by detecting sustained upward or downward changes in errors against a frozen reference period.

This extension includes the Blyx ResidualWatch 0.1.0 source, a runnable example and completions for its public functions. It uses the Blyx Language extension for syntax highlighting and execution.

## Run in the editor

1. Open an empty file named `residualwatch-demo.blyx`.
2. Type `blyx-residualwatch-demo` and select **ResidualWatch — runnable example**. You can also use **Snippets: Fill File with Snippet**.
3. Choose **Blyx: Run File** from the command palette. Change an argument near the end of `fn main()` to try another input.

Expected output

```text
1
0
1
```

## Use ResidualWatch in a project

Extract the starter into a new folder. It contains `main.blyx`, the licensed framework source in `vendor/residualwatch`, and a VS Code task. With the Blyx 0.2.1 compiler and host toolchain installed, run `blyxc native-run main.blyx` from that folder. Type `blyx-residualwatch-` in a Blyx file to see the framework completions. [Download the starter ZIP](https://github.com/Rahulchaube1/blyxxxx/releases/download/framework-editors-v0.1.0/blyx-residualwatch-starter-0.1.0.zip)

[API and input requirements](https://www.blyx-lang.space/packages/residualwatch) · [Framework source](https://github.com/Rahulchaube1/blyx-residualwatch/tree/30b5901f566db191b3fc3a31fa7b06fedbba4f38) · [Report an issue](https://github.com/Rahulchaube1/blyx-residualwatch/issues)

[GitHub Sponsors](https://github.com/sponsors/Rahulchaube1) · [Buy Me a Coffee](https://buymeacoffee.com/rahulchaube)
