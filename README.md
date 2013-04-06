## :DRUNKEN-DANGERZONE
This is a simple in-memory key value store with a REST API interface. It
was written to learn play with web development in Common Lisp. Haters are
welcome. There is a [Go analogue](https://github.com/gokyle/drunken_dangerzone),
and a [Clojure analogue](https://github.com/kisom/clj-drunken-dangerzone)
as well.

### DRUNKEN-DANGERZONE? WHAT KIND OF NAME IS THAT?
It was recommended by the Github project name generator.

### DEPENDENCIES
* This has only been tested using sbcl.
* You need to have quicklisp installed and loaded (i.e. via your .sbclrc)
   before running this.

### RUNNING

0. Load the server with `sbcl --load drunken-dangerzone.lisp`
0. At the REPL, enter `(run)`.
0. By default, the server runs on port 8080. To change this,
   `(setf *port* <new port>)`.

### LICENSE:
DRUNKEN-DANGERZONE is released under the ISC license.

    Copyright (c) 2013 Kyle Isom <coder@kyleisom.net>
     
    Permission to use, copy, modify, and distribute this software for any
    purpose with or without fee is hereby granted, provided that the above 
    copyright notice and this permission notice appear in all copies.
     
    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE. 
