import 'package:url_launcher/url_launcher.dart';

class SettingsController {
  void openWhatsAppChat() {
    launchUrl(Uri.parse("whatsapp://send?phone=+970594582822"));
  }

  void openGmailChat() {
    const url = 'mailto:nahed6843@gmail.com';
    launchUrl(Uri.parse(url));
  }

  void openTelegramChat() async {
    String url = 'https://t.me/nahedoukal';
    await launchUrl(Uri.parse(url));
  }

  void goToWebsite(String websiteUrl) async {
    launchUrl(Uri.parse(websiteUrl));
  }

  void openInstagramProfile() async {
    var url = 'https://www.instagram.com/nahedoukal/';
    launchUrl(Uri.parse(url));
  }
}
