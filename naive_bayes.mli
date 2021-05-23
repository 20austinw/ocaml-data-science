(** Naive bayes algorithm*)

(** [predict x y] fits the naive bayes model using features [x] and
    target [y] then returns the predictions for the features [x] *)
val predict : Matrix.t -> Float.t list -> Float.t list

(** [fit_and_predict x_train x_test y_train y_test] fits the naive bayes
    model using features [x_train] and target [y_train] then predicts
    the targets of [x_test], and returns the (accuracy, mean-squared
    error) when comparing this prediction to the actual [y_test] *)
val fit_and_predict :
  Matrix.t -> Matrix.t -> Float.t list -> float list -> float * float
