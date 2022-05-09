enum LanguageType { ENGLISH, SPANISH, KOREAN }

const String ENGLISH = "en";
const String SPANISH = "es";
const String KOREAN = "ko";

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.SPANISH:
        return SPANISH;
      case LanguageType.KOREAN:
        return KOREAN;
    }
  }
}
