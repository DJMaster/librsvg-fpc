//
// rsvg.h header binding for the Free Pascal Compiler aka FPC
//
// Binaries and demos available at http://www.djmaster.com/
//

const
  _LIBRSVG_MAJOR_VERSION = 2;
  _LIBRSVG_MINOR_VERSION = 40;
  _LIBRSVG_MICRO_VERSION = 18;
  _LIBRSVG_VERSION = '2.40.18';

function librsvg_check_version(major,minor,micro: cint): gboolean; cdecl; inline;

const
  LIBRSVG_HAVE_SVGZ = True;
  LIBRSVG_HAVE_CSS = True;

//TODO #define LIBRSVG_CHECK_FEATURE(FEATURE) (defined(LIBRSVG_HAVE_##FEATURE) && LIBRSVG_HAVE_##FEATURE)

function librsvg_major_version(): guint; cdecl; inline;
function librsvg_minor_version(): guint; cdecl; inline;
function librsvg_micro_version(): guint; cdecl; inline;
function librsvg_version(): pchar; cdecl; inline;

