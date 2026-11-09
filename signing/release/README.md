# Release signing materials (AGC)

Bundle: **`com.pornweb.app`** (AGC APP ID `6917621310265408820`).

| File | Purpose |
| --- | --- |
| `pornweb-release.p12` | PKCS#12 keystore, alias `pornwebRelease` |
| `pornweb-release.csr` | CSR (already used) |
| `pornweb-release.cer` | AGC release certificate chain |
| `pornweb-release.p7b` | AGC **release** profile (`app_gallery`) |
| `.secrets` | Passwords (chmod 600, gitignored) |
| `material/` + encrypted hex in `build-profile.json5` | DevEco-compatible password cipher for hvigor |

## Build release-signed HAP

```bash
source /workspace/harmonyos-sdk/env.sh
cd /workspace/pornweb-harmony
ohpm install
hvigorw assembleHap --mode module -p module=entry@default -p product=release -p buildMode=release --no-daemon
```

Product `release` uses signingConfig `agcRelease` (type **HarmonyOS**).

**Caveat:** AGC release profiles are for AppGallery distribution; sideload/`hdc install` on consumer devices may still fail without a debug profile that lists device UDIDs.
