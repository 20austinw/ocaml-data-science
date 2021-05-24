type node = {
  feature_i : int option;
  threshold : float option;
  value : float option;
  true_branch : node option;
  false_branch : node option;
}

val predict : Matrix.t -> Float.t list -> float list

val fit_and_predict :
  Matrix.t ->
  Matrix.t ->
  Float.t list ->
  float list ->
  float * float * float list
