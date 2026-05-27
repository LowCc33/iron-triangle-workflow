# 铁三角Git驱动多Agent协同开发工作流（公开版）

基于Git文件驱动的全自动多Agent协同开发框架，实现「1人拥有产品+开发+QA完整团队」。

## 核心架构
- **8目录状态机**：pending→running→testing→returning→paused→done+alarms+receipts
  Git即唯一状态总线，天然带版本历史与责任溯源
- **分层IDENTITY设计**：通用框架层(IDENTITY-角色.md) + 项目配置层(PROJECT.yaml声明式)
  新项目10分钟零代码接入
- **Shift-Left测试金字塔**：单元(pytest/ruff/bandit)→集成(curl API)→降级测试→性能验收
  四级自动化测试，替代传统"代码审核Agent"

## 架构演进（1周3次迭代）
v1.0 → 6目录单点审核架构 → 发现"同模型自审无价值"问题
v2.0 → 异构协同架构 → 大将军(代码模型)+军师(测试模型)分离
v3.0 → Shift-Left测试金字塔 → 砍掉主观审核，全自动化测试闭环

## 核心特性（公开版包含）
- 智能分级故障处理：high/medium/low三级触发不同动作
- 责任溯源机制：精准归因配置层/代码层/环境层
- Dogfooding验证：用工作流本身开发ai-workflow-stats统计工具

## 已接入项目验证
✅ LocalRAG-CS (web-service类型)
✅ ai-workflow-stats (CLI工具类型)

## 说明
本仓库为公开架构示例版，完整生产级规则、踩坑文档、一键部署脚本为商业交付内容。
作者为转行AI开发，全职工作下每天3-4小时独立完成，欢迎提Issue交流！
