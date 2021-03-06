import 'package:backdrop/scaffold.dart';
import 'package:flutter/material.dart';

/* 
  TODO:  
  - [ ] Make this Widget receive information from ListView (or any child that 
  returns data from scrolling) and auto-hides the Divider when the child is in 
  its home position.

*/

/// A wrapper for adding a sub-header to the used backdrop front layer(s).
/// This class can be passed to [BackdropScaffold] to specify the sub-header
/// that should be shown while the front layer is "inactive" (the back layer is
/// "showing").
///
/// Usage example:
/// ```dart
/// BackdropScaffold(
///   appBar: ...,
///   backLayer: ...,
///   subHeader: BackdropSubHeader(
///     title: Text("Sub Header"),
///   ),
///   frontLayer: ...,
/// )
/// ```
class BackdropSubHeader extends StatelessWidget {
  /// The primary content of the sub-header.
  final Widget title;

  /// The divider that should be shown at the bottom of the sub-header.
  ///
  /// Defaults to `Divider(height: 4.0, indent: 16.0, endIndent: 16.0)`.
  final Widget divider;

  /// Padding that will be applied to the sub-header.
  ///
  /// Defaults to `EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0)`.
  final EdgeInsets padding;

  /// Flag indicating whether the leading widget for the sub-header should be
  /// automatically determined by [BackdropSubHeader].
  ///
  /// If set to `true`, a leading `Icon(Icons.keyboard_arrow_up)` is added to
  /// the sub-header.
  ///
  /// Defaults to `false`.
  final bool automaticallyImplyLeading;

  /// Flag indicating whether the trailing widget for the sub-header should be
  /// automatically determined by [BackdropSubHeader].
  ///
  /// If set to `true`, a trailing `Icon(Icons.keyboard_arrow_up)` is added to
  /// the sub-header.
  ///
  /// Defaults to `true`.
  final bool automaticallyImplyTrailing;

  /// Widget to be shown as leading element to the sub-header. If set, the value
  /// of [automaticallyImplyLeading] is ignored.
  final Widget leading;

  /// Widget to be shown as trailing element to the sub-header. If set, the value
  /// of [automaticallyImplyTrailing] is ignored.
  final Widget trailing;

  /// Creates a [BackdropSubHeader] instance.
  ///
  /// The [title] argument must not be `null`.
  const BackdropSubHeader({
    Key key,
    @required this.title,
    this.divider,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    this.automaticallyImplyLeading = false,
    this.automaticallyImplyTrailing = true,
    this.leading,
    this.trailing,
  })  : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildAutomaticLeadingOrTrailing(BuildContext context) =>
        FadeTransition(
          opacity: Tween(begin: 1.0, end: 0.0)
              .animate(Backdrop.of(context).controller),
          child: Icon(Icons.keyboard_arrow_up),
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: padding,
          child: Row(
            children: <Widget>[
              leading ??
                  (automaticallyImplyLeading
                      ? _buildAutomaticLeadingOrTrailing(context)
                      : Container()),
              Expanded(
                child: title,
              ),
              trailing ??
                  (automaticallyImplyTrailing
                      ? _buildAutomaticLeadingOrTrailing(context)
                      : Container()),
            ],
          ),
        ),

        /// Here I decided to change the default to suit the prototypes, since
        /// in the current version of the packet the Divider does not
        /// self-conceal when the frontLayer isn't scrolling.
        ///
        divider ??
            const Divider(
              height: 4.0,
              indent: 16.0,
              endIndent: 16.0,
              color: Colors.transparent,
            ),
      ],
    );
  }
}
