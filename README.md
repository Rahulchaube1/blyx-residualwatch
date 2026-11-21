<img src="assets/logo.png" width="88" height="88" alt="Blyx ResidualWatch logo">

# Blyx ResidualWatch

Freeze a reference distribution and monitor later prediction errors for sustained upward or downward shifts. Detect a model that starts systematically underpredicting or overpredicting. Fit the mean and sample standard deviation of a stable reference period, freeze it, and score later residuals in time order. This keeps later observations from changing their own baseline.

## Use it in a project

Install [Blyx 0.2.1](https://github.com/Rahulchaube1/blyxxxx/releases/tag/v0.2.1), Rust 1.85 or newer, and a host linker for native compilation. From the directory containing your entry file, pin the library with Git.

```sh
git clone --depth 1 --branch v0.1.0 https://github.com/Rahulchaube1/blyx-residualwatch.git vendor/residualwatch
```

Save this program as `main.blyx` beside `vendor` and run `blyxc native-run main.blyx`.

```blyx
use vendor::residualwatch::residualwatch;
fn main() {
    let reference = rw_fit([9, 10, 11], [10, 10, 10], 0.0);
    let first = rw_step(rw_monitor(), reference, 12.0, 10.0, 0.5, 3.0);
    let second = rw_step(first, reference, 12.0, 10.0, 0.5, 3.0);
    println!(at(reference, 2));
    println!(at(first, 2));
    println!(at(second, 2));
}
```

Expected output:

```text
1
0
1
```

[Run this example in your browser](https://www.blyx-lang.space/play?example=package-residualwatch)

## Command-line tool

Extract [the release archive](https://github.com/Rahulchaube1/blyx-residualwatch/releases/tag/v0.1.0) for Windows x64, Linux x64 or Apple Silicon macOS. Verify the archive against `SHA256SUMS`. The archive includes example CSV files. In PowerShell start the executable with `.\residualwatch.exe`. The x64 Windows executable uses the Microsoft Visual C++ runtime.

```sh
./residualwatch fixtures/shift.csv --reference 3 --limit 3
```

## API and data contract

| Function | Result |
| --- | --- |
| `rw_fit(actual, predicted, min_scale)` | Frozen [reference_rows, mean_residual, scale]. Residual means actual − predicted. |
| `rw_training()`, `rw_train(state, actual, prediction)`, `rw_freeze(state, min_scale)` | Equivalent reference fit for incoming observations. |
| `rw_monitor()`, `rw_step(state, reference, actual, prediction, allowance, limit)` | Start monitoring, then update the two-sided CUSUM by one observation. |

Build the reference from at least two observations. If its residuals are constant, explicitly set a positive scale floor in target units or use a more representative reference. The monitor signals +1 for sustained underprediction, −1 for overprediction, and 0 otherwise. The point following an alert starts a new episode.

The CLI accepts a UTF-8 CSV with the literal header `actual,predicted` and two unquoted finite numbers on each nonblank row. Supply the length of the initial reference period with `--reference N`. Defaults are allowance 0.5, limit 5.0 and scale floor 0. Options are `--allowance`, `--limit`, and `--min-scale`. The JSON report gives counts and the one-based first alert row among data records, excluding header and blanks. The first alert in the shift fixture is row 5. Exit status is 0 for steady, 1 for one or more alerts, 2 for invalid input, and 4 for an I/O failure. The library retains fixed-size state. The CLI reads its input file into memory.

Choose the reference period and limits on representative data. An alarm identifies a shift in observed errors. Diagnose the cause using features, labels, missingness and changes in the data pipeline.

## Contribute

Clone this repository, run `blyxc native-run tests.blyx` and `blyxc native-run example.blyx`, and include a failing example with any behavior change. Include the compiler version, inputs and expected output in bug reports. [Open a package issue](https://github.com/Rahulchaube1/blyx-residualwatch/issues) · [Blyx handbook](https://doc.blyx-lang.space/guide/training-and-monitoring) · [Ecosystem catalog](https://www.blyx-lang.space/packages)

## Connect with Rahul Chaube

[Portfolio](https://www.rahulchaube1.com/) · [GitHub](https://github.com/Rahulchaube1) · [LinkedIn](https://www.linkedin.com/in/rahulchaube1) · [Hugging Face](https://huggingface.co/oncody) · [X](https://x.com/RahulChaube_) · [EverestQ](https://www.everestqai.com/) · [Contact](https://www.rahulchaube1.com/contact)

[Blyx website](https://www.blyx-lang.space/) · [BlyxTorch](https://www.blyx-lang.space/packages/blyxtorch) · [Handbook](https://doc.blyx-lang.space/) · [Community](https://www.blyx-lang.space/community)

Support Rahul’s open-source work through [GitHub Sponsors](https://github.com/sponsors/Rahulchaube1) or [Buy Me a Coffee](https://buymeacoffee.com/rahulchaube).
