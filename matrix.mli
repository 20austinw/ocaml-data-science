type t

exception InvalidDimensions

(* [dim m] returns the dimensions of matrix t *)
val dim : t -> int * int

(* [matrix t] returns the matrix within t *)
val matrix : t -> float list list

(* [fill mat] returns a m x n matrix of type t filled with float x *)
val fill : int -> int -> float -> t

(* [empty m n] produces an m by n matrix of 0's *)
val zero : int -> int -> t

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

(* [pinv m] takes in a matrix of type t and returns its pseudoinverse *)
val pinv : t -> t

(* [det m] takes in a matrix of type t and returns its determinant *)
val det : t -> float

(* [magnitude mat] takes in a matrix of type t and returns its magnitude
   Requires: t is a vector *)
val magnitude : t -> float

(* [normalize mat] takes in a matrix of type t and returns its norm 
   Requires: t is a vector*)
val normalize : t -> t

(* [eigen mat dom] takes in a matrix of type t and returns a pair float * t 
containing the eigenvector and its associated eigenvalue. If dom is true then 
return the dominant eigenvector, else the smallest. *)
val eigen : t -> bool -> float * t

(* [elem_pow] takes in a matrix of type t and performs element-wise 
   power to the matrix *)
val elem_pow : t -> float -> t
