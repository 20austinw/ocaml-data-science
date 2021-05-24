(** Logistic regression algorithm*)

val fit : Matrix.t -> Matrix.t -> float -> int -> Matrix.t
(** [fit x y alpha n] takes in col vectors x and y, an alpha value, and
    number of repitions n, and returns the predicted weights as a column
    vector *)

val predict : Matrix.t -> Matrix.t
(** [predict x] takes in a column vector of x and returns of column
    vector of outputs y *)

val fit_and_predict :
  Matrix.t ->
  Matrix.t ->
  Matrix.t ->
  Matrix.t ->
  float ->
  int ->
  float * float * float list
