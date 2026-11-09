# Building PornWeb HarmonyOS（鸿蒙版）

Default API base URL (hardcoded in app): `https://web.cnsz.kdns.fr`.

## Primary: GitHub Actions (recommended)

CI builds the HAP on `ubuntu-latest` without interactive Huawei login.

| Item | Value |
| --- | --- |
| Workflow | [`.github/workflows/build-hap.yml`](./.github/workflows/build-hap.yml) |
| Triggers | `push`/`PR` to `main`, tags `v*`, `workflow_dispatch` |
| Toolchain asset | Release [`sdk-26.0.0.865`](https://github.com/cnsunsz/pornweb-harmony/releases/tag/sdk-26.0.0.865) → `commandline-tools-linux-x64-26.0.0.865-ci.tar.gz` (slim CI pack: bin/sdk/hvigor/ohpm/node; no emulator/linter) |
| Artifact | Workflow artifact `pornweb-harmony-hap` (`*-signed.hap` / `*-unsigned.hap`) |
| Version tags | On `v*`, HAPs are attached to that GitHub Release |

### Manual re-run

```bash
gh workflow run build-hap.yml --repo cnsunsz/pornweb-harmony
gh run list --repo cnsunsz/pornweb-harmony --workflow=build-hap.yml -L 5
```

### Signing note (current CI)

The repo’s `signing/debug/` materials produce an **OpenHarmony debug**-signed HAP (keystore password ciphertext for `DebugKey`). That is fine for CI/dev sideload on OpenHarmony/debug-friendly images.

**Huawei consumer phones / AppGallery** need **AGC / Huawei official** release signing (profile + cert from AppGallery Connect). That is **not** wired in CI yet — keep local tools until release signing is configured, then replace `signingConfigs` / secrets.

## Optional: local Command Line Tools

Only needed for local `assembleHap`, re-signing, or debugging the toolchain.

1. Download the CI slim tarball from the `sdk-26.0.0.865` release (or the full Huawei ZIP if you already have it).
2. Extract and put `command-line-tools/` somewhere stable, e.g. `/workspace/harmonyos-sdk/`.
3. Install **JDK 17** (Temurin) for packing/signing JARs.
4. Export env (example):

```bash
export HARMONY_CLT_HOME=/path/to/command-line-tools
export DEVECO_SDK_HOME=$HARMONY_CLT_HOME/sdk
export OHOS_SDK_HOME=$DEVECO_SDK_HOME
export DEVECO_NODE_HOME=$HARMONY_CLT_HOME/tool/node
export JAVA_HOME=/path/to/jdk-17
export PATH=$HARMONY_CLT_HOME/bin:$DEVECO_NODE_HOME/bin:$JAVA_HOME/bin:$DEVECO_SDK_HOME/default/openharmony/toolchains:$PATH

ohpm install
hvigorw assembleHap --mode module -p module=entry@default -p product=default --no-daemon
```

If this machine still has `/workspace/harmonyos-sdk/env.sh`, `source` that instead.

### Tool versions (26.0.0.865)

- hvigorw **6.26.9** · ohpm **26.0.0.630** · Node **v24.14.1** (bundled)
- HarmonyOS SDK **26.0.0.105** (API **26**)

No interactive license prompt is required for `hvigorw` / `ohpm` / `hdc` from this pack.


## AGC release signing (local)

Release materials live under `signing/release/` (gitignored keystore/secrets; `.cer`/`.p7b` also ignored).

```bash
hvigorw assembleHap --mode module -p module=entry@default -p product=release -p buildMode=release --no-daemon
```

CI currently still builds the **debug** product unless the workflow is pointed at `product=release` and release secrets are provided via GitHub Secrets.
