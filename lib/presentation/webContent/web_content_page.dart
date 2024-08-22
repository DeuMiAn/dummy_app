import 'package:dummy_app/presentation/webContent/web_content_controller.dart';
import 'package:dummy_app/presentation/webContent/web_content_view.dart';
import 'package:get/get.dart';

class WebContentPage extends GetPage {
  static String routeName(urlData) => '/webContent/$urlData';
  WebContentPage()
      : super(
          name: routeName(':urlData'),
          page: () => const WebContentView(),
          binding: BindingsBuilder(() {
            final String urlLink = Get.parameters['urlData'] as String;
            Get.put(WebContentController(urlLink));
          }),
        );
}
