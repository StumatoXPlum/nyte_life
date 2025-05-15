class ReviewsModel {
  final String reviewerName;
  final String rating;
  final String review;

  ReviewsModel({
    required this.reviewerName,
    required this.rating,
    required this.review,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      reviewerName: json['reviewer_name'],
      rating: json['rating'],
      review: json['review'],
    );
  }
}
