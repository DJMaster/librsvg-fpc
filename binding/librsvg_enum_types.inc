//
// rsvg.h header binding for the Free Pascal Compiler aka FPC
//
// Binaries and demos available at http://www.djmaster.com/
//

(* enumerations from "rsvg.h" *)
function rsvg_error_get_type(): GType; cdecl; external LIB_RSVG;
type RSVG_TYPE_ERROR = function(): GType; cdecl;
function rsvg_handle_flags_get_type(): GType; cdecl; external LIB_RSVG;
type RSVG_TYPE_HANDLE_FLAGS = function(): GType; cdecl;

