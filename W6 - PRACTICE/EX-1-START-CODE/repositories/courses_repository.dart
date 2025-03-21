// lib/Exercise-1/Repositories/courses_repository.dart

import '../models/course.dart';

class CoursesRepository {
  List<Course> _courses = []; // This should be populated with your course data

  List<Course> getCourses() {
    return _courses;
  }

  void addScore(Course course, CourseScore score) {
    // Logic to add score to the course
    course.scores.add(score);
  }
}
