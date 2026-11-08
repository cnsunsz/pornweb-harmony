# PornWeb HarmonyOS（鸿蒙版）

固定服务器客户端，默认写死：`https://web.cnsz.kdns.fr`（无选服）。

与网页 / 安卓主线共用同一套后端 API；本仓库独立发版。

## 构建工具

见 [INSTALL.md](./INSTALL.md)：本机已解压 HarmonyOS Command Line Tools 26.0.0.865（含 API 26 SDK），`source /workspace/harmonyos-sdk/env.sh` 后可用 `hvigorw` / `ohpm`。

## 状态

- 工程脚手架建设中
- 构建需 HarmonyOS Command Line Tools（`hvigorw` / `ohpm`）

## 对照

| | 本仓库 | 安卓主线 |
| --- | --- | --- |
| 平台 | HarmonyOS | Android |
| 服务器 | 写死 `https://web.cnsz.kdns.fr` | 写死同址（v1.0.37+） |
| 旧安卓分支 | [`pornweb-android-fixed`](https://github.com/cnsunsz/pornweb-android-fixed) 已归档 | — |

## Changelog

见 [CHANGELOG.md](./CHANGELOG.md)。
