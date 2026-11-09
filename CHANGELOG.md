# Changelog

本仓库为 **HarmonyOS / 鸿蒙** 独立发行版。版本号从 v1.0.0 起算。

## [1.0.0-dev] - 2026-11-08

### Added
- Stage 模型 ArkTS 脚手架：`com.pornweb.harmony` / PornWeb 1.0.0
- 固定服务器 `https://web.cnsz.kdns.fr`（`AppConfig.BASE_URL`，无选服）
- 登录页壳：用户名/密码 + `POST /api/auth/login`（与安卓/网页后端一致）
- 本地 OpenHarmony 调试签名材料（`signing/debug/`），`hvigorw assembleHap` 产出 signed/unsigned HAP
- `INSTALL.md`：Command Line Tools 26.0.0.865 / API 26 环境说明

### Build
- 工具：hvigorw 6.26.9 + ohpm + HarmonyOS SDK 26.0.0.105
- 产物：`entry/build/default/outputs/default/entry-default-signed.hap`

## Unreleased
### Added
- GitHub Actions `build-hap.yml`: download CI slim tools from release `sdk-26.0.0.865`, cache extract, `assembleHap`, upload HAP artifact; attach on `v*` tags
- Docs: CI is primary build path; local SDK optional (Huawei AGC/release signing still local/TODO)

### 计划
- 媒体浏览 / 播放 / 在线续费（USDT·PayPal）对齐网页 API
- 正式华为签名与上架材料
