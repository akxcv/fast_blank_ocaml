#include <stdbool.h>
#include <string.h>
#include <caml/alloc.h>
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/callback.h>

void startup (char** argv) {
  caml_startup(argv);
}

bool blank (const char* string) {
  CAMLparam0();
  CAMLlocal1(ostring);
  static value* closure = NULL;
  if (closure == NULL)
    closure = caml_named_value("blank");
  ostring = caml_copy_string(string); // this is probably slowing things down
  CAMLreturn(Bool_val(caml_callback(*closure, ostring)));
}
