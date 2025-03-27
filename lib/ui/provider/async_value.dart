class AsyncValue<T> {
  final T? value;
  final bool isLoading;
  final String? error;

  const AsyncValue._({this.value, this.isLoading = false, this.error});

  // Represents the loading state
  factory AsyncValue.loading() => const AsyncValue._(isLoading: true);

  // Represents the success state
  factory AsyncValue.data(T value) => AsyncValue._(value: value);

  // Represents the error state
  factory AsyncValue.error(String error) => AsyncValue._(error: error);
}
