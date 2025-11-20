import nimib
import strutils

nbInit

nbText: """
# RPN 计算器手册

RPN（逆波兰表示法）是一种数学表达式表示法，其中运算符位于操作数之后。

## 基本操作

RPN 计算器使用栈来存储操作数。以下是一些基本操作示例：
"""

nbCode:
  # RPN 计算器实现
  type
    Stack = seq[float]
  
  proc push(s: var Stack, value: float) =
    s.add(value)
  
  proc pop(s: var Stack): float =
    if s.len > 0:
      result = s[^1]
      s.setLen(s.len - 1)
    else:
      raise newException(ValueError, "栈为空")

  proc evaluateRPN(expression: string): float =
    var stack: Stack
    let tokens = expression.split()
    
    for token in tokens:
      case token
      of "+":
        let b = stack.pop()
        let a = stack.pop()
        stack.push(a + b)
      of "-":
        let b = stack.pop()
        let a = stack.pop()
        stack.push(a - b)
      of "*":
        let b = stack.pop()
        let a = stack.pop()
        stack.push(a * b)
      of "/":
        let b = stack.pop()
        let a = stack.pop()
        stack.push(a / b)
      else:
        # 尝试将 token 解析为数字
        try:
          let number = parseFloat(token)
          stack.push(number)
        except ValueError:
          raise newException(ValueError, "无效的 token: " & token)
    
    if stack.len == 1:
      return stack.pop()
    else:
      raise newException(ValueError, "表达式不完整")

nbText: """
## 使用示例

让我们使用上面实现的 RPN 计算器来计算一些表达式：
"""

nbCode:
  # 示例 1: 简单的加法
  let expr1 = "3 4 +"
  echo "表达式: ", expr1
  echo "结果: ", evaluateRPN(expr1)

nbCode:
  # 示例 2: 复杂的表达式
  let expr2 = "5 1 2 + 4 * + 3 -"
  echo "表达式: ", expr2
  echo "结果: ", evaluateRPN(expr2)

nbText: """
## RPN 表达式示例

| 中缀表达式 | RPN 表达式 | 结果 |
|-----------|------------|------|
| 3 + 4 | 3 4 + | 7 |
| (5 + (1 + 2) × 4) - 3 | 5 1 2 + 4 * + 3 - | 14 |
| 10 × (2 + 3) | 10 2 3 + * | 50 |

## 优势

1. **无需括号**: RPN 不需要括号来指定运算顺序
2. **易于实现**: 使用栈数据结构很容易实现
3. **计算效率高**: 一次扫描即可完成计算

## 注意事项

- 确保表达式中有足够的操作数
- 除法操作时注意除零错误
- 表达式结束时栈中应该只有一个值
"""

nbSave

