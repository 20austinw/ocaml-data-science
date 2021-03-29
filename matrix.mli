type t

exception InvalidDimensions

val dim : t -> int * int
(** [dim m] returns the dimensions of matrix t *)

val matrix : t -> float list list
(** [matrix t] returns the matrix within t *)

val fill : int -> int -> float -> t
(** [fill mat] returns a m x n matrix of type t filled with float x *)

val zero : int -> int -> t
(** [empty m n] produces an m by n matrix of 0's *)

val eye : int -> t
(** [eye n] produces an n by n identity matrix *)

val transpose : t -> t
(** [transpose t] transposes the matrix in t *)

val mult : t -> t -> t
(** [mult t1 t2] produces a new matrix of the product of t1 and t2 *)

val rref : t -> t
(** [echelon t] returns the reduced form of matrix m*)

val construct : float list list -> t
(** [construct m] takes in a float list list and returns of matrix of
   type t and throws InvalidDimensions if rows are not of the same
   length *)

val lu_decomp : t -> t * t
(** [decomp m] takes in type t and produces a pair of type t containing
   the LU decomposition of matrix in t *)

val concat : t -> t -> t
(** [concat m1 m2] takes in two matrices of type t and returns a
   concatenated matrix of type t *)

val invert : t -> t
(** [invert m] takes in a matrix of type t and returns the inverse *)

val pinv : t -> t
(** [pinv m] takes in a matrix of type t and returns its pseudoinverse *)

val det : t -> float
(** [det m] takes in a matrix of type t and returns its determinant *)

val magnitude : t -> float
(** [magnitude mat] takes in a matrix of type t and returns its magnitude
   Requires: t is a vector *)

val normalize : t -> t
(** [normalize mat] takes in a matrix of type t and returns its norm 
   Requires: t is a vector*)

val eigen : t -> bool -> float * t
(** [eigen mat dom] takes in a matrix of type t and returns a pair float * t 
containing the eigenvector and its associated eigenvalue. If dom is true then 
return the dominant eigenvector, else the smallest. *)

val elem_pow : t -> float -> t
(** [elem_pow mat r] takes in a matrix of type t and performs element-wise 
power to the matrix *)

val scale : t -> float -> t
(** [scale mat c] takes in a matrix of type t and scales it by factor of c*)

val op : t -> t -> (float -> float -> float) -> t
(** [op m1 m2 f] applies the operator f to pair of elements in m1 m2 and
returns [[f a1 b1; f a2 b2; ...]; [...]] *)

val dot : t -> t -> float
(** [dot v1 v2] returns the dot product between two vectors. If 
v1 and v2 are two dimensional matrices instead, performs [mult v1 v2]*)
