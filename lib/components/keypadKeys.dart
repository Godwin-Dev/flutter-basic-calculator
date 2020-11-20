import 'package:flutter/material.dart';

class KeypadKeys extends StatelessWidget {
  KeypadKeys({@required this.text, this.onPressed, this.color, this.circle});
  final String text;
  final Function onPressed;
  final Color color;
  final bool circle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: text == "ANS"
          ? const EdgeInsets.all(8.0)
          : const EdgeInsets.all(12.0),
      child: circle != null
          ? CircleAvatar(
              backgroundColor: color,
              radius: 35.0,
              child: InkWell(
                onTap: onPressed,
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          : FlatButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: text == "ANS"
                    ? TextStyle(
                        fontSize: 18.0,
                        color: color,
                        fontWeight: FontWeight.w600)
                    : TextStyle(
                        fontSize: 32.0,
                        color: color,
                        fontWeight: FontWeight.w600),
              )),
    );
  }
}

class LandscapeKeypadKeys extends StatelessWidget {
  LandscapeKeypadKeys(
      {@required this.text, this.onPressed, this.color, this.circle});

  final String text;
  final Function onPressed;
  final Color color;
  final bool circle;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Container(
      height: media.size.height * 0.08,
      width: media.size.width * 0.090,
      child: FlatButton(
        onPressed: onPressed,
        padding: EdgeInsets.all(3.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: media.size.height * 0.050,
              color: color,
              fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
