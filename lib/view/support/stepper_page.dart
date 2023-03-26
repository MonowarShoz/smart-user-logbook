import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'custom_stepper.dart' as custstepper;

class MyStepper extends StatefulWidget {
  const MyStepper({super.key});

  @override
  State<MyStepper> createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  int _index = 0;

  final _scrollController = ScrollController();
  //final GlobalKey newexpansionTIleKey = GlobalKey();
  _scrollToSelectedContent(bool isExpanded, double previousOffset, int index, GlobalKey mykey) {
    final keyContext = mykey.currentContext;
    if (keyContext != null) {
      final box = keyContext.findRenderObject() as RenderBox;
      _scrollController.animateTo(
        isExpanded ? (box.size.height * index) : previousOffset,
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
  }

  List<Widget> _buildExpansionTileChildren() => [
        FlutterLogo(
          size: 50.0,
        ),
        Text(
          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit.
           Suspendisse vulputate arcu interdum lacus pulvinar aliquam.
            Donec ut nunc eleifend, volutpat tellus vel, volutpat libero.
             Vestibulum et eros lorem. Nam ut lacus sagittis, varius risus faucibus,
              lobortis arcu. Nullam tempor vehicula nibh et ornare. Etiam interdum
               tellus ut metus faucibus semper. Aliquam quis ullamcorper urna, non 
               semper purus. Mauris luctus quam enim, ut ornare magna vestibulum vel.
                Donec consectetur, quam a mattis tincidunt, augue nisi bibendum est, quis
                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
           Suspendisse vulputate arcu interdum lacus pulvinar aliquam.
            Donec ut nunc eleifend, volutpat tellus vel, volutpat libero.
             Vestibulum et eros lorem. Nam ut lacus sagittis, varius risus faucibus,
              lobortis arcu. Nullam tempor vehicula nibh et ornare. Etiam interdum
               tellus ut metus faucibus semper. Aliquam quis ullamcorper urna, non 
               semper purus. Mauris luctus quam enim, ut ornare magna vestibulum vel.
                Donec consectetur, quam a mattis tincidunt, augue nisi bibendum est, quis
                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
           Suspendisse vulputate arcu interdum lacus pulvinar aliquam.
            Donec ut nunc eleifend, volutpat tellus vel, volutpat libero.
             Vestibulum et eros lorem. Nam ut lacus sagittis, varius risus faucibus,
              lobortis arcu. Nullam tempor vehicula nibh et ornare. Etiam interdum
               tellus ut metus faucibus semper. Aliquam quis ullamcorper urna, non 
               semper purus. Mauris luctus quam enim, ut ornare magna vestibulum vel.
                Donec consectetur, quam a mattis tincidunt, augue nisi bibendum est, quis
                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
           Suspendisse vulputate arcu interdum lacus pulvinar aliquam.
            Donec ut nunc eleifend, volutpat tellus vel, volutpat libero.
             Vestibulum et eros lorem. Nam ut lacus sagittis, varius risus faucibus,
              lobortis arcu. Nullam tempor vehicula nibh et ornare. Etiam interdum
               tellus ut metus faucibus semper. Aliquam quis ullamcorper urna, non 
               semper purus. Mauris luctus quam enim, ut ornare magna vestibulum vel.
                Donec consectetur, quam a mattis tincidunt, augue nisi bibendum est, quis
                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
           Suspendisse vulputate arcu interdum lacus pulvinar aliquam.
            Donec ut nunc eleifend, volutpat tellus vel, volutpat libero.
             Vestibulum et eros lorem. Nam ut lacus sagittis, varius risus faucibus,
              lobortis arcu. Nullam tempor vehicula nibh et ornare. Etiam interdum
               tellus ut metus faucibus semper. Aliquam quis ullamcorper urna, non 
               semper purus. Mauris luctus quam enim, ut ornare magna vestibulum vel.
                Donec consectetur, quam a mattis tincidunt, augue nisi bibendum est, quis
                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
           Suspendisse vulputate arcu interdum lacus pulvinar aliquam.
            Donec ut nunc eleifend, volutpat tellus vel, volutpat libero.
             Vestibulum et eros lorem. Nam ut lacus sagittis, varius risus faucibus,
              lobortis arcu. Nullam tempor vehicula nibh et ornare. Etiam interdum
               tellus ut metus faucibus semper. Aliquam quis ullamcorper urna, non 
               semper purus. Mauris luctus quam enim, ut ornare magna vestibulum vel.
                Donec consectetur, quam a mattis tincidunt, augue nisi bibendum est, quis
                
                 viverra risus odio ac ligula. Nullam vitae urna malesuada magna imperdiet faucibus non et nunc. Integer magna nisi, dictum a tempus in, bibendum quis nisi. Aliquam imperdiet metus id metus rutrum scelerisque. Morbi at nisi nec risus accumsan tempus. Curabitur non sem sit amet tellus eleifend tincidunt. Pellentesque sed lacus orci.expansionTIleKeyexpansionTIleKeyexpansionTIleKeyexpansionTIleKeyexpansionTIleKeyexpansionTIleKeyexpansionTIleKeexpansionTIleKeyexpansionTIleKeyy''',
          textAlign: TextAlign.justify,
        ),
      ];

  _buildExpansionTile(int index) {
    final GlobalKey expansionTIleKey = GlobalKey();
    double? previousOffset;
    return ExpansionTile(
      //   key: newexpansionTIleKey,
      key: expansionTIleKey,
      onExpansionChanged: (isExpanded) {
        if (isExpanded) {
          _newscrollToSelectedContent(expansionTileKey: expansionTIleKey);
        }
        // if (isExpanded) {
        //   previousOffset = _scrollController.offset;
        // }
        // _scrollToSelectedContent(isExpanded, previousOffset!, index, expansionTIleKey);
      },
      title: Text('My expansion tile $index'),
      children: _buildExpansionTileChildren(),
    );
  }

  void _newscrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext, duration: Duration(milliseconds: 200));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Support'),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.black,
              width: double.infinity,
              height: 100,
            ),
            Container(
              color: Colors.red,
              width: double.infinity,
              height: 100,
            ),
            Container(
              color: Colors.yellow,
              width: double.infinity,
              height: 100,
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: 120,
                itemBuilder: (context, index) {
                  return _buildExpansionTile(index);
                },
              ),
            ),
          ],
        ));
  }
}
