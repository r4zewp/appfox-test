import 'package:appfox_test/features/feature/common/constants.dart';
import 'package:appfox_test/features/feature/presentation/cubit/results_cubit.dart';
import 'package:appfox_test/features/feature/presentation/widgets/result_tile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return BlocBuilder<ResultCubit, ResultState>(builder: (context, state) {
      if (state is ResultLoaded) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: const Text(AppConstants.appBarPreviousResults),
          ),
          body: Center(
            child: SizedBox(
              width: screenSize.width * 0.91,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 16),
                      itemCount: state.results.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 8),
                        child: ResultTile(result: state.results[index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return const Scaffold(
        body: CupertinoActivityIndicator(color: Colors.white),
      );
    });
  }
}
