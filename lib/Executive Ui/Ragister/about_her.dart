import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimonial_app/Core/Constant/CommonUtils.dart';
import 'package:matrimonial_app/Core/Constant/url_constant.dart';
import 'package:matrimonial_app/Core/Constant/value_constants.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Add_Candidate_Model.dart'
    as addCandidateModel;
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/Update_Candidate_Model.dart';
import 'package:matrimonial_app/ModelClass/Executive_ModelClass/candidate_model.dart';
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/Get_MaritalStatus_Model.dart'
    as maritalStatus;
import 'package:matrimonial_app/ModelClass/UserPanel_ModelClass/DropDown_Datas/state_model.dart'
    as state;
import 'package:matrimonial_app/Utils/app_constants.dart';
import 'package:matrimonial_app/Utils/color_constants.dart';
import 'package:matrimonial_app/Utils/image_path_constants.dart';
import 'package:matrimonial_app/Utils/text_styles.dart';
import 'package:matrimonial_app/src/DatePicker/date_picker.dart';
import 'package:matrimonial_app/widget/Executive%20Side/eCommonButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../src/DatePicker/i18n/date_picker_i18n.dart';
import '../../widget/dropdown_const.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AboutHer extends StatefulWidget {
  AboutHer({Key? key, this.onBack, this.isUpdate, this.candidateId})
      : super(key: key);
  final String? isUpdate;
  final Function? onBack;
  var candidateId;
  @override
  State<AboutHer> createState() => _AboutHerState();
}

class _AboutHerState extends State<AboutHer> {
  var regexToRemoveEmoji =
      '   /\uD83C\uDFF4\uDB40\uDC67\uDB40\uDC62(?:\uDB40\uDC77\uDB40\uDC6C\uDB40\uDC73|\uDB40\uDC73\uDB40\uDC63\uDB40\uDC74|\uDB40\uDC65\uDB40\uDC6E\uDB40\uDC67)\uDB40\uDC7F|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC68(?:\uD83C\uDFFF\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFE])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFC-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D)?\uD83D\uDC68|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D[\uDC66\uDC67])|[\u2695\u2696\u2708]\uFE0F|\uD83D[\uDC66\uDC67]|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708])\uFE0F|\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69(?:\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D(?:\uD83D[\uDC68\uDC69])|\uD83D[\uDC68\uDC69])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFF\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69\uD83C\uDFFF\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFE])|\uD83D\uDC69\uD83C\uDFFE\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83D\uDC69\uD83C\uDFFD\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83D\uDC69\uD83C\uDFFC\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83D\uDC69\uD83C\uDFFB\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFC-\uDFFF])|\uD83D\uDC69\u200D\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D\uDC41\uFE0F\u200D\uD83D\uDDE8|\uD83D\uDC69(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83C\uDFF3\uFE0F\u200D\u26A7|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83D\uDC3B\u200D\u2744|(?:(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF])\u200D[\u2640\u2642]|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])\u200D[\u2640\u2642]|\uD83C\uDFF4\u200D\u2620|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])\u200D[\u2640\u2642]|[\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u2328\u23CF\u23ED-\u23EF\u23F1\u23F2\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB\u25FC\u2600-\u2604\u260E\u2611\u2618\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u2692\u2694-\u2697\u2699\u269B\u269C\u26A0\u26A7\u26B0\u26B1\u26C8\u26CF\u26D1\u26D3\u26E9\u26F0\u26F1\u26F4\u26F7\u26F8\u2702\u2708\u2709\u270F\u2712\u2714\u2716\u271D\u2721\u2733\u2734\u2744\u2747\u2763\u2764\u27A1\u2934\u2935\u2B05-\u2B07\u3030\u303D\u3297\u3299]|\uD83C[\uDD70\uDD71\uDD7E\uDD7F\uDE02\uDE37\uDF21\uDF24-\uDF2C\uDF36\uDF7D\uDF96\uDF97\uDF99-\uDF9B\uDF9E\uDF9F\uDFCD\uDFCE\uDFD4-\uDFDF\uDFF5\uDFF7]|\uD83D[\uDC3F\uDCFD\uDD49\uDD4A\uDD6F\uDD70\uDD73\uDD76-\uDD79\uDD87\uDD8A-\uDD8D\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA\uDECB\uDECD-\uDECF\uDEE0-\uDEE5\uDEE9\uDEF0\uDEF3])\uFE0F|\uD83D\uDC69\u200D\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|\uD83C\uDFF3\uFE0F\u200D\uD83C\uDF08|\uD83D\uDC69\u200D\uD83D\uDC67|\uD83D\uDC69\u200D\uD83D\uDC66|\uD83D\uDC15\u200D\uD83E\uDDBA|\uD83D\uDC69(?:\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83C\uDDFD\uD83C\uDDF0|\uD83C\uDDF6\uD83C\uDDE6|\uD83C\uDDF4\uD83C\uDDF2|\uD83D\uDC08\u200D\u2B1B|\uD83D\uDC41\uFE0F|\uD83C\uDFF3\uFE0F|\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])?|\uD83C\uDDFF(?:\uD83C[\uDDE6\uDDF2\uDDFC])|\uD83C\uDDFE(?:\uD83C[\uDDEA\uDDF9])|\uD83C\uDDFC(?:\uD83C[\uDDEB\uDDF8])|\uD83C\uDDFB(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDEE\uDDF3\uDDFA])|\uD83C\uDDFA(?:\uD83C[\uDDE6\uDDEC\uDDF2\uDDF3\uDDF8\uDDFE\uDDFF])|\uD83C\uDDF9(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDED\uDDEF-\uDDF4\uDDF7\uDDF9\uDDFB\uDDFC\uDDFF])|\uD83C\uDDF8(?:\uD83C[\uDDE6-\uDDEA\uDDEC-\uDDF4\uDDF7-\uDDF9\uDDFB\uDDFD-\uDDFF])|\uD83C\uDDF7(?:\uD83C[\uDDEA\uDDF4\uDDF8\uDDFA\uDDFC])|\uD83C\uDDF5(?:\uD83C[\uDDE6\uDDEA-\uDDED\uDDF0-\uDDF3\uDDF7-\uDDF9\uDDFC\uDDFE])|\uD83C\uDDF3(?:\uD83C[\uDDE6\uDDE8\uDDEA-\uDDEC\uDDEE\uDDF1\uDDF4\uDDF5\uDDF7\uDDFA\uDDFF])|\uD83C\uDDF2(?:\uD83C[\uDDE6\uDDE8-\uDDED\uDDF0-\uDDFF])|\uD83C\uDDF1(?:\uD83C[\uDDE6-\uDDE8\uDDEE\uDDF0\uDDF7-\uDDFB\uDDFE])|\uD83C\uDDF0(?:\uD83C[\uDDEA\uDDEC-\uDDEE\uDDF2\uDDF3\uDDF5\uDDF7\uDDFC\uDDFE\uDDFF])|\uD83C\uDDEF(?:\uD83C[\uDDEA\uDDF2\uDDF4\uDDF5])|\uD83C\uDDEE(?:\uD83C[\uDDE8-\uDDEA\uDDF1-\uDDF4\uDDF6-\uDDF9])|\uD83C\uDDED(?:\uD83C[\uDDF0\uDDF2\uDDF3\uDDF7\uDDF9\uDDFA])|\uD83C\uDDEC(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEE\uDDF1-\uDDF3\uDDF5-\uDDFA\uDDFC\uDDFE])|\uD83C\uDDEB(?:\uD83C[\uDDEE-\uDDF0\uDDF2\uDDF4\uDDF7])|\uD83C\uDDEA(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDED\uDDF7-\uDDFA])|\uD83C\uDDE9(?:\uD83C[\uDDEA\uDDEC\uDDEF\uDDF0\uDDF2\uDDF4\uDDFF])|\uD83C\uDDE8(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDEE\uDDF0-\uDDF5\uDDF7\uDDFA-\uDDFF])|\uD83C\uDDE7(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEF\uDDF1-\uDDF4\uDDF6-\uDDF9\uDDFB\uDDFC\uDDFE\uDDFF])|\uD83C\uDDE6(?:\uD83C[\uDDE8-\uDDEC\uDDEE\uDDF1\uDDF2\uDDF4\uDDF6-\uDDFA\uDDFC\uDDFD\uDDFF])|[#\*0-9]\uFE0F\u20E3|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|\uD83C\uDFF4|(?:[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5])(?:\uD83C[\uDFFB-\uDFFF])|(?:[\u261D\u270C\u270D]|\uD83D[\uDD74\uDD90])(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC08\uDC15\uDC3B\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5]|\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD]|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF]|[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF84\uDF86-\uDF93\uDFA0-\uDFC1\uDFC5\uDFC6\uDFC8\uDFC9\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC07\uDC09-\uDC14\uDC16-\uDC3A\uDC3C-\uDC3E\uDC40\uDC44\uDC45\uDC51-\uDC65\uDC6A\uDC79-\uDC7B\uDC7D-\uDC80\uDC84\uDC88-\uDCA9\uDCAB-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDDA4\uDDFB-\uDE44\uDE48-\uDE4A\uDE80-\uDEA2\uDEA4-\uDEB3\uDEB7-\uDEBF\uDEC1-\uDEC5\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0D\uDD0E\uDD10-\uDD17\uDD1D\uDD20-\uDD25\uDD27-\uDD2F\uDD3A\uDD3F-\uDD45\uDD47-\uDD76\uDD78\uDD7A-\uDDB4\uDDB7\uDDBA\uDDBC-\uDDCB\uDDD0\uDDE0-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6]|(?:[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u270A\u270B\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF93\uDFA0-\uDFCA\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF4\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC3E\uDC40\uDC42-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDD7A\uDD95\uDD96\uDDA4\uDDFB-\uDE4F\uDE80-\uDEC5\uDECC\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])|(?:[#\*0-9\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u231A\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614\u2615\u2618\u261D\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u2648-\u2653\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u267F\u2692-\u2697\u2699\u269B\u269C\u26A0\u26A1\u26A7\u26AA\u26AB\u26B0\u26B1\u26BD\u26BE\u26C4\u26C5\u26C8\u26CE\u26CF\u26D1\u26D3\u26D4\u26E9\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934\u2935\u2B05-\u2B07\u2B1B\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299]|\uD83C[\uDC04\uDCCF\uDD70\uDD71\uDD7E\uDD7F\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE02\uDE1A\uDE2F\uDE32-\uDE3A\uDE50\uDE51\uDF00-\uDF21\uDF24-\uDF93\uDF96\uDF97\uDF99-\uDF9B\uDF9E-\uDFF0\uDFF3-\uDFF5\uDFF7-\uDFFF]|\uD83D[\uDC00-\uDCFD\uDCFF-\uDD3D\uDD49-\uDD4E\uDD50-\uDD67\uDD6F\uDD70\uDD73-\uDD7A\uDD87\uDD8A-\uDD8D\uDD90\uDD95\uDD96\uDDA4\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA-\uDE4F\uDE80-\uDEC5\uDECB-\uDED2\uDED5-\uDED7\uDEE0-\uDEE5\uDEE9\uDEEB\uDEEC\uDEF0\uDEF3-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])\uFE0F|(?:[\u261D\u26F9\u270A-\u270D]|\uD83C[\uDF85\uDFC2-\uDFC4\uDFC7\uDFCA-\uDFCC]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66-\uDC78\uDC7C\uDC81-\uDC83\uDC85-\uDC87\uDC8F\uDC91\uDCAA\uDD74\uDD75\uDD7A\uDD90\uDD95\uDD96\uDE45-\uDE47\uDE4B-\uDE4F\uDEA3\uDEB4-\uDEB6\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1F\uDD26\uDD30-\uDD39\uDD3C-\uDD3E\uDD77\uDDB5\uDDB6\uDDB8\uDDB9\uDDBB\uDDCD-\uDDCF\uDDD1-\uDDDD])/';

  Dio dio = Dio();
  TextEditingController _nameController = TextEditingController();

  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  TextEditingController _dobCodeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  state.StateModel? _stateModel;
  maritalStatus.GetmaritalStatusModel? _getmaritalStatusModel;
  maritalStatus.Data? _maritalData;
  state.Data? _data;

  List<String> genderdropdown = ["Male", "Female"];
  String? dropdowngender;
  String? fromValue;
  List<String> married = [AppConstants.nevermarried, AppConstants.married];
  String? marrieddropdown;

  PickedFile? image;
  PickedFile? imageFile;
  PickedFile? imageFile1;
  PickedFile? imageFile2;
  String date = "";
  var selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
          left: width * 0.03, right: width * 0.03, top: height * 0.01),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.addProfileDetails,
              textAlign: TextAlign.center,
              style: fontStyle.copyWith(
                height: 1.3,
                color: AppColors.titleColor,
                fontSize: 15,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: width * 0.02,
                top: height * 0.01,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Please Enter Your First Name";
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp("[A-Za-z + |\s ]"),
                        ),
                      ],
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                          color: Color(
                            0xff333F52,
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        hintText: AppConstants.firstnameHint,
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 118, 125, 138),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        label: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Enter Your First Name',
                                style: TextStyle(
                                  color: Color(0xff838994),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Please Enter Your Last Name";
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp("[A-Za-z + |\s ]"),
                        ),
                      ],
                      controller: _lastnameController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                          color: Color(
                            0xff333F52,
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        hintText: AppConstants.lastnamehint,
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 118, 125, 138),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        label: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Enter Your Last Name',
                                style: TextStyle(
                                  color: Color(0xff838994),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _descController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z , .+ |\s]"))
                      ],
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                          color: Color(
                            0xff333F52,
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        hintText: "Enter Description",
                        hintStyle: TextStyle(
                            color: Color(
                              0xff333F52,
                            ),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        label: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Write about Him/Her ',
                                style: TextStyle(
                                  color: Color(0xff838994),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Please Enter Description";
                        }
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.02),
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            AppConstants.gender,
                            style: TextStyle(
                              color: Color(0xff838994),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: height * 0.01),
                            height: 30,
                            width: width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                buttonPadding: EdgeInsets.zero,
                                itemHeight: 20,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                icon: Container(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset(
                                    ImagePath.settingArrow,
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                hint: Text('Select Gender'),
                                items: getDropdown()
                                    .addDividersAfterItems(genderdropdown),
                                customItemsIndexes: getDropdown()
                                    .getDividersIndexes(genderdropdown),
                                value: dropdowngender,
                                onChanged: (value) {
                                  setState(() {
                                    dropdowngender = value as String;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: height * 0.002,
                      color: AppColors.dividerColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(
                        child: TextFormField(
                          readOnly:
                              (widget.isUpdate == "isUpdate") ? true : false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a Phone Number!';
                            }
                            if (value.length < 10 || value.length > 10) {
                              return 'Phone Number Should be 10 Character';
                            }
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          controller: _mobileController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: Color(
                                0xff333F52,
                              ),
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFieldColor, width: 2),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFieldColor, width: 2),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFieldColor, width: 2),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFieldColor, width: 2),
                            ),
                            hintText: ' Enter Mobile Number',
                            hintStyle: TextStyle(
                                color: Color(
                                  0xff333F52,
                                ),
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                            label: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Mobile Number ',
                                    style: TextStyle(
                                      color: Color(0xff838994),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Color(0xff838994),
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z0-9@\.]")),
                      ],
                      validator: (value) {
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value!)) {
                          return "Please enter a valid email address";
                        }
                        if (value.isEmpty) {
                          return "Please Enter Email Address";
                        }

                        return null;
                      },
                      readOnly: (widget.isUpdate == "isUpdate") ? true : false,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          color: Color(
                            0xff333F52,
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        hintText: "Enter Email",
                        hintStyle: TextStyle(
                            color: Color(
                              0xff333F52,
                            ),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        label: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Enter Email Address ',
                                style: TextStyle(
                                  color: Color(0xff838994),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Color(0xff838994),
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z , .+ |\s]"))
                      ],
                      controller: _addressController,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                          color: Color(
                            0xff333F52,
                          ),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldColor, width: 2),
                        ),
                        hintText: "Enter Address",
                        hintStyle: TextStyle(
                            color: Color(
                              0xff333F52,
                            ),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        label: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Address ',
                                style: TextStyle(
                                  color: Color(0xff838994),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Color(0xff838994),
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Your Address";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "State",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 45,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      border: Border.all(
                                        color: Color(0xffD1D1D1),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<state.Data>(
                                        dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        icon: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 15,
                                            width: 15,
                                            child: Center(
                                              child: Image.asset(
                                                ImagePath.forward,
                                                height: 24,
                                                width: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                        hint: Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            'Select state',
                                            style: fontStyle.copyWith(
                                                fontSize: 15,
                                                color: Color(0xff777777),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        dropdownMaxHeight: 200,
                                        itemHeight: 20,
                                        items: addDividersAfterItemsState(
                                            (_stateModel != null)
                                                ? _stateModel!.data!
                                                : []),
                                        customItemsIndexes: getDividersIndexes(
                                            (_stateModel != null)
                                                ? _stateModel!.data!
                                                : []),
                                        value: _data,
                                        onChanged: (newValue) {
                                          print(newValue);
                                          setState(() {
                                            _data = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: TextFormField(
                                  controller: _pinCodeController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(6),
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]"))
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 0),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.textFieldColor,
                                          width: 2),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.textFieldColor,
                                          width: 2),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.textFieldColor,
                                          width: 2),
                                    ),
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.textFieldColor,
                                          width: 2),
                                    ),
                                    hintText: "Enter Pincode",
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 15),
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Pincode ',
                                            style: TextStyle(
                                              color: Color(0xff838994),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Color(0xff838994),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return "Please Enter Pincode";
                                    }
                                  },
                                ),
                              )
                            ],
                          )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "marital Status",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 70,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        border: Border.all(
                                          color: Color(0xffD1D1D1),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child:
                                            DropdownButton2<maritalStatus.Data>(
                                          buttonHeight: 43,
                                          focusColor: Colors.white,
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                          ),
                                          icon: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Container(
                                              height: 15,
                                              width: 15,
                                              child: Center(
                                                child: Image.asset(
                                                  ImagePath.forward,
                                                  height: 24,
                                                  width: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                          hint: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Select Status',
                                              style: fontStyle.copyWith(
                                                  color: Color(0xff777777),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          isExpanded: true,
                                          dropdownMaxHeight: 200,
                                          itemHeight: 20,
                                          items: addDividersAfterItemsMeritial(
                                              (_getmaritalStatusModel != null)
                                                  ? _getmaritalStatusModel!
                                                      .data!
                                                  : []),
                                          customItemsIndexes:
                                              getDividersIndexes(
                                                  (_getmaritalStatusModel !=
                                                          null)
                                                      ? _getmaritalStatusModel!
                                                          .data!
                                                      : []),
                                          value: _maritalData,
                                          onChanged: (newValue) {
                                            print(newValue);
                                            setState(() {
                                              _maritalData = newValue;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: TextFormField(
                              onTap: () async {
                                DateTime? date = DateTime.now();
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                date = (await DatePicker.showSimpleDatePicker(
                                    context,
                                    initialDate: DateTime(2000),
                                    firstDate: DateTime(1972),
                                    lastDate: DateTime(
                                        date.year - 18, date.month, date.day),
                                    dateFormat: 'dd-MMM-yyyy',
                                    locale: DateTimePickerLocale.en_us,
                                    looping: false,
                                    itemTextStyle:
                                        TextStyle(color: Colors.black),
                                    textColor: Color(0xffFA2457)));

                                _dobCodeController.text =
                                    DateFormat('dd-MMM-yyyy').format(date!);

                                log(_dobCodeController.text);
                              },
                              controller: _dobCodeController,
                              style: TextStyle(
                                  color: Color(0xff333F52),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textFieldColor,
                                      width: 2),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textFieldColor,
                                      width: 2),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textFieldColor,
                                      width: 2),
                                ),
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textFieldColor,
                                      width: 2),
                                ),
                                hintText: AppConstants.dobHint,
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 15),
                                label: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Date of Birth ',
                                        style: TextStyle(
                                          color: Color(0xff838994),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: Color(0xff838994),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                              validator: (text) {
                                if (text!.isEmpty) {
                                  return "Select Your Birth Date";
                                }
                              },
                            ),
                          )),
                        )
                      ],
                    ),
                    SizedBox(height: 25),
                    ECommonButton(
                      btnName: (widget.isUpdate == "isUpdate")
                          ? "Update"
                          : AppConstants.next,
                      btnOnTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.isUpdate == "isUpdate") {
                            updateCandidateAPI();
                          } else {
                            addCandidateAPI();
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (widget.isUpdate == "isUpdate") {
        getCandidateAPI();
        getState();
        getMaritalStatus();
      } else {
        getState();
        getMaritalStatus();
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (widget.isUpdate == "isUpdate") {
        getCandidateAPI();
        getState();
        getMaritalStatus();
      } else {
        getState();
        getMaritalStatus();
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Alert"),
              content: Text("Check Your Internet Connection"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok")),
              ],
            );
          });
    }
  }

  getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString(USER_TOKEN);
    print(authToken);

    var response = await http.get(
      Uri.parse(GET_STATE_URL),
    );

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          _stateModel = state.StateModel.fromJson(jsonDecode(response.body));
        });
      }
    } else if (response.statusCode == 500) {
      CommonUtils.hideProgressLoading();
      Fluttertoast.showToast(
          msg: "Internal Server Error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffE16284),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getMaritalStatus() async {
    var response = await http.get(Uri.parse(GET_MARITAL_STATUS_URL));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success'] == true) {
        setState(() {
          _getmaritalStatusModel =
              maritalStatus.GetmaritalStatusModel.fromJson(data);
        });
      } else if (response.statusCode == 500) {
        CommonUtils.hideProgressLoading();
        Fluttertoast.showToast(
            msg: "Internal Server Error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  addCandidateAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    final queryParameters = {
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    log("queryString :: $queryString");
    var params = {
      "firstname": _nameController.text,
      "lastname": _lastnameController.text,
      "email": _emailController.text,
      "mobile": _mobileController.text,
      "dob": _dobCodeController.text,
      "gender": dropdowngender,
      "address": _addressController.text,
      "pincode": _pinCodeController.text,
      "state": (_data != null) ? _data!.id : "",
      "marital_status": (_maritalData != null) ? _maritalData!.id : "",
      "about_me_long": _descController.text
    };
    log("Add Candidate Executive $params");
    try {
      var response =
          await dio.post(ADD_CANDIDATE_URL + "?" + queryString, data: params);
      log("About her response ${response.statusCode}");
      if (response.statusCode == 200) {
        addCandidateModel.AddCandidateModel _addCandidateModel =
            addCandidateModel.AddCandidateModel.fromJson(response.data);
        pref.setString(EXE_USER_ID, _addCandidateModel.data!.userId.toString());
        widget.onBack!(1);
        print(response.data);
      } else if (response.statusCode == 500) {
        CommonUtils.hideProgressLoading();
        Fluttertoast.showToast(
            msg: "Internal Server Error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xffE16284),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print("object ::: $e");
    }
  }

  getCandidateAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    log("exe Token ::: $exeToken");
    print("candidate id ::: ${widget.candidateId}");
    final queryParameters = {
      "user_id": widget.candidateId.toString(),
      "token": exeToken.toString(),
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    var response = await dio.get(GET_CANDIDATES_URL + "?" + queryString);
    if (response.statusCode == 200) {
      GetCandidateModel _getCandidateModel =
          GetCandidateModel.fromJson(response.data);
      setState(() {
        _nameController.text = (_getCandidateModel.data!.fullname != null)
            ? _getCandidateModel.data!.fullname.toString()
            : "";
        _descController.text = (_getCandidateModel.data!.aboutMeLong != null)
            ? _getCandidateModel.data!.aboutMeLong.toString()
            : "";
        dropdowngender = (_getCandidateModel.data!.gender != null)
            ? _getCandidateModel.data!.gender.toString()
            : "";
        _mobileController.text = (_getCandidateModel.data!.mobile != null)
            ? _getCandidateModel.data!.mobile.toString()
            : "";
        _emailController.text = (_getCandidateModel.data!.email != null)
            ? _getCandidateModel.data!.email.toString()
            : "";
        _addressController.text = (_getCandidateModel.data!.address != null)
            ? _getCandidateModel.data!.address.toString()
            : "";
        _pinCodeController.text = (_getCandidateModel.data!.pincode != null)
            ? _getCandidateModel.data!.pincode.toString()
            : "";
        _dobCodeController.text = (_getCandidateModel.data!.dob != null)
            ? _getCandidateModel.data!.dob.toString()
            : "";
        for (var i = 0; i < _stateModel!.data!.length; i++) {
          if (_stateModel!.data![i].id == _getCandidateModel.data!.state) {
            _data = _stateModel!.data![i];
          }
        }
        if (_getmaritalStatusModel != null) {
          for (var i = 0; i < _getmaritalStatusModel!.data!.length; i++) {
            if (_getmaritalStatusModel!.data![i].id ==
                _getCandidateModel.data!.state) {
              _maritalData = _getmaritalStatusModel!.data![i];
            }
          }
        }
      });
    } else if (response.statusCode == 500) {
      CommonUtils.hideProgressLoading();
      Fluttertoast.showToast(
          msg: "Internal Server Error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffE16284),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  updateCandidateAPI() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var exeToken = pref.getString(EXE_TOKEN);
    final queryParameters = {
      "token": exeToken.toString(),
      "user_id": widget.candidateId.toString(),
    };
    String queryString = Uri(
      queryParameters: queryParameters,
    ).query;
    var params = {
      "firstname": _nameController.text,
      "lastname": _lastnameController.text,
      "email": _emailController.text,
      "mobile": _mobileController.text,
      "dob": _dobCodeController.text,
      "gender": dropdowngender,
      "address": _addressController.text,
      "pincode": _pinCodeController.text,
      "state": (_data != null) ? _data!.id : "",
      "marital_status": (_maritalData != null) ? _maritalData!.id : "",
      "about_me_long": _descController.text,
      "user_id": widget.candidateId
    };
    print("$params");
    var response = await dio.post(
      UPDATE_EXE_CANDIDATE_URL + "?" + queryString,
    );
    if (response.statusCode == 200) {
      UpdateExeCandidateModel _updateExeCandidateModel =
          UpdateExeCandidateModel.fromJson(response.data);
      print(response.data);
      widget.onBack!(1);
    } else if (response.statusCode == 500) {
      CommonUtils.hideProgressLoading();
      Fluttertoast.showToast(
          msg: "Internal Server Error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xffE16284),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    final f = File(pickedFile!.path);
    int sizeInBytes = f.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb < 5) {
      setState(() {
        image = pickedFile;
      });
      Navigator.pop(context);
      return image;
    } else {
      Fluttertoast.showToast(
        msg: "max size 5 mb",
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
      return null;
    }
  }

  Future _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    final f = File(pickedFile!.path);
    int sizeInBytes = f.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb < 5) {
      setState(() {
        image = pickedFile;
      });
      Navigator.pop(context);
      return image;
    } else {
      Fluttertoast.showToast(
        msg: "max size 5 mb",
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.pop(context);
      return null;
    }
  }

  List<DropdownMenuItem<state.Data>> addDividersAfterItemsState(
      List<state.Data> items) {
    List<DropdownMenuItem<state.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<state.Data>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.name.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<state.Data>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<DropdownMenuItem<maritalStatus.Data>> addDividersAfterItemsMeritial(
      List<maritalStatus.Data> items) {
    List<DropdownMenuItem<maritalStatus.Data>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<maritalStatus.Data>(
            value: item,
            child: Padding(
              padding: EdgeInsets.only(top: 2.0, left: 10),
              child: Text(
                item.name.toString(),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<maritalStatus.Data>(
              enabled: false,
              child: Divider(
                height: 0,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  getDividersIndexes(items) {
    List<int> _getDividersIndexes() {
      List<int> _dividersIndexes = [];
      for (var i = 0; i < (items.length * 2) - 1; i++) {
        if (i.isOdd) {
          _dividersIndexes.add(i);
        }
      }
      return _dividersIndexes;
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}
