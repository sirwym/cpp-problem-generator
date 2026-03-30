# 🚀 cpp-problem-generator

> **AI 驱动的 C++ 算法竞赛题目与测试数据生成工具**

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/docker-supported-blue.svg)](https://www.docker.com/)
[![testlib](https://img.shields.io/badge/testlib-v0.9.41-green.svg)](https://github.com/MikeMirzayanov/testlib)

## 项目简介

**cpp-problem-generator** 是一个专为 CSP-J/S、NOIP、ACM 等信息学竞赛设计的智能工具，它结合了 AI 能力和 Docker 沙盒技术，能够自动生成高质量的题目和测试数据。

**核心优势**：

- 🤖 **AI 赋能**：通过智能指令系统，大模型可自动分析原题、生成新题面及完整测试数据
- 🛡️ **Docker 沙盒**：提供安全的 C++ 编译运行环境，避免本地环境配置问题
- 📚 **testlib 标准**：严格遵循 Codeforces 官方 testlib.h 标准，确保数据质量
- 📦 **一键打包**：自动生成 FPS 标准格式 ZIP 包，包含题面、源码和测试数据
- 🔧 **丰富模板**：内置多种数据结构生成器和校验器模板

## 环境准备

在使用本工具之前，您需要确保：

1. **安装 Docker**：
   - 安装 [Docker Desktop](https://www.docker.com/products/docker-desktop)（Windows/Mac）
   - 或安装 [Docker Engine](https://docs.docker.com/engine/install/)（Linux）
2. **启动 Docker**：
   - 确保 Docker Desktop 或 Docker Engine 在后台运行
   - 可以通过运行 `docker info` 命令验证 Docker 是否正常运行

## 极简安装教程

### 📌 强烈建议：使用 Release 版本（推荐）

**不要**通过 `git clone` 下载整个仓库，这会包含大量无用的开发环境文件。请严格按照以下步骤操作：

1. **访问 GitHub Releases 页面**：
   - 打开 [cpp-problem-generator Releases](https://github.com/sirwym/cpp-problem-generator/releases) 最新版本的页面。
2. **下载核心文件**：
   - 在 Release 页面的 Assets 底部，下载 `Source code (zip)` 压缩包。
   - 解压后，您只需要提取并保留这三个核心内容：`SKILL.md` 文件、`scripts/` 文件夹、`references/` 文件夹，其余文件均可删除。
3. **下载 Docker 沙盒镜像**：
   - 在同一个 Release 页面，根据您的电脑芯片架构下载对应的 `.tar` 镜像包：
     - Windows / Intel Mac / Linux 选用：`cpp-sandbox-amd64.tar`
     - Apple Silicon (M1/M2/M3 等) 选用：`cpp-sandbox-arm64.tar`
4. **导入并重命名 Docker 镜像**（❗关键步骤）：
   打开终端或命令行，进入镜像文件所在的目录，依次执行以下命令：
   ```bash
   # 1. 加载镜像 (以 amd64 为例)
   docker load -i cpp-sandbox-amd64.tar
   
   # 2. 统一重命名 (非常重要，否则 AI 无法调用)
   # 如果您下载的是 amd64 版本：
   docker tag cpp-sandbox:amd64 cpp-sandbox:latest
   # 如果您下载的是 arm64 版本：
   docker tag cpp-sandbox:arm64 cpp-sandbox:latest
   ```
5. **验证沙盒就绪**：
   ```bash
   docker images | grep cpp-sandbox
   # 如果看到名为 cpp-sandbox 且标签为 latest 的镜像，说明准备完毕！
   ```

## 插件导入与使用说明

### 导入 AI Agent 平台 (如 Dify, Coze, Trae 等)

1. **配置工作区**：
   - 将刚才提取出来的 `SKILL.md`、`scripts/` 和 `references/` 放置到您本地 AI 助手对应的工作区或插件目录中。
2. **注入人设与指令**：
   - 打开 `SKILL.md`，将其中的**专家角色设定 (Persona)** 和 **执行步骤 (Action SOP)** 完整复制，作为 Prompt 配置给您的 AI 智能体。
   - 确保触发指令设置为 `@cpp-problem-generator`。

### 使用方法

1. **触发自动出题**：
   - 在聊天界面对 AI 输入 `@cpp-problem-generator`，并附上以下信息：
     - **原题描述**：题目背景、输入输出格式要求。
     - **标准程序 (std.cpp)**：您写好的正确参考代码。
     - **子任务配置**（可选）：如不指定，AI 默认采用 3 个子任务，共 10 个测试点（按照 4-3-3 比例分配）。
2. **自动化构建闭环**：
   - AI 会根据您的标准代码，自动分析并写出 `gen.cpp` (生成器) 和 `valid.cpp` (校验器)。
   - AI 会自动调用您本地的 Docker 沙盒环境进行编译和极限数据校验。
3. **获取最终产物**：
   - 一切顺利的话，当前目录下会自动生成一个 `problem_package_xxxx.zip`。
   - 这个压缩包内包含了：全新包装的 Markdown 题面、所有源码、以及直接可用于 OJ 平台的完整测试数据（含 `in` 和 `out`）。

### 手动执行构建（高级用户诊断用）

如果您发现 AI 执行报错，或者需要自行诊断 C++ 模板问题，可以手动复制 AI 生成的文件并运行底层脚本：

```bash
# 注意路径必须使用 Linux 风格的正斜杠 /
docker run --rm -v "${PWD}:/data" -w /data cpp-sandbox python3 scripts/generate.py <gen_cpp文件路径> <valid_cpp文件路径> <std_cpp文件路径> <problem_md文件路径> 4 3 3
```

## 开发者指南

如果您想要参与开发或修改底层 C++ 模板，才需要 clone 整个仓库：

```bash
git clone https://github.com/sirwym/cpp-problem-generator.git
```

### 仓库结构

```
cpp-problem-generator/
├── SKILL.md                  # AI Agent 智能指令系统（核心配置）
├── scripts/                  # 自动化脚本
│   ├── generate.py           # 核心构建脚本
│   └── testlib.h             # testlib 标准库
├── references/               # 参考文档与模板库
│   ├── testlib-manual.md     # testlib API 参考手册
│   └── templates/            # 代码模板库
│       ├── generators/       # 数据生成器模板
│       └── validators/       # 数据校验器模板
├── .github/                  # GitHub Actions 配置
└── Dockerfile                # Docker 镜像构建文件
```

### 开发流程

1. **修改模板**：在 `references/templates/` 目录中修改或添加模板
2. **测试构建**：使用 Docker 沙盒测试构建流程
3. **提交 PR**：提交您的修改以供审核

## 常见问题

### Q: 为什么需要 Docker？

A: Docker 提供了一个隔离、一致的环境，确保 C++ 代码能够正确编译和运行，避免因本地环境差异导致的问题。

### Q: 镜像导入失败怎么办？

A: 确保 Docker 正在运行，并且您有足够的磁盘空间。如果问题持续，请尝试重新下载镜像文件。

### Q: 生成的测试数据质量如何？

A: 本工具使用 testlib.h 标准库生成数据，确保数据符合竞赛标准，包括边界情况和极限数据。

### Q: 如何修改生成器模板？

A: 如果您需要修改生成器模板，请参考开发者指南，clone 仓库后修改 `references/templates/generators/` 目录中的对应文件。

## 许可证

本项目采用 [MIT License](LICENSE) 开源协议。

***

<div align="center">

**Made with ❤️ for Competitive Programming Community**

</div>
