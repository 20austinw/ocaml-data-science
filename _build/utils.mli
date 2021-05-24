(** Utility functions

    This module has useful functions to compare two lists*)

(** [diff a b] returns the difference between lists a and b *)
val diff : float list -> float list -> float list

(** [mean_squared_error y_true y_pred] returns the mean squared error
    between y_true and y_pred*)
val mean_squared_error : float list -> float list -> float

(** [distance a b] returns the distance between lists a and b *)
val distance : float list -> float list -> float

(** [accuracy y_true y_pred] returns the percentage of accurate values
    in y_pred compared to y_true *)
val accuracy : float list -> float list -> float
