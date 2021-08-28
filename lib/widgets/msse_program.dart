import 'package:flutter/material.dart';
import 'package:iit_360/providers/academic_provider.dart';
import 'package:provider/provider.dart';

class MsseProgram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FutureBuilder(
          future: Provider.of<AcademicProvider>(context, listen: false)
              .fetchAndSetGradProgram(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (dataSnapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<AcademicProvider>(
                builder: (ctx, academicProvider, _) {
                  return ListView.builder(
                    itemCount: academicProvider.gradProgramMsse!.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  academicProvider
                                      .gradProgramMsse![index].academicProgram,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Visibility(
                                visible: academicProvider
                                    .gradProgramMsse![index]
                                    .academicInformation
                                    .isNotEmpty,
                                child: Column(
                                  children: [
                                    Text(
                                      'Information',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(academicProvider
                                        .gradProgramMsse![index]
                                        .academicInformation),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: academicProvider
                                    .gradProgramMsse![index]
                                    .academicAdmission
                                    .isNotEmpty,
                                child: Column(
                                  children: [
                                    Text(
                                      'Admission',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(academicProvider
                                        .gradProgramMsse![index]
                                        .academicAdmission),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
