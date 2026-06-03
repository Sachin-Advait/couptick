import 'dart:convert';
import 'package:consumer_app/models/game_score.dart';
import 'package:consumer_app/models/leaderboard_entry.dart';
import 'package:http/http.dart' as http;

class LeaderboardService {
  // Change this to your actual API URL
  static const String baseUrl = 'http://localhost:8080/api/v1';
  
  // For development, use mock data
  static bool useMockData = true;

  Future<Map<String, dynamic>> submitScore(GameScore score) async {
    if (useMockData) {
      await Future.delayed(const Duration(milliseconds: 500));
      return {
        'ok': true,
        'savedScoreId': 'mock-id',
        'currentScore': score.score,
        'bestScore': score.score,
        'rankAllTime': 15,
      };
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/leaderboard/score'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(score.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to submit score');
      }
    } catch (e) {
      print('Error submitting score: $e');
      rethrow;
    }
  }

  Future<List<LeaderboardEntry>> getTopScores(
    String gameCode,
    String timeframe, {
    int limit = 10,
  }) async {
    if (useMockData) {
      await Future.delayed(const Duration(milliseconds: 500));
      return _getMockLeaderboard();
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/leaderboard/top?gameCode=$gameCode&timeframe=$timeframe&limit=$limit'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => LeaderboardEntry.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load leaderboard');
      }
    } catch (e) {
      print('Error loading leaderboard: $e');
      return _getMockLeaderboard();
    }
  }

  Future<Map<String, dynamic>> getMyRank(
    String gameCode,
    String userId,
    String timeframe,
  ) async {
    if (useMockData) {
      await Future.delayed(const Duration(milliseconds: 500));
      return {
        'userId': userId,
        'displayName': 'You',
        'bestScore': 1250,
        'rank': 32,
        'totalPlayers': 1240,
      };
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/leaderboard/me?gameCode=$gameCode&userId=$userId&timeframe=$timeframe'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load rank');
      }
    } catch (e) {
      print('Error loading rank: $e');
      rethrow;
    }
  }

  List<LeaderboardEntry> _getMockLeaderboard() {
    return [
      LeaderboardEntry(rank: 1, userId: 'u1', displayName: 'Ali', score: 2450),
      LeaderboardEntry(rank: 2, userId: 'u2', displayName: 'Sara', score: 2100),
      LeaderboardEntry(rank: 3, userId: 'u3', displayName: 'John', score: 1980),
      LeaderboardEntry(rank: 4, userId: 'u4', displayName: 'Emma', score: 1850),
      LeaderboardEntry(rank: 5, userId: 'u5', displayName: 'Rahul', score: 1720),
      LeaderboardEntry(rank: 6, userId: 'u6', displayName: 'Priya', score: 1650),
      LeaderboardEntry(rank: 7, userId: 'u7', displayName: 'Mike', score: 1580),
      LeaderboardEntry(rank: 8, userId: 'u8', displayName: 'Lisa', score: 1500),
      LeaderboardEntry(rank: 9, userId: 'u9', displayName: 'Tom', score: 1450),
      LeaderboardEntry(rank: 10, userId: 'u10', displayName: 'Nina', score: 1400),
    ];
  }
}