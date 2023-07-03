# Go-cqhttp-device-json-generator
用于在 adb shell 中生成 [go-cqhttp](https://github.com/Mrs4s/go-cqhttp) device.json 的 shell 脚本 

## 用法
* 修改 `custom` 部分的内容( protocol 等)
* 在 termux shell 中执行(推荐)
    ```
    git clone https://github.com/5kind/go-cqhttp-device-json-generator
    sudo bash go-cqhttp-device-json-generator/device.sh > device.json
    ```
* 在 adb shell 中执行
    ```
    git clone https://github.com/5kind/go-cqhttp-device-json-generator
    cd go-cqhttp-device-json-generator
    adb push device.sh /sdcard
    adb shell sh /sdcard/device.sh > device.json
    ```
    （可能需要修改格式）

## 其他
* 详阅代码 [device.sh](device.sh)
* bug 优化建议等可提交 issue
