#!/bin/bash

# 铁三角工作流初始化脚本
# 创建6目录状态机结构

echo "🚀 正在初始化铁三角工作流..."

# 创建6目录结构
mkdir -p pending running done rejected receipts alarms

# 为每个目录创建.gitkeep，确保空目录能被Git跟踪
for dir in pending running done rejected receipts alarms; do
    touch "$dir/.gitkeep"
    echo "✅ 创建目录: $dir/"
done

# 创建rules目录放示例规则
mkdir -p rules
touch rules/.gitkeep
echo "✅ 创建目录: rules/"

echo ""
echo "🎉 初始化完成！"
echo ""
echo "目录结构："
echo "├── pending/    - 待执行任务"
echo "├── running/    - 执行中任务"
echo "├── done/       - 已完成任务"
echo "├── rejected/   - 被驳回任务"
echo "├── receipts/   - 回执确认"
echo "├── alarms/     - 异常告警"
echo "└── rules/      - 规则文件"
