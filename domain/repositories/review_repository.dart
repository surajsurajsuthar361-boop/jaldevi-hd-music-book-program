import 'package:jaldevi_hd_music_book_program/domain/entities/review.dart';




abstract class ReviewRepository {
  Future<List<Review>> getReviewsForPackage(String packageId);
  Future<void> addReview(Review review);
}
