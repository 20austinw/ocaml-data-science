val fit : Matrix.t -> Matrix.t -> float -> Matrix.t
(** [fit x y] takes in a column vector of x and a column vector of y
and returns the weights as a column vector *)

val predict : Matrix.t -> Matrix.t
(** [predict x] takes in a column vector of x and returns of column
vector of outputs y *)
