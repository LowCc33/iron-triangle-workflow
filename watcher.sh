#!/bin/bash

# 铁三角工作流 - Watcher调度器（公开简化版）
# 核心功能：每分钟轮询，自动检测新任务并分配

WORK_DIR=$(pwd)
PENDING_DIR="$WORK_DIR/pending"
RUNNING_DIR="$WORK_DIR/running"
DONE_DIR="$WORK_DIR/done"
REJECTED_DIR="$WORK_DIR/rejected"
RECEIPTS_DIR="$WORK_DIR/receipts"
ALARMS_DIR="$WORK_DIR/alarms"
RULES_DIR="$WORK_DIR/rules"

LOG_FILE="$WORK_DIR/watcher.log"

echo "🚀 铁三角Watcher启动..." >> "$LOG_FILE"
echo "📂 工作目录: $WORK_DIR" >> "$LOG_FILE"

while true; do
    echo "🔍 轮询检查新任务... $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"

    # 1. 同步Git，解决WSL缓存问题
    cd "$WORK_DIR"
    git pull > /dev/null 2>&1

    # 2. 检查pending目录下的新任务
    for task_file in "$PENDING_DIR"/*.md "$PENDING_DIR"/*.txt 2>/dev/null; do
        [ -e "$task_file" ] || continue

        task_name=$(basename "$task_file")
        echo "✅ 发现新任务: $task_name" >> "$LOG_FILE"

        # 3. 幂等性校验：检查是否已经在running/done里
        if [ -e "$RUNNING_DIR/$task_name" ] || [ -e "$DONE_DIR/$task_name" ]; then
            echo "⚠️  任务已存在，跳过: $task_name" >> "$LOG_FILE"
            continue
        fi

        # 4. 规则注入：将总规则、代码规范注入任务最前端
        temp_file=$(mktemp)
        echo "【本任务自动注入以下永久生效规则】" > "$temp_file"
        echo "========================================" >> "$temp_file"

        # 注入所有规则文件
        for rule in "$RULES_DIR"/*; do
            [ -f "$rule" ] || continue
            echo "" >> "$temp_file"
            cat "$rule" >> "$temp_file"
            echo "" >> "$temp_file"
            echo "========================================" >> "$temp_file"
        done

        echo "【规则注入结束，以下是任务内容】" >> "$temp_file"
        echo "" >> "$temp_file"
        cat "$task_file" >> "$temp_file"
        mv "$temp_file" "$task_file"

        # 5. 移到running目录（认领任务）
        mv "$task_file" "$RUNNING_DIR/$task_name"
        echo "⚔️  任务已认领，开始执行: $task_name" >> "$LOG_FILE"

        # 6. 提交Git
        git add .
        git commit -m "🤖 认领任务: $task_name" > /dev/null 2>&1
        git push > /dev/null 2>&1

        # TODO: 这里是具体Agent执行逻辑，根据你的需求实现
        # 公开版只展示调度框架，不包含具体Agent调用逻辑
    done

    # 7. 等待60秒下一轮
    sleep 60
done
