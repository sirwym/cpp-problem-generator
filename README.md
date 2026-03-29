# 🚀 cpp-problem-generator

> **AI 赋能的 C++ 算法竞赛自动化测试数据生成与校验框架**

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![C++ Standard](https://img.shields.io/badge/C%2B%2B-14-orange.svg)](https://en.cppreference.com/)
[![testlib](https://img.shields.io/badge/testlib-v0.9.41-green.svg)](https://github.com/MikeMirzayanov/testlib)

本项目专为 **CSP-J/S、NOIP、ACM** 等信息学竞赛出题和集训设计，底层基于 `testlib.h` 行业标准，同时深度融合 AI 能力。通过 `SKILL.md` 智能指令系统，让出题人可以利用大模型一键生成符合规范的测试数据代码，大幅提升出题效率与数据质量。

---

## ✨ 核心特性

| 特性 | 描述 |
|------|------|
| 🎯 **testlib 规范** | 严格遵循 Codeforces 官方 testlib.h 标准，确保与主流 OJ 平台兼容 |
| 🤖 **AI 赋能** | 通过 SKILL.md 智能指令，大模型可自动分析原题、生成新题面及完整测试数据 |
| 📚 **丰富模板** | 内置 20+ 经典数据结构生成器与校验器模板（树、图、网格、数组等） |
| 🔒 **严格校验** | 多级数据验证机制，杜绝弱数据、非法数据污染测试库 |
| 📦 **一键打包** | 自动生成 FPS 标准格式 ZIP 包，含题面、源码、测试数据及元信息 |
| ⚡ **高效生成** | 支持子任务不均匀分配（如 4-3-3 黄金比例），灵活适配各类题目难度梯度 |

---

## 📁 目录结构

```
cpp-problem-generator/
├── 📄 README.md                 # 项目说明文档
├── 📋 SKILL.md                  # AI Agent 智能指令系统（核心配置）
│
├── 📂 scripts/                  # 自动化脚本
│   ├── generate.py             # 核心构建脚本：编译→生成→校验→打包
│   └── testlib.h               # testlib 标准库（脚本依赖）
│
├── 📂 references/               # 参考文档与模板库
│   ├── testlib-manual.md       # testlib API 快速参考手册
│   │
│   └── 📂 templates/            # 代码模板库
│       ├── testlib.h           # testlib 标准库（模板编译依赖）
│       │
│       ├── 📂 generators/       # 数据生成器模板（13个）
│       │   ├── gen-basic-fallback.cpp      # 基础回退模板
│       │   ├── gen-array-with-opt.cpp      # 带参数数组生成
│       │   ├── gen-tree-graph.cpp          # 普通树生成
│       │   ├── gen-rooted-tree-graph.cpp   # 有根树生成
│       │   ├── gen-bipartite-graph.cpp     # 二分图生成
│       │   ├── gen-grid-graph.cpp          # 网格图生成
│       │   ├── bgen.cpp                    # 布尔/二进制生成器
│       │   ├── igen.cpp                    # 整数生成器
│       │   ├── iwgen.cpp                   # 加权整数生成器
│       │   ├── sgen.cpp                    # 字符串生成器
│       │   ├── swgen.cpp                   # 加权字符串生成器
│       │   ├── gs.cpp                      # 通用图生成器
│       │   └── multigen.cpp                # 多组数据生成器
│       │
│       └── 📂 validators/       # 数据校验器模板（10个）
│           ├── val-basic-fallback.cpp      # 基础回退校验器
│           ├── nval.cpp                    # 整数范围校验器
│           ├── ival.cpp                    # 整数数组校验器
│           ├── sval.cpp                    # 字符串校验器
│           ├── case-nval.cpp               # 多组整数校验器
│           ├── undirected-tree-validator.cpp   # 无向树校验器
│           ├── undirected-graph-validator.cpp  # 无向图校验器
│           ├── bipartite-graph-validator.cpp   # 二分图校验器
│           ├── grid-validator.cpp              # 网格校验器
│           └── validate-using-testset-and-group.cpp  # 子任务分组校验器
│
└── 📦 problem_package_xxxx.zip  # 生成的题目包（示例输出）
    ├── problem.xml             # FPS 标准格式题面
    ├── gen.cpp                 # 数据生成器源码
    ├── valid.cpp               # 数据校验器源码
    ├── std.cpp                 # 标准程序源码
    ├── problem.md              # Markdown 格式题面
    └── 📂 testdata/            # 测试数据目录
        ├── 1.in, 1.out         # 第1组测试数据
        ├── 2.in, 2.out         # 第2组测试数据
        └── ...
```

---

## 🚀 快速开始

### 方式一：AI 自动出题（推荐）

通过触发 `@cpp-problem-generator` 指令，AI Agent 将自动完成以下流程：

#### 1. 准备输入
向 AI 提供以下信息：
- **原题描述**：题目背景、描述、输入输出格式
- **标准程序代码 (std.cpp)**：正确实现的参考代码
- **子任务配置**（可选）：如未指定，默认采用 3 个子任务，10 个测试点（4-3-3 分配）

#### 2. AI 自动执行流程

```
┌─────────────────┐
│  用户提供原题    │
│  + std.cpp      │
└────────┬────────┘
         ▼
┌─────────────────┐
│  AI 分析原题    │
│  提取核心逻辑   │
└────────┬────────┘
         ▼
┌─────────────────┐
│  检索模板库     │
│  匹配数据结构   │
└────────┬────────┘
         ▼
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  生成 gen.cpp   │────→│  生成 valid.cpp │────→│  生成新题面     │
│  (数据生成器)   │     │  (数据校验器)   │     │  (problem.md)   │
└─────────────────┘     └─────────────────┘     └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 ▼
                    ┌─────────────────────────┐
                    │  保存到 problem_temp/   │
                    └───────────┬─────────────┘
                                ▼
                    ┌─────────────────────────┐
                    │  执行构建脚本           │
                    │  python3 scripts/       │
                    │    generate.py ...      │
                    └───────────┬─────────────┘
                                ▼
                    ┌─────────────────────────┐
                    │  生成 ZIP 包 + meta.json│
                    └─────────────────────────┘
```

#### 3. 触发构建命令

AI 会自动执行以下命令（你也可以手动执行）：

```bash
# 基础用法（默认 4-3-3 分配）
python3 scripts/generate.py \
  problem_temp/gen.cpp \
  problem_temp/valid.cpp \
  problem_temp/std.cpp \
  problem_temp/problem.md \
  4 3 3

# 自定义子任务分配（如 5-4-3-2 共14个测试点）
python3 scripts/generate.py \
  problem_temp/gen.cpp \
  problem_temp/valid.cpp \
  problem_temp/std.cpp \
  problem_temp/problem.md \
  5 4 3 2
```

#### 4. 获取结果

脚本执行成功后，将在当前目录生成：
- `problem_package_xxxx.zip`：完整的 FPS 标准格式题目包
- `meta.json`：题目标题、知识点标签、ZIP 路径等元信息

---

## 📚 模板库概览

### 图论类模板

| 模板名称 | 类型 | 用途描述 |
|---------|------|---------|
| `gen-tree-graph.cpp` | 生成器 | 生成普通无向树，支持参数控制树形结构 |
| `gen-rooted-tree-graph.cpp` | 生成器 | 生成有根树，支持指定根节点 |
| `gen-bipartite-graph.cpp` | 生成器 | 生成二分图，支持左右部大小和边数控制 |
| `gen-grid-graph.cpp` | 生成器 | 生成网格图，适用于迷宫、地图类题目 |
| `undirected-tree-validator.cpp` | 校验器 | 验证无向树的合法性（无环、连通、无重边） |
| `undirected-graph-validator.cpp` | 校验器 | 验证无向图的合法性（无自环、无重边） |
| `bipartite-graph-validator.cpp` | 校验器 | 验证二分图的合法性 |
| `grid-validator.cpp` | 校验器 | 验证网格数据的合法性 |

### 序列/数组类模板

| 模板名称 | 类型 | 用途描述 |
|---------|------|---------|
| `gen-array-with-opt.cpp` | 生成器 | 生成带命令行参数的数组，支持范围控制 |
| `igen.cpp` | 生成器 | 基础整数生成器 |
| `iwgen.cpp` | 生成器 | 加权整数生成器，支持偏向性随机 |
| `bgen.cpp` | 生成器 | 布尔/二进制数据生成器 |
| `ival.cpp` | 校验器 | 整数数组范围校验 |
| `nval.cpp` | 校验器 | 单个整数范围校验 |
| `case-nval.cpp` | 校验器 | 多组整数数据校验 |

### 字符串类模板

| 模板名称 | 类型 | 用途描述 |
|---------|------|---------|
| `sgen.cpp` | 生成器 | 基础字符串生成器 |
| `swgen.cpp` | 生成器 | 加权字符串生成器 |
| `sval.cpp` | 校验器 | 字符串格式校验 |

### 通用/回退模板

| 模板名称 | 类型 | 用途描述 |
|---------|------|---------|
| `gen-basic-fallback.cpp` | 生成器 | 通用回退生成器，适用于简单题目 |
| `multigen.cpp` | 生成器 | 多组测试数据生成器 |
| `val-basic-fallback.cpp` | 校验器 | 通用回退校验器 |
| `validate-using-testset-and-group.cpp` | 校验器 | 支持子任务分组的复杂校验器 |

---

## 🔧 高级用法

### 自定义子任务分配

脚本支持任意数量的子任务，只需在命令末尾依次传入每个子任务的测试点数量：

```bash
# 2个子任务，各5个测试点
python3 scripts/generate.py gen.cpp valid.cpp std.cpp problem.md 5 5

# 4个子任务，分别为 3, 4, 3, 2 个测试点
python3 scripts/generate.py gen.cpp valid.cpp std.cpp problem.md 3 4 3 2
```

### 手动运行生成器

如需单独测试生成器：

```bash
# 编译
g++ -std=c++14 -I. gen.cpp -o gen

# 生成第1个子任务的第2个测试点
./gen 1 2 > test.in

# 查看生成的数据
cat test.in
```

### 手动运行校验器

```bash
# 编译
g++ -std=c++14 -I. valid.cpp -o valid

# 校验数据
./valid < test.in
# 返回 0 表示校验通过，非 0 表示失败
```

---

## ⚠️ 注意事项

1. **C++14 标准**：所有代码必须严格使用 C++14 语法，禁止使用 C++17 特性（如结构化绑定 `auto [u, v] : edges`）

2. **类型匹配**：使用 `rnd.next(L, R)` 时，L 和 R 的类型必须一致（同为 `int` 或同为 `long long`）

3. **Windows 兼容性**：在 Windows (MinGW) 环境下，**禁止使用 `std::shuffle(..., rnd)`**，请使用 `rnd.perm()` 或手动实现洗牌

4. **输出规范**：
   - 推荐使用 `println()` 函数输出（自动处理空格和换行）
   - **严禁使用 `print()` 函数**（testlib 中不存在）
   - 使用 `cout` 循环输出时，注意控制行末空格，避免 Validator 报 `Expected EOLN` 错误

5. **校验严格性**：Validator 必须显式读取所有空白字符（`readSpace()`, `readEoln()`, `readEof()`）

---

## 📖 参考文档

- [testlib.h 官方仓库](https://github.com/MikeMirzayanov/testlib)
- [Codeforces 题面规范](https://codeforces.com/problemset)
- [FPS (Free Problem Set) 标准](https://github.com/zhblue/freeproblemset)

---

## 🤝 贡献指南

欢迎提交 Issue 和 PR！在贡献代码前，请确保：

1. 代码符合 C++14 标准
2. 通过所有测试用例
3. 更新相关文档

---

## 📄 许可证

本项目采用 [MIT License](LICENSE) 开源协议。

---

<div align="center">

**Made with ❤️ for Competitive Programming Community**

</div>
