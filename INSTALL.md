# HarmonyOS Command Line Tools — install notes (PornWeb 鸿蒙版)

Local box install for building the ArkTS Stage-model client. Default API base URL (hardcoded in app code, not here): `https://web.cnsz.kdns.fr`.

## Install path

| Item | Path |
| --- | --- |
| ZIP source | `/workspace/harmonyos-dl/commandline-tools-linux-x64-26.0.0.865.zip` (~2.2G) |
| Extracted root | `/workspace/harmonyos-sdk/command-line-tools/` (~7.1G) |
| Env script | `source /workspace/harmonyos-sdk/env.sh` |
| Bundled SDK | `/workspace/harmonyos-sdk/command-line-tools/sdk` → HarmonyOS **26.0.0.105** (API **26**) |
| Bundled Node | `/workspace/harmonyos-sdk/command-line-tools/tool/node` → **v24.14.1** |
| Host JDK (not in ZIP) | `/home/box/jdk-17` (Temurin 17.0.21) — used for packing/signing JARs |

Package `version.txt`:

- Command Line Tools: **26.0.0.865**
- hvigor: **6.26.9**
- ohpm: **26.0.0.630**
- hstack: 6.1.0 / codelinter: 6.0.240
- HarmonyOS SDK: 26.0.0 Release (Ohos_sdk_public 26.0.0.105, API 26)

SDK layout under `sdk/default/`: `openharmony/{ets,js,native,toolchains,previewer}` and `hms/{ets,js,native,toolchains,previewer}` — **complete enough for CLI builds; no extra SDK download required from this ZIP.**

## One-time extract (already done on this box)

```bash
mkdir -p /workspace/harmonyos-sdk
cd /workspace/harmonyos-sdk
unzip -q /workspace/harmonyos-dl/commandline-tools-linux-x64-26.0.0.865.zip
# wrappers need execute bit (zip may ship as r-x for owner only)
chmod -R u+rwX,go+rX command-line-tools/bin command-line-tools/ohpm/bin \
  command-line-tools/hvigor/bin command-line-tools/tool
```

No interactive license prompt was required for `hvigorw` / `ohpm` / `hdc`. `LICENSE.txt` / `NOTICE.txt` sit under `command-line-tools/`.

## Environment

```bash
source /workspace/harmonyos-sdk/env.sh
```

That sets:

- `HARMONY_CLT_HOME` → `/workspace/harmonyos-sdk/command-line-tools`
- `DEVECO_SDK_HOME` / `OHOS_SDK_HOME` → `$HARMONY_CLT_HOME/sdk`
- `DEVECO_NODE_HOME` / `NODE_HOME` → `$HARMONY_CLT_HOME/tool/node`
- `JAVA_HOME` → `/home/box/jdk-17` (fallback `/home/box/jdk-21`)
- `PATH` prepends: `bin/`, Node `bin/`, JDK `bin/`, OpenHarmony `toolchains/` (`hdc`, `restool`, …)

Verify:

```bash
hvigorw -v    # 6.26.9
ohpm -v       # 26.0.0.630
node -v       # v24.14.1
java -version # Temurin 17.x
hdc -v        # Ver: 3.2.0f
ohpm ping     # registry https://ohpm.openharmony.cn/ohpm/ → PONG
```

Commands that worked on 2026-11-08 (Asia/Shanghai): all of the above after `source env.sh`.

## Gaps / caveats

1. **JDK is not inside the ZIP.** Packing/signing uses JARs (`app_packing_tool.jar`, hap-sign-tool). This box already has Temurin 17/21 under `/home/box/jdk-*`. Avoid JDK 25 with mismatched older API toolchains (hvigor can error). `apt` on this box could not refresh Debian mirrors (500 / unsigned) — if JDKs disappear, drop a portable Temurin tarball under `/home/box/jdk-17` and re-source `env.sh`.
2. **No `hvigorw create` / scaffold CLI** in this package. Stage-model apps are usually created in DevEco Studio or by copying the official empty Stage template (manual `AppScope/`, `entry/`, `hvigorfile.ts`, `build-profile.json5`, `oh-package.json5`, …).
3. **Debug signing materials** (keystore / `.p7b` profile / cert) are not in the ZIP. First `assembleHap` needs a local signingConfig in `build-profile.json5` (or unsigned debug flow if configured).
4. **Emulator binary** is present under `command-line-tools/emulator/` but was not exercised here; device deploy uses `hdc`.
5. ZIP / SDK stay under `/workspace` (not committed to the pornweb-harmony git repo).

## Next scaffold steps (do not run until ready)

Target repo: `/workspace/pornweb-harmony`. Prefer a minimal Stage model app for phone, API 26 / compatibleSdkVersion 12+ as needed.

1. `source /workspace/harmonyos-sdk/env.sh`
2. Add Stage project skeleton (or import DevEco “Empty Ability” template):
   - Root: `hvigorfile.ts`, `hvigor/hvigor-config.json5`, `build-profile.json5`, `oh-package.json5`, `AppScope/app.json5`
   - Module `entry/`: `src/main/module.json5`, `ets/entryability/EntryAbility.ets`, `ets/pages/Index.ets`, `resources/`, module `build-profile.json5` / `hvigorfile.ts` / `oh-package.json5`
3. Point product compileSdkVersion / compatibleSdkVersion / targetSdkVersion at **HarmonyOS API 26** (or a lower compatible floor if targeting older devices).
4. Hardcode API base: `https://web.cnsz.kdns.fr` (HTTPS only) in a shared config module — no server picker.
5. `ohpm install` then `hvigorw assembleHap --no-daemon` (add signingConfig when needed).
6. Install to device: `hdc install path/to/entry-default-signed.hap`

App feature alignment (later): login, media browse/play, USDT/PayPal renew — same backend APIs as the web/Android clients.

## Re-extract

If `/workspace/harmonyos-sdk` is removed:

```bash
rm -rf /workspace/harmonyos-sdk
mkdir -p /workspace/harmonyos-sdk && cd /workspace/harmonyos-sdk
unzip -q /workspace/harmonyos-dl/commandline-tools-linux-x64-26.0.0.865.zip
chmod -R u+rwX,go+rX command-line-tools/bin command-line-tools/ohpm/bin \
  command-line-tools/hvigor/bin command-line-tools/tool
# env.sh is recreated from this INSTALL.md or kept alongside if you copy it back
```
