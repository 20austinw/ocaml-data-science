val fit : Matrix.t -> Matrix.t -> int -> Matrix.t
(** [fit v1 v2 n] takes in the x-values v1 and y-values v2 as column vectors
and the degree of polynomial n and returns the weights corresponding to each
term as a column vector*)

val predict : Matrix.t -> Matrix.t
(** [predict v1] takes in the x-values v1 and produces the corresponding 
y-values as a column vector *)
