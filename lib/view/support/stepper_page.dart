import 'package:flutter/material.dart';
import 'custom_stepper.dart' as custstepper;

class MyStepper extends StatefulWidget {
  const MyStepper({super.key});

  @override
  State<MyStepper> createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  int _index = 0;

  List<custstepper.Step> getStep() {
    List<custstepper.Step> _steps = <custstepper.Step>[
      custstepper.Step(
        isActive: _index >= 0,
        state: _index > 0 ? custstepper.StepState.complete : custstepper.StepState.indexed,
        title: const Text(''),
        label: Text('Step 1'),
        content: const Text('Content for Step 1'),
      ),
      custstepper.Step(
        isActive: _index >= 1,
        state: _index > 1 ? custstepper.StepState.complete : custstepper.StepState.indexed,
        title: Text(''),
        label: Text('Step 2'),
        content: Text('Content for Step 2'),
      ),
      custstepper.Step(
        isActive: _index >= 2,
        state: _index > 2 ? custstepper.StepState.complete : custstepper.StepState.editing,
        title: Text(''),
        label: Text('Step 3'),
        content: Text('Content for Step 3'),
      ),
      // custstepper.Step(
      //   isActive: _index >= 3,
      //   state: _index > 3 ? custstepper.StepState.complete : custstepper.StepState.editing,
      //   title: Text(''),
      //   label: Text('Step 4'),
      //   content: Text('Content for Step 4'),
      // ),
      // custstepper.Step(
      //   isActive: _index == 4,
      //   state: _index == 4 ? custstepper.StepState.complete : custstepper.StepState.editing,
      //   title: Text(''),
      //   label: Text('Step 5'),
      //   content: Text('Content for Step 5'),
      // ),
    ];
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'),
      ),
      body: Theme(
        data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.green,

                //background: Colors.red,
                //secondary: Colors.green,
              ),
        ),
        child: Padding(
          padding: EdgeInsets.zero,
          child: custstepper.Stepper(
            elevation: 0,
            type: custstepper.StepperType.horizontal,
            currentStep: _index,
            controlsBuilder: (context, details) {
              return Row(
                children: <Widget>[
                  TextButton(
                    onPressed: details.onStepContinue,
                    child: Text('Continue to Step ${details.stepIndex + 1}'),
                  ),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: Text('Back to Step ${details.stepIndex - 1}'),
                  ),
                ],
              );
            },
            onStepCancel: () {
              if (_index > 0) {
                setState(() {
                  _index -= 1;
                });
              }
            },
            onStepContinue: () {
              setState(() {
                if (_index < getStep().length - 1) {
                  _index += 1;
                  // if (_index >= 0) {
                  //   setState(() {
                  //     _index += 1;
                  //   });
                  // }
                } else {
                  _index = 0;
                }
              });
            },
            onStepTapped: (int index) {
              setState(() {
                _index = index;
              });
            },
            steps: getStep(),
          ),
        ),
      ),
    );
  }
}
