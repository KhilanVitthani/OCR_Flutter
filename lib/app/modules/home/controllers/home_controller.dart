import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ocr/app/Model/ocrModel.dart';

class HomeController extends GetxController {
  Rx<File>? imgFile;
  Rx<File?>? profile;
  final imgPicker = ImagePicker();
  OcrModel? ocrModel;
  RxString manifattura = "".obs;
  RxString Ghamla = "".obs;
  RxString venicieNumber = "".obs;
  RxString talMagna = "".obs;
  RxString fuel = "".obs;
  RxString IdentifikazzjoniTalMagna = "".obs;
  RxString color = "".obs;
  RxString sit = "".obs;
  RxString number = "".obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<File?> openCamera() async {
    String? imgCamera;
    await imgPicker.pickImage(source: ImageSource.camera).then((value) {
      imgCamera = value!.path;
      print(imgCamera);
      imgFile = File(imgCamera!).obs;
      return imgFile!.value;
    }).catchError((error) {
      print(error);
    });

    return (isNullEmptyOrFalse(imgFile!.value)) ? null : imgFile!.value;
  }

  Future<File?> openGallery() async {
    String? imgGallery;
    await imgPicker.pickImage(source: ImageSource.gallery).then((value) {
      imgGallery = value!.path;

      imgFile = File(imgGallery!).obs;
      print(imgFile);
      imgFile!.refresh();
      apiCall();
    });

    return (isNullEmptyOrFalse(imgFile!.value)) ? null : imgFile!.value;
  }

  apiCall() async {
    var headers = {
      'X-RapidAPI-Key': '60f1db0a60msh9d31a6016253da2p15a33cjsn6ac00b976a85',
      'X-RapidAPI-Host': 'ocr-nanonets.p.rapidapi.com'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://ocr-nanonets.p.rapidapi.com/'));
    request.fields.addAll({'name': 'file', 'type': 'application/octet-stream'});
    request.files.add(
        await http.MultipartFile.fromPath('file', '${imgFile!.value.path}'));
    // request.files.add(await http.MultipartFile.fromPath('file',
    //     '/data/user/0/com.example.ocr/cache/883a081e-758d-4787-b901-5cc483fc5c6f/image_2023_05_11T12_45_07_820Z.png'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var response1 = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      // log(response1);

      ocrModel = OcrModel.fromJson(jsonDecode(response1)["results"].first);
      log(ocrModel!.pageData!.first.rawText!);
      // // getManifattura();
      // // log();
      // // ocrModel!.pageData!.first.words!.forEach((element) {
      // //   log(element.text!);
      // // });
      // Words words = ocrModel!.pageData!.first.words!
      //     .where((element) => element.text == "Identifikazzjoni")
      //     .first;
      // // print(words.text);
      // // print(ocrModel!.pageData!.first.words!.indexOf(words));
      // int index = ocrModel!.pageData!.first.words!.indexOf(words) + 2;
      // // print(ocrModel!.pageData!.first.words![index].text);

      getManifattura();
      getGhamla();
      getTalMagna();
      getTalMagna();
      getVenicieNumber();
      getFuel();
      getKulur();
      getSit();
      getNumber();
    } else {
      print(response.reasonPhrase);
    }
  }

  getManifattura() {
    Words words = ocrModel!.pageData!.first.words!
        .where((element) => element.text == "Manifattura")
        .first;
    // print(words.text);
    // print(ocrModel!.pageData!.first.words!.indexOf(words));
    int index = ocrModel!.pageData!.first.words!.indexOf(words) + 1;
    // print(ocrModel!.pageData!.first.words![index].text);
    manifattura.value = ocrModel!.pageData!.first.words![index].text!;
  }

  getGhamla() {
    Ghamla.value = ocrModel!.pageData!.first.rawText!
        .split("D.1 Ghamla ")[1]
        .split(" ")[0];
  }

  getVenicieNumber() {
    venicieNumber.value = ocrModel!.pageData!.first.rawText!
        .split("Identification Number ")[1]
        .split(" ")[0];
  }

  getTalMagna() {
    talMagna.value = ocrModel!.pageData!.first.rawText!
        .split("Capacity tal-Magna ")[1]
        .split(" ")[0];
  }

  getFuel() {
    fuel.value = ocrModel!.pageData!.first.rawText!
        .split(" fuel or power")[0]
        .split(" ")[ocrModel!.pageData!.first.rawText!
            .split(" fuel or power")[0]
            .split(" ")
            .length -
        2];
  }

  getKulur() {
    Words words = ocrModel!.pageData!.first.words!
        .where((element) => element.text == "Kulur")
        .first;
    // print(words.text);
    // print(ocrModel!.pageData!.first.words!.indexOf(words));
    int index = ocrModel!.pageData!.first.words!.indexOf(words) + 1;
    // print(ocrModel!.pageData!.first.words![index].text);
    color.value = ocrModel!.pageData!.first.words![index].text!;
  }

  getSit() {
    Words words = ocrModel!.pageData!.first.words!
        .where((element) => element.text == "bir-roti")
        .first;
    // print(words.text);
    // print(ocrModel!.pageData!.first.words!.indexOf(words));
    int index = ocrModel!.pageData!.first.words!.indexOf(words) + 1;
    sit.value = ocrModel!.pageData!.first.words![index].text!;
  }

  getNumber() {
    number.value = ocrModel!.pageData!.first.rawText!
        .split("C.1.3 ")[1]
        .split(" 2")[0]
        .split(" ")
        .last;
  }
}

bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}
