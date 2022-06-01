import 'package:assistant/api/api.dart';
import 'package:assistant/api/client/rest_client.dart';
import 'package:assistant/api/dto/git_dto.dart';
import 'package:assistant/components/my_elevated_button.dart';
import 'package:assistant/screen/sign/signin_page.dart';
import 'package:assistant/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: depend_on_referenced_packages
import 'package:yaml/yaml.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  Future<Map<String, String>> getVersion() async {
    Future<ReleaseDto> getReleaseLatest() async {
      Response response =
          await request(context, Api.restClient.releaseLatest());
      return response.getRelease();
    }

    ReleaseDto releaseDto = await getReleaseLatest();

    String latestVersion = releaseDto.tagName.replaceAll("v", "");
    String currentVersion =
        await rootBundle.loadString('pubspec.yaml').then((value) {
      var yaml = loadYaml(value);
      return yaml['msix_config']['msix_version'];
    });

    Map<String, String> map = {};
    map['latestVersion'] = latestVersion;
    map['currentVersion'] = currentVersion;
    map['downloadUrl'] = releaseDto.downloadUrl!;
    return map;
  }

  Future<List<ReleaseDto>> getReleaseList() async {
    Response response =
        await request(context, Api.restClient.releases(myAccessToken()));
    return response.getReleaseList();
  }

  Widget versionField() {
    bool updatable = false;
    String downlaodUrl = "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("버전 정보"),
        spacerH,
        FutureBuilder<Map<String, String>>(
          future: getVersion(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!['currentVersion']! !=
                  snapshot.data!['latestVersion']!) {
                updatable = true;
                downlaodUrl = snapshot.data!['downloadUrl']!;
              }

              return Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 160,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "현재 버전",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            spacerW,
                            Text(
                              snapshot.data!['currentVersion']!,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          children: [
                            const Text(
                              "최신 버전",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            spacerW,
                            Text(
                              snapshot.data!['latestVersion']!,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  biggerSpacerW,
                  MyElevatedButton(
                    height: 50,
                    width: 160,
                    text: "최신버전 다운로드",
                    onPressed: !updatable
                        ? null
                        : () async {
                            Uri uri = Uri.parse(downlaodUrl);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            } else {
                              throw "Could not launch '${uri.toString()}'";
                            }
                          },
                  ),
                ],
              );
            } else {
              return Row(
                children: const [
                  SizedBox(
                    height: 50,
                    width: 160,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  biggerSpacerW,
                  MyElevatedButton(
                    height: 50,
                    width: 160,
                    text: "최신버전 다운로드",
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget updateNoteField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("업데이트 내역"),
        spacerH,
        MyElevatedButton(
          height: 50,
          width: 160,
          text: "업데이트 내역 확인",
          onPressed: () async {
            Uri uri =
                Uri.parse("https://github.com/azqazq195/assistant/releases");
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            } else {
              throw "Could not launch '${uri.toString()}'";
            }
          },
        ),
      ],
    );
  }

  Widget content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "업데이트",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        biggerSpacerH,
        versionField(),
        biggerSpacerH,
        updateNoteField(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: grey,
          width: 0.2,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: content(),
    );
  }
}
