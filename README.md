CDR-8 - An implementation of Generic Equality and Comparison for Common Lisp

This library is a portable implementation of [CDR 8][1].

In short, this provides hooks for user-defined equality (`EQUALS`) and
comparison (`COMPARE`) in addition to the expected defaults to the standard
equality operators of Common Lisp.

Please note that this is still work in progress.  Similarly, I'm in a
bit of a disagreement with the specified API and also unclear about some
of the options, cf. `recursive`.

[1]: http://cdr.eurolisp.org/document/8/ "CDR 8"
