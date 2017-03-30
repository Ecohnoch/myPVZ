# myPVZ
工程简介
=====
<br>
# 一.平台

Qt5.7 , QtQuick2.7, Windows10 和 Ubuntu下均编译通过
<br>
# 二.界面

## 1.标题界面<br>

### 1.1三个开始游戏的按钮 <br>

都具有[静默],[浮动],[点击]三种状态, 点击后均能直接进入游戏, 进入时销毁标题界面,释放内存. <br>

### 1.2选项, 帮助 和退出按钮 <br>

具有状态同上, 点击后出现不同的弹出层, 弹出层内按钮也都具备上述状态, 其中选项可进行音乐和音效的关闭操作. <br>
<br>

## 2. 特效 <br>

### 2.1切换场景的特效 <br>

标题界面和游戏主工程切换时有一个mask的效果, 结束后内存会释放<br>

### 2.2开始前的动画特效 <br>

标题界面和游戏主工程切换到最后有一个动画过度效果, 结束后内存会释放, 平行移动方程InOutQuad.<br>

### 2.3卡牌冷却特效<br>

使用卡牌种植之后会有一个冷却的无法点击的效果. <br>

### 2.4种植准备特效<br>

(感觉这个应该算不上特效...)准备种植时该植物会随着鼠标而运动. <br>

### 2.5阳光出现和收集特效<br>

阳光出现会从小变大, 收集时会移动到左上角的计数器处, 移动方程InOutQuad. <br>

<br>

## 3.游戏界面<br>

### 3.1主区域<br>

由45块透明矩形构成<br>

### 3.2菜单选择区域<br>

由六张卡牌和阳光数量构成, 点击卡牌可以在主区域进行种植.<br>

<br>

## 4.游戏对象<br>

### 4.1 植物组件

最重要的属性为isPlant属性, 用该整形变量去表示该植物的种类, 用该属性去控制了植物图像的源路径, 植物的特有动作(如向日葵积累阳光)<br>

其他属性包括血量, 攻击等等..<br>

### 4,2 僵尸组件<br>

最重要的属性为isZombie属性, 用该整形变量去表示僵尸的种类, 用该属性去控制了僵尸图像的源路径, 速度, 血量等. <br>

<br>

## 5.游戏规则<br>

### 5.1 植物打僵尸<br>

攻击性植物定时发射[炮弹], 一旦击中僵尸[炮弹]会消失, 僵尸的血量会减少, 打为0时僵尸消失.<br>

### 5.2 僵尸吃植物<br>

僵尸进入植物区域时, 僵尸会进入[吃]状态, 植物血会减少, 为0时植物消失. <br>

<br>

## 6.作者信息 <br>

岐山凤鸣, 作于2016年9月.
