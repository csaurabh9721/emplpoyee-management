import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../core/exceptions/api_exceptions.dart';
import '../../../../core/network/config/network_config.dart';
import '../models/apply_leave_response_model.dart';
import '../models/save_leave_apply_model.dart';

abstract class ApplyLeaveSource {
  Future<ApplyLeaveResponseModel> apply(SaveLeaveApplyModel model, File? file);
}

class ApplyLeaveSourceImpl implements ApplyLeaveSource {
  @override
  Future<ApplyLeaveResponseModel> apply(SaveLeaveApplyModel model, File? file) async {
    try {
      return _FormDataBaseApiForLeaveApply().sendLeaveRequest(model, file);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}

class _FormDataBaseApiForLeaveApply {
  Future<ApplyLeaveResponseModel> sendLeaveRequest(SaveLeaveApplyModel model, File? file) async {
    final Uri url = NetworkConfig.getUrl("/leavecontroller/leaveSave");

    final request = http.MultipartRequest("POST", url);

    final String encodedData = jsonEncode(model.toJson());
    debugPrint("Sending JSON: $encodedData");
    request.fields["jsondata"] = encodedData;
    if (file != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "file",
          file.path,
        ),
      );
    } else {
      request.files.add(
        http.MultipartFile.fromBytes(
          "file",
          [],
          filename: "",
        ),
      );
    }

    try {
      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);
      final Map<String, dynamic> decodedData = jsonDecode(responseBody.body);
      debugPrint("Response Body: $decodedData");
      int statusCode;
      String message;
      if (decodedData.containsKey("statuscode")) {
        statusCode = int.tryParse(decodedData["statuscode"].toString()) ?? 400;
        message = decodedData["message"] ?? "Something went wrong.";
      } else {
        statusCode = int.tryParse(decodedData["status"].toString()) ?? 400;
        message = decodedData["error"] ?? "Something went wrong.";
      }

      final Map<String, dynamic> res = {
        "statuscode": statusCode,
        "message": message,
        "entity": {
          "success": statusCode == 200,
          "message": message,
        }
      };

      return ApplyLeaveResponseModel.fromJson(res);
    } catch (e) {
      debugPrint("Error is : $e");
      throw AppException(e.toString());
    }
  }
}
