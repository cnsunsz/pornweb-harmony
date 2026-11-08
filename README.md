# PornWeb HarmonyOS（鸿蒙版）

固定服务器客户端，默认写死：`https://web.cnsz.kdns.fr`（无选服）。

与网页 / 安卓主线共用同一套后端 API；本仓库独立发版。

## 构建工具

见 [INSTALL.md](./INSTALL.md)：本机解压 HarmonyOS Command Line Tools 26.0.0.865（含 API 26 SDK），`source /workspace/harmonyos-sdk/env.sh` 后可用 `hvigorw` / `ohpm`。

## 状态

- **v1.0.0-dev**：Stage 脚手架可构建 HAP；登录页壳已接通 `POST /api/auth/login`
- 媒体库 / 播放 / 续费尚未移植

## 快速构建

```bash
source /workspace/harmonyos-sdk/env.sh
cd /workspace/pornweb-harmony
ohpm install
hvigorw assembleHap --mode module -p module=entry@default -p product=default --no-daemon
```

HAP 输出：

- `entry/build/default/outputs/default/entry-default-signed.hap`
- `entry/build/default/outputs/default/entry-default-unsigned.hap`

包名：`com.pornweb.harmony` · 版本：`1.0.0`（versionCode 1000000）

## 对照

| | 本仓库 | 安卓主线 |
| --- | --- | --- |
| 平台 | HarmonyOS | Android |
| 服务器 | 写死 `https://web.cnsz.kdns.fr` | 写死同址（v1.0.37+；旧固定包曾用 http） |
| 登录 | `POST /api/auth/login` | 同左 |
| 旧安卓分支 | [`pornweb-android-fixed`](https://github.com/cnsunsz/pornweb-android-fixed) 已归档 | — |

## Changelog

见 [CHANGELOG.md](./CHANGELOG.md)。
