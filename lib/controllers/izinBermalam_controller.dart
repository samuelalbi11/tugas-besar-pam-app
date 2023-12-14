import 'dart:convert';

import 'package:delapp/models/izinBermalam_model.dart';
import 'package:flutter/material.dart';
import 'package:delapp/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class IzinBermalamController extends GetxController {
  Rx<List<IzinBermalamModel>> izins = Rx<List<IzinBermalamModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    getAllIzinBermalams();
    super.onInit();
  }

  Future getAllIzinBermalams() async {
    try {
      izins.value.clear();
      isLoading.value = true;
      var response = await http.get(Uri.parse('${url}ib'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        final content = json.decode(response.body)['izinBermalam'];
        for (var item in content) {
          izins.value.add(IzinBermalamModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createIzinBermalams({
    required String content,
    required DateTime rencanaBerangkat,
    required DateTime rencanaKembali,
  }) async {
    try {
      var data = {
        'content': content,
        'rencana_berangkat': rencanaBerangkat.toIso8601String(),
        'rencana_kembali': rencanaKembali.toIso8601String(),
      };

      var response = await http.post(
        Uri.parse('${url}ib/store'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        print(json.decode(response.body));
      } else {
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteIzinBermalam(int id) async {
    try {
      var response = await http.delete(
        Uri.parse('${url}ib/delete/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        izins.value.removeWhere((izin) => izin.id == id);
        update(); // Update UI setelah izin dihapus
        print('Izin berhasil dihapus');
      } else {
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
