# fast_blank_ocaml

*DISCLAIMER*: I am not an expert in OCaml, C, Ruby, or native extensions.
This is just something I wanted to try out, and since I didn't find a lot of
info by googling, I decided to put this on GitHub and maybe someone will find
this useful.

### Description

This is an example of how to write a Ruby native extension in OCaml.
The code for `blank?` itself is in `ext/ocaml-blank/blank.ml`.

There's also a C wrapper in `ext/ocaml-blank/blank.c` which is required to make
a connection via FFI.

### Benchmark

To view the benchmark results (with comparison to
[fast_blank](https://github.com/SamSaffron/fast_blank)), see `benchmark.rb`.
Or, run it for yourself via `ruby benchmark.rb`.

### Contributing

Despite the gem's "it's just a test" status, issues and PRs are very welcome.
