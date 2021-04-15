import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

typedef SendCallback = void Function(String);

///
///  聊天输入框控件
///
class InputBoxWidget extends StatefulWidget {
  final Widget body;
  final SendCallback callback;

  InputBoxWidget({@required this.body, this.callback});

  @override
  _InputBoxWidgetState createState() => _InputBoxWidgetState();
}

class _InputBoxWidgetState extends State<InputBoxWidget>
    with WidgetsBindingObserver {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();

  // 软键盘高度
  double keyboardHeight = 0;

  // 软键盘是否显示
  bool _isShowKeyboard = true;

  // 表情面板是否显示
  bool _isShowEmoticons = false;

  // icon 按钮是否为键盘类型
  bool _keyboardBtn = false;

  // 输入完成，收起键盘
  bool _isComplete = false;

  VoidCallback _focusListener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 首次获取软键盘的高度
      if (keyboardHeight == 0) keyboardHeight = _getBottom();
    });

    WidgetsBinding.instance.addObserver(this);

    _focusListener = () {
      // 输入框有焦点时，键盘自动显示，反之亦然
      _isShowKeyboard = _focus.hasFocus;
    };

    // 注册输入框焦点监听
    _focus.addListener(_focusListener);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _focus.removeListener(_focusListener);
    super.dispose();
  }

  ///
  ///  屏幕发生改变时回调(弹出键盘,旋转屏幕)
  ///  在键盘弹出的一瞬间回调该方法
  ///
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // 首次获取软键盘的高度(initState中未获取成功的情况下再次获取)
    if (keyboardHeight == 0) keyboardHeight = _getBottom();

    // 表情面板切键盘面板
    if (_isShowKeyboard && _isShowEmoticons) {
      setState(() {
        _isShowEmoticons = false;
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_isComplete) {
        var isShowKeyboard = _getBottom() != 0;
        // 键盘面板切表情面板
        if (!isShowKeyboard) {
          setState(() {
            _isShowEmoticons = !isShowKeyboard;
          });
        }
        setState(() {
          _keyboardBtn = !isShowKeyboard;
        });
      } else if (_isComplete) {
        _isComplete = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: widget.body,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin:
                      EdgeInsets.only(left: 16, bottom: 6, top: 6, right: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                      controller: _controller,
                      autofocus: true,
                      focusNode: _focus,
                      decoration: InputDecoration.collapsed(
                          hintText: '123131312321313'),
                      onEditingComplete: () {
                        _isComplete = true;
                        _focus.unfocus();
                      }),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    if (_keyboardBtn) {
                      _focus.requestFocus();
                    } else {
                      if (!_isShowKeyboard) {
                        setState(() {
                          _isShowEmoticons = true;
                        });
                      } else {
                        _focus.unfocus();
                      }
                    }
                    _keyboardBtn = !_keyboardBtn;
                  },
                  child: _keyboardBtn
                      ? WebsafeSvg.asset("assets/keyboard.svg",
                          width: 32, height: 32)
                      : WebsafeSvg.asset("assets/laugh.svg",
                          width: 32, height: 32)),
              SizedBox(
                width: 6,
              ),
              GestureDetector(
                  onTap: () {
                    if (widget.callback != null) {
                      widget.callback.call(_controller.text);
                    }
                    _controller.clear();
                  },
                  child: Image.asset("assets/send.png", width: 32, height: 32)),
              SizedBox(
                width: 16,
              ),
            ],
          ),
          Offstage(
            offstage: _isComplete || (_isShowKeyboard && !_isShowEmoticons),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              height: keyboardHeight,
              child: GridView.count(
                crossAxisCount: 9,
                crossAxisSpacing: 9.5,
                mainAxisSpacing: 8.0,
                children: _emojis.map((e) => _buildItem(e)).toList(),
              ),
            ),
          )
        ]);
  }

  /// 获取键盘高度
  _getBottom() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .viewInsets
        .bottom;
  }

  Widget _buildItem(String e) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _controller.text += e,
      child: Text(e, style: TextStyle(fontSize: 24)),
    );
  }
}

const _emojis = const [
  '😀',
  '😃',
  '😄',
  '😁',
  '😆',
  '😅',
  '😂',
  '🤣',
  '😊',
  '😇',
  '🙂',
  '🙃',
  '😉',
  '😌',
  '😍',
  '😘',
  '😗',
  '😙',
  '😚',
  '😋',
  '😛',
  '😝',
  '😜',
  '🤪',
  '🤨',
  '😎',
  '🤩',
  '😏',
  '😒',
  '😞',
  '😔',
  '😕',
  '🙁',
  '☹️',
  '😣',
  '😖',
  '😫',
  '😩',
  '😢',
  '😭',
  '😤',
  '😠',
  '😡',
  '🤬',
  '🤯',
  '😳',
  '😱',
  '😨',
  '🤬'
];
