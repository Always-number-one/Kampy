import 'package:flutter/material.dart';
import 'dart:async';
import 'navbar_bottom_clipper.dart';

class AnimatedBottomBar extends StatefulWidget {
  final Color background;
  final Color defaultIconColor;
  final Color activatedIconColor;
  final Function(int i) onTapButton;
  final Function(int i) onTapButtonHidden;
  final List<IconData> buttonsIcons;
  final List<IconData> buttonsHiddenIcons;
  final Color backgroundColorMiddleIcon;

 AnimatedBottomBar({required this.defaultIconColor, required this.activatedIconColor, required this.background, required this.buttonsIcons, required this.buttonsHiddenIcons,required this.backgroundColorMiddleIcon, required this.onTapButton,required  this.onTapButtonHidden}):
        assert(buttonsIcons.length == buttonsHiddenIcons.length && buttonsIcons.length == 4);

  _AnimatedBottomBar createState() =>  _AnimatedBottomBar();
}

class _AnimatedBottomBar extends State<AnimatedBottomBar> with TickerProviderStateMixin {


  final StreamController<int> _streamController =  StreamController.broadcast();

  late AnimationController _controllerButtonsChanging;
 late AnimationController _controllerFloatButtonDropOut;
  late AnimationController _controllerFloatButtonDropIn;
 late AnimationController _controllerContainerDropIn;
 late AnimationController _controllerContainerDropOut;

 late Animation<double> _animationBorder;
 late Animation<double> _animationFloatButtonDropIn;
 late Animation<double> _animationFloatButtonDropOut;
 late Animation<double> _animationContainerDropIn;
 late Animation<double> _animationContainerDropOut;
 late List<Animation<double>> _animationMargin;

  double _dropContainerPosition = 0;
  double _floatButtonPosition = 0;
  var activated = false;

  @override
  void initState() {
    super.initState();
    _controllerButtonsChanging = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _controllerFloatButtonDropIn = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _controllerFloatButtonDropOut = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _controllerContainerDropIn = AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _controllerContainerDropOut = AnimationController(vsync: this, duration: Duration(milliseconds: 150));

    _controllerButtonsChanging.addListener((){
      setState(() {});
    });

    _controllerFloatButtonDropIn.addListener((){
      setState(() {
        _floatButtonPosition = _animationFloatButtonDropIn.value;
      });
    });

    _controllerFloatButtonDropOut.addListener((){
      setState(() {
        _floatButtonPosition = _animationFloatButtonDropOut.value;
      });
    });

    _controllerContainerDropIn.addListener((){
      setState(() {
        _dropContainerPosition = _animationContainerDropIn.value;
      });
    });

    _controllerContainerDropOut.addListener((){
      setState(() {
        _dropContainerPosition = _animationContainerDropOut.value;
      });
    });

  }

  void _reverse(){

    _controllerContainerDropIn.forward().whenComplete((){
      _controllerContainerDropOut.forward().whenComplete((){
        _controllerContainerDropOut.reverse().whenComplete((){
          _controllerContainerDropIn.reverse();
        });
      });
    });

    _controllerButtonsChanging.reverse();
    _controllerFloatButtonDropIn.reverse().whenComplete((){
      _controllerFloatButtonDropOut.forward().whenComplete((){
        _controllerFloatButtonDropOut.reverse();
      });
    });

  }

  void _forward(){
    _controllerButtonsChanging.forward();
    _controllerFloatButtonDropIn.forward();
  }

  void doAnimation(double circular){
    if(activated) _reverse();
    else _forward();
    activated = !activated;
  }

  Widget _buildNormalButton(int index, double widgetScreen){

    var correspondMargin = index;
    if(index >= widget.buttonsHiddenIcons.length/2) correspondMargin++;

    return  GestureDetector(child:
       Card(color: widget.background, elevation: _animationMargin[0].value, margin: EdgeInsets.only(bottom: _animationMargin[correspondMargin%2].value), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_animationBorder.value)), child:
         StreamBuilder(stream: _streamController.stream, initialData: 0, builder: (context, AsyncSnapshot<int> snapshot) {
          return
             Container(width: widgetScreen, height: widgetScreen, padding: EdgeInsets.symmetric(vertical: 10), child:
               Icon(activated ? widget.buttonsHiddenIcons[index] : widget.buttonsIcons[index], size: snapshot.data == index && !activated ? 30 : 25, color: snapshot.data == index && !activated ? widget.activatedIconColor : widget.defaultIconColor)
            );
        })
      ), onTap: (){
      if(activated) widget.onTapButtonHidden(index);
      else{
        _streamController.sink.add(index);
        widget.onTapButton(index);
      }
    });
  }

  Widget _buildMiddleButton(double widgetScreen){
    return  Stack(alignment: Alignment.bottomCenter,children: <Widget>[
       AnimatedOpacity(duration: const Duration(milliseconds: 100),opacity: activated ? 0 : 1.0, child:
         ClipPath(clipper: BottomWaveClipper(convex: _dropContainerPosition), child:
           Container(color: widget.background, width: widgetScreen + 30, height: widgetScreen*1.2)
        )
      ),
       Padding(padding: EdgeInsets.only(bottom: _floatButtonPosition == 0 ? widgetScreen/1.8 : _floatButtonPosition), child:
         Transform.rotate(angle: (_animationMargin[0].value/20)*2.3, child:  FloatingActionButton(backgroundColor: widget.backgroundColorMiddleIcon, onPressed:() => doAnimation(widgetScreen), child:  Icon(Icons.add, size: 30)))
      )
    ]);
  }

  List<Widget> _buildContent(double widgetScreen){
    List<Widget> content = [];

    for(var i=0; i<widget.buttonsHiddenIcons.length; i++){
      if(i == widget.buttonsHiddenIcons.length/2)
        content.add(_buildMiddleButton(widgetScreen));

      content.add(_buildNormalButton(i, widgetScreen));
    }

    return content;
  }

  @override
  Widget build(BuildContext context) {

    var widgetScreen = MediaQuery.of(context).size.width/5 - 6;

    _animationMargin = [
       Tween<double>(begin: 0.0, end: 20.0).animate(CurvedAnimation(
        parent: _controllerButtonsChanging,
        curve: Curves.ease,
      )),
       Tween<double>(begin: 0.0, end: 60.0).animate(CurvedAnimation(
        parent: _controllerButtonsChanging,
        curve: Curves.ease,
      )),
    ];

    _animationBorder =  Tween<double>(begin: 0.0, end: widgetScreen).animate(CurvedAnimation(
      parent: _controllerButtonsChanging,
      curve: Curves.ease,
    ));

    _animationBorder =  Tween<double>(begin: 0.0, end: widgetScreen).animate(CurvedAnimation(
      parent: _controllerButtonsChanging,
      curve: Curves.ease,
    ));

    _animationFloatButtonDropIn =  Tween<double>(begin: widgetScreen/1.8, end: 10).animate(CurvedAnimation(
        parent: _controllerFloatButtonDropIn,
        curve: Curves.ease,
    ));

    _animationFloatButtonDropOut =  Tween<double>(begin: widgetScreen/1.8, end: widgetScreen*1.5).animate(CurvedAnimation(
      parent: _controllerFloatButtonDropOut,
      curve: Curves.ease,
    ));

    _animationContainerDropIn =  Tween<double>(begin: 0, end: 0.8).animate(CurvedAnimation(
      parent: _controllerContainerDropIn,
      curve: Curves.ease,
    ));

    _animationContainerDropOut =  Tween<double>(begin: 0.8, end: 1).animate(CurvedAnimation(
      parent: _controllerContainerDropOut,
      curve: Curves.ease,
    ));

    return  Container(color: Colors.transparent, width: MediaQuery.of(context).size.width, child:
       Row(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.end, children: _buildContent(widgetScreen))
    );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

}