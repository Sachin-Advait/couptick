class LeaderboardEntry {
  final int rank;
  final String userId;
  final String displayName;
  final int score;

  LeaderboardEntry({
    required this.rank,
    required this.userId,
    required this.displayName,
    required this.score,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      rank: json['rank'] ?? 0,
      userId: json['userId'] ?? '',
      displayName: json['displayName'] ?? 'Player',
      score: json['score'] ?? 0,
    );
  }
}