# PornWeb HarmonyOS（鸿蒙版）

固定服务器客户端，默认写死：`https://web.cnsz.kdns.fr`（无选服）。

与网页 / 安卓主线共用同一套后端 API；本仓库独立发版。

## 构建（优先云端）

**主路径：GitHub Actions** — 见 [INSTALL.md](./INSTALL.md) 与 [Build HAP](https://github.com/cnsunsz/pornweb-harmony/actions/workflows/build-hap.yml)。

- 工具链发布在 [`sdk-26.0.0.865`](https://github.com/cnsunsz/pornweb-harmony/releases/tag/sdk-26.0.0.865)（CI 精简包，无需华为交互登录）
- 每次 `main` / PR / `workflow_dispatch` 产出 HAP artifact；`v*` tag 会挂到对应 Release
- 当前签名为 **OpenHarmony debug**（仓库内 `signing/debug/`）。真机华为正式签名 / AGC 另配

本地 Command Line Tools **可选**（重签、排障时再用）。

```bash
gh workflow run build-hap.yml --repo cnsunsz/pornweb-harmony
```

## 状态

- **v1.0.1**：AGC release signing + package `com.pornweb.app`；此前 Stage 脚手架可构建 HAP；登录页壳接通 `POST /api/auth/login`
- 媒体库 / 播放 / 续费尚未移植
- CI 云编译已接入；华为正式签名待办

## 对照

| | 本仓库 | 安卓主线 |
| --- | --- | --- |
| 平台 | HarmonyOS | Android |
| 服务器 | 写死 `https://web.cnsz.kdns.fr` | 写死同址（v1.0.37+） |
| 登录 | `POST /api/auth/login` | 同左 |
| 旧安卓分支 | [`pornweb-android-fixed`](https://github.com/cnsunsz/pornweb-android-fixed) 已归档 | — |

## Changelog

见 [CHANGELOG.md](./CHANGELOG.md)。
