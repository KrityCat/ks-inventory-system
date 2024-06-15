class RMBConverter {
    static numberToChinese(money) {
        // 汉字的数字
        const cnNums = ['零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖',]
        // 基本单位
        const cnIntRadice = ['', '拾', '佰', '仟']
        // 对应整数部分扩展单位
        const cnIntUnits = ['', '万', '亿', '兆']
        // 对应小数部分单位
        const cnDecUnits = ['角', '分']
        // 整数金额时后面跟的字符
        const cnInteger = '整'
        // 整型完以后的单位
        const cnIntLast = '圆'
        // 最大处理的数字
        const maxNum = 9999999999999999.99
        // 金额整数部分
        let integerNum
        // 金额小数部分
        let decimalNum
        // 输出的中文金额字符串
        let chineseStr = ''
        // 分离金额后用的数组，预定义
        let parts
        if (money === '') {
            return ''
        }
        money = parseFloat(money)
        if (money >= maxNum) {
            // 超出最大处理数字
            return ''
        }

        //值为0 赋值为 空字符
        if (money === 0) {
            return '';
        }

        // 转换为字符串
        money = money.toString()
        //负数 最前方加入 负
        if (money.indexOf('-') === 0) {
            chineseStr += '负'
            money = money.substr(1)
        }
        if (money.indexOf('.') === -1) {
            integerNum = money

            decimalNum = ''
        } else {
            parts = money.split('.')
            integerNum = parts[0]
            decimalNum = parts[1].substr(0, 4)
        }
        // 获取整型部分转换
        if (parseInt(integerNum, 10) > 0) {
            let zeroCount = 0
            const IntLen = integerNum.length
            for (let i = 0; i < IntLen; i++) {
                const n = integerNum.substr(i, 1)
                const p = IntLen - i - 1
                const q = p / 4
                const m = p % 4
                if (n === '0') {
                    zeroCount++
                } else {
                    if (zeroCount > 0) {
                        chineseStr += cnNums[0]
                    }
                    // 归零
                    zeroCount = 0
                    //alert(cnNums[parseInt(n)])
                    chineseStr += cnNums[parseInt(n)] + cnIntRadice[m]
                }
                if (m === 0 && zeroCount < 4) {
                    chineseStr += cnIntUnits[q]
                }
            }
            chineseStr += cnIntLast
        }
        //小数部分
        if (decimalNum !== '') {
            const decLen = decimalNum.length
            for (let i = 0; i < decLen; i++) {
                const n = decimalNum.substr(i, 1)
                if (n !== '0') {
                    chineseStr += cnNums[Number(n)] + cnDecUnits[i]
                }
            }
        }

        if (chineseStr === '') {
            chineseStr += cnNums[0] + cnIntLast + cnInteger
        } else if (decimalNum === '') {
            chineseStr += cnInteger
        }
        return chineseStr
    }
}


export default RMBConverter;

