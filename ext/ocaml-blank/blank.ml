(* char codes taken from https://github.com/SamSaffron/fast_blank *)
let char_blank char =
  match int_of_char char with
  | 0x9 -> true (* tab *)
  | 0xA -> true (* line feed *)
  | 0xB -> true (* vertical tab *)
  | 0xC -> true (* form feed *)
  | 0xD -> true (* carriage return *)
  | 0x20 -> true (* space *)
  | 0x85 -> true
  | 0xA0 -> true (* nbsp *)
  | 0x1680 -> true
  | 0x2000 -> true
  | 0x2001 -> true
  | 0x2002 -> true
  | 0x2003 -> true
  | 0x2004 -> true
  | 0x2005 -> true
  | 0x2006 -> true
  | 0x2007 -> true
  | 0x2008 -> true
  | 0x2009 -> true
  | 0x200a -> true
  | 0x2028 -> true
  | 0x2029 -> true
  | 0x202f -> true
  | 0x205f -> true
  | 0x3000 -> true
  | _ -> false

let blank_by_char string length =
  let index = ref 0 in
  let result = ref true in
  while !index < length && !result do
    if not (char_blank string.[!index]) then
      result := false;
    index := !index + 1
  done;
  !result

let blank string =
  match String.length string with
  | 0 -> true
  | len -> blank_by_char string len

(* register callback for C *)
let _ = Callback.register "blank" blank
