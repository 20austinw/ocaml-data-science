type t

exception InvalidDimensions

(* [matrix t] retrieves the matrix within t *)
val matrix : t -> float list list

(* [empty m n] produces an m by n matrix of 0's *)
val empty : int -> int -> t

(* [eye n] produces an n by n identity matrix *)
val eye : int -> t

(* [transpose t] transposes the matrix in t *)
val transpose : t -> t

(* [mult t1 t2] produces a new matrix of the product of t1 and t2 *)
val mult : t -> t -> t

(* [echelon t] returns the reduced form of matrix m*)
val rref : t -> t

(* [construct m] takes in a float list list and returns of matrix of
   type t and throws InvalidDimensions if rows are not of the same
   length *)
val construct : float list list -> t

(* [decomp m] takes in type t and produces a pair of type t containing
   the LU decomposition of matrix in t *)
val lu_decomp : t -> t * t

(* [concat m1 m2] takes in two matrices of type t and returns a
   concatenated matrix of type t *)
val concat : t -> t -> t

(* [invert m] takes in a matrix of type t and returns the inverse *)
val invert : t -> t

(* [det m] takes in a matrix of type t and returns its determinant *)
val det : t -> float

val eigenvector : t -> t 

val normalize : t -> t
