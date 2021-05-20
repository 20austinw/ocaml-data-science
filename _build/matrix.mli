(** *)

type t

exception InvalidDimensions of string

(** [dim m] returns the dimensions of matrix m *)
val dim : t -> int * int

(** [matrix m] returns the the float list list representation of matrix
    m*)
val matrix : t -> float list list

(** [fill mat] returns a m x n matrix filled with float x *)
val fill : int -> int -> float -> t

(** [empty m n] produces an m by n matrix of 0's *)
val zero : int -> int -> t

(** [eye n] produces an n by n identity matrix *)
val eye : int -> t

(** [transpose t] transposes the matrix*)
val transpose : t -> t

(** [mult m1 m2] produces a new matrix of the product of m1 and m2 *)
val mult : t -> t -> t

(** [echelon m] returns the reduced form of matrix m*)
val rref : t -> t

(** [construct m] takes in a float list list and returns matrix and
    throws InvalidDimensions if rows are not of the same length *)
val construct : float list list -> t

(** [decomp m] produces a pair of matrices containing the LU
    decomposition of matrix m*)
val lu_decomp : t -> t * t

(** [concat m1 m2] concatenates m1 and m2 and returns the resulting
    matrix*)
val concat : t -> t -> t

(** [invert m] takes in a matrix of type t and returns the inverse *)
val invert : t -> t

(** [pinv m] takes in a matrix of type t and returns its pseudoinverse *)
val pinv : t -> t

(** [det m] takes in a matrix of type t and returns its determinant *)
val det : t -> float

(** [magnitude mat] takes in a matrix of type t and returns its
    magnitude Requires: t is a vector *)
val magnitude : t -> float

(** [normalize mat] takes in a matrix of type t and returns its norm
    Requires: t is a vector*)
val normalize : t -> t

(** [eigen mat dom] takes in a matrix of type t and returns a pair float
    * t containing the eigenvector and its associated eigenvalue. If dom
    is true then return the dominant eigenvector, else the smallest. *)
val eigen : t -> bool -> float * t

(** [elem_pow mat r] takes in a matrix of type t and performs
    element-wise power to the matrix *)
val elem_pow : t -> float -> t

(** [scale mat c] takes in a matrix of type t and scales it by factor of
    c*)
val scale : t -> float -> t

(** [op m1 m2 f] applies the operator f to pair of elements in m1 m2 and
    returns [\[f a1 b1; f a2 b2; ...\]; \[...\]] *)
val op : t -> t -> (float -> float -> float) -> t

(** [dot v1 v2] returns the dot product between two vectors. If v1 and
    v2 are two dimensional matrices instead, performs [mult v1 v2]*)
val dot : t -> t -> float

(** [elem_f m f] applies the element-wise function f to matrix m and
    returns the resulting matrix *)
val elem_f : t -> (float -> float) -> t
