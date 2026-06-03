class GameScore {
  final String gameCode;
  final String userId;
  final int score;
  final DateTime timestamp;

  GameScore({
    required this.gameCode,
    required this.userId,
    required this.score,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'gameCode': gameCode,
        'userId': userId,
        'displayName': 'Player',
        'score': score,
        'clientTimestamp': timestamp.toIso8601String(),
      };
}