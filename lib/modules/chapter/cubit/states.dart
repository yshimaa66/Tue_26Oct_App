abstract class ChapterStates {}

class Initial extends ChapterStates {}

class IsLoading extends ChapterStates {}

class ChapterError extends ChapterStates {
  final String error;
  ChapterError(this.error);
}