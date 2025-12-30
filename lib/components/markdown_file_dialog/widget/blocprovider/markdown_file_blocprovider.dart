import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:veteranam/components/markdown_file_dialog/bloc/markdown_file_cubit.dart';

class MarkdownFileBlocprovider extends StatelessWidget {
  const MarkdownFileBlocprovider({
    required this.widgetChild,
    required this.ukFilePath,
    required this.enFilePath,
    super.key,
  });
  final Widget widgetChild;
  final String ukFilePath;
  final String? enFilePath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<MarkdownFileCubit>()
        ..init(
          ukFilePath: ukFilePath,
          enFilePath: enFilePath,
        ),
      child: widgetChild,
    );
  }
}
