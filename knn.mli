(** K-nearest neighbors algorithm*)

val set_k : int -> int
(** [set_k k] sets the value k to be used in the knn algorithm, and
    returns k *)

val predict : float list list -> float list list -> 'a list -> 'a list
(** [predict x_test x_train y_train] computes the predicted
    corresponding labels of x_test using the x_train and y_train as
    training data for the points and labels respectively*)

val fit_and_predict :
  float list list ->
  float list ->
  float list list ->
  float list ->
  float * float * float list
