import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reto_seek/seek.dart';
import 'package:reto_seek/src/bloc/bloc.dart';

void main() {
  runApp( 
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ColorBloc()),
      ],
      child: ProviderScope(child: Seek()),
    )
  );
}
