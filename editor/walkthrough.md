## Watch for systematic underprediction

Keep rows in time order. The reference residual is actual minus prediction, so a positive alarm means sustained underprediction. A constant reference requires an explicit positive scale floor. Choose thresholds against representative stable data.

1. Open an empty file named `residualwatch-demo.blyx`.
2. Type `blyx-residualwatch-demo` and select **ResidualWatch — runnable example**. You can also use **Snippets: Fill File with Snippet**.
3. Choose **Blyx: Run File** from the command palette. Change an argument near the end of `fn main()` to try another input.

Expected output

```text
1
0
1
```

[Work through the example in the browser](https://www.blyx-lang.space/play?example=package-residualwatch)
