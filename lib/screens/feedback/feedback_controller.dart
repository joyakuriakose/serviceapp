import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FeedbackController extends GetxController {

  final TextEditingController feedbackController = TextEditingController();

  bool isFeedbackEmpty = true;

}