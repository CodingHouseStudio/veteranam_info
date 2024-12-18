import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

// class QuestionWidgetList extends StatelessWidget {
//   const QuestionWidgetList({
//     required this.isDesk,
//     super.key,
//   });
//   final bool isDesk;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeWatcherBloc, HomeWatcherState>(
//       builder: (context, state) {
//         return ListView.builder(
//           padding: EdgeInsets.zero,
//           shrinkWrap: true,
//           primary: false,
//           addAutomaticKeepAlives: false,
//           addRepaintBoundaries: false,
//           itemCount: state.loadingStatus
//               ? state.questionModelItems.length
//               : KDimensions.shimmerQuestionItems,
//           itemBuilder: (context, index) => Padding(
//             key: ValueKey(KMockText.questionModel.id),
//             padding: index != 0
//                 ? const EdgeInsets.only(
//                     top: KPadding.kPaddingSize24,
//                   )
//                 : EdgeInsets.zero,
//             child: QuestionWidgetItem(
//                 questionModel: state.questionModelItems.elementAt(index),
//                 isLoading: state.loadingStatus,
//                 isDesk: isDesk),
//           ),
//         );
//       },
//     );
//   }
// }

// class QuestionWidgetItem extends StatelessWidget {
//   const QuestionWidgetItem({
//     required this.isDesk,
//     required this.questionModel,
//     required this.isLoading,
//     super.key,
//   });
//   final QuestionModel questionModel;
//   final bool isLoading;
//   final bool isDesk;

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return SkeletonizerWidget(
//         isLoading: true,
//         child: QuestionWidget(
//           key: KWidgetkeys.screen.home.faqSkeletonizer,
//           questionModel: questionModel,
//           isDesk: isDesk,
//         ),
//       );
//     } else {
//       return QuestionWidget(
//         key: KWidgetkeys.screen.home.faq,
//         questionModel: questionModel,
//         isDesk: isDesk,
//       );
//     }
//   }
// }
