val fit : Matrix.t -> Matrix.t -> float -> int -> Matrix.t
(** [fit x y alpha n] takes in a col vector x, a feature matrix y, an
    alpha value, and number of repitions n, and returns the predicted
    weights as a column vector *)

val predict : Matrix.t -> Matrix.t
(** [predict x] takes in a column vector of x and returns of column
    vector of outputs y *)
