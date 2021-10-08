import 'dart:async';

import 'package:bloc_scratch_code/counter_event.dart';

class CounterBloc{
  int _counter=0;
  final _counterStateContoller = StreamController<int>();
  // .sink takes in the input
  StreamSink <int> get _inCounter => _counterStateContoller.sink;
  // and .stream takes in the output
  Stream<int> get counter => _counterStateContoller.stream;
  final _counterEventController =StreamController<CounterEvent>();
  Sink<CounterEvent>get counterEventSink => _counterEventController.sink;
  CounterBloc(){
    _counterEventController.stream.listen(_mapEventToState);
  }
  void _mapEventToState(CounterEvent event){
    if(event is IncrementEvent){
      _counter++;
    }
    else if (event is DecrementEvent){
      _counter --;
    }
    _inCounter.add(_counter);
  }
  void dispose(){
    _counterStateContoller.close();
    _counterEventController.close();
  }

}