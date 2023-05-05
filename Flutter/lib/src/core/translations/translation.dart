import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'dominance': 'Dominance',
          'find_out_more': 'Find out more',
          'type': 'Type',
          'species': 'Species',
        },
        'fr_FR': {
          'dominance': 'Dominalité',
          'find_out_more': 'En savoir plus',
          'type': 'Genre',
          'species': 'Espèce',
        }
      };
}
