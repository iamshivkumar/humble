class Interests {
  static Map<String, String> data = {
    'coder': '👨‍💻Coder',
    'music': '🎵 Music Lover',
    'book': '📚 Bookworm',
    'sport': '⚽️ Sports Enthusiast',
    'creative': '🎨 Creative Soul',
    'travel': '🌍 Travel Addict',
    'foodie': '🍳 Foodie',
    'gaming': '🎮 Gaming Guru',
    'fitness': '🏋️ Fitness Junkie',
    'movie': '🎬 Movie Buff',
    'animal': '🐶 Animal Lover',
  };
  
  static String label(String v) => data[v]??'';
}
