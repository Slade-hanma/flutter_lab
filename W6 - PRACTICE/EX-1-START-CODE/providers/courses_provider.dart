// lib/Exercise-1/Providers/courses_provider.dart

import '../Repositories/courses_repository.dart';
import '../models/course.dart';

class CoursesProvider {
  final CoursesRepository _coursesRepository = CoursesRepository();

  List<Course> getCourses() {
    return _coursesRepository.getCourses();
  }

  Course getCourseFor(String courseId) {
    // Assuming courseId is unique and corresponds to course.name
    return _coursesRepository.getCourses().firstWhere(
      (course) => course.name == courseId,
      orElse: () => throw Exception('Course not found'), // Handle not found case
    );
  }

  void addScore(String courseId, CourseScore score) {
    // Directly get the course without null check
    Course course = getCourseFor(courseId);
    _coursesRepository.addScore(course, score);
  }
}
