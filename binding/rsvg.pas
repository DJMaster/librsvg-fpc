//
// rsvg.h header binding for the Free Pascal Compiler aka FPC
//
// Binaries and demos available at http://www.djmaster.com/
//

(* -*- Mode: C; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- *)
(* vim: set sw=4 sts=4 ts=4 expandtab: *)
(* 
   rsvg.h: SAX-based renderer for SVG files into a GdkPixbuf.
 
   Copyright (C) 2000 Eazel, Inc.
  
   This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public License as
   published by the Free Software Foundation; either version 2 of the
   License, or (at your option) any later version.
  
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.
  
   You should have received a copy of the GNU Library General Public
   License along with this program; if not, write to the
   Free Software Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.
  
   Author: Raph Levien <raph@artofcode.com>
*)

unit rsvg;

{$mode objfpc}{$H+}
{$inline on}

interface

uses
  ctypes,
  glib2,
  gdk2pixbuf,
  cairo;

const
  LIB_RSVG = 'librsvg-2-2.dll';

type
  GQuark = TGQuark;
  GObject = TGObject;
  GObjectClass = TGObjectClass;

  PGCancellablePrivate = ^GCancellablePrivate;
  GCancellablePrivate = record
  (* Dummy typedef *)
  end;

  PGCancellable = ^GCancellable;
  GCancellable = record
    parent_instance: GObject;
    (*< private >*)
    priv: PGCancellablePrivate;
  end;

  PGFile = ^GFile;
  GFile = record
  (* Dummy typedef *)
  end;

  PGInputStreamPrivate = ^GInputStreamPrivate;
  GInputStreamPrivate = record
  end;

  PGInputStream = ^GInputStream;
  GInputStream = record
    parent_instance: GObject;
    (*< private >*)
    priv: PGInputStreamPrivate;
  end; 

//TODO #if defined(RSVG_DISABLE_DEPRECATION_WARNINGS) || !GLIB_CHECK_VERSION (2, 31, 0)
//TODO #define RSVG_DEPRECATED
//TODO #define RSVG_DEPRECATED_FOR(f)
//TODO #else
//TODO #define RSVG_DEPRECATED G_DEPRECATED
//TODO #define RSVG_DEPRECATED_FOR(f) G_DEPRECATED_FOR(f)
//TODO #endif

//TODO #define RSVG_TYPE_HANDLE                  (rsvg_handle_get_type ())
//TODO #define RSVG_HANDLE(obj)                  (G_TYPE_CHECK_INSTANCE_CAST ((obj), RSVG_TYPE_HANDLE, RsvgHandle))
//TODO #define RSVG_HANDLE_CLASS(klass)          (G_TYPE_CHECK_CLASS_CAST ((klass), RSVG_TYPE_HANDLE, RsvgHandleClass))
//TODO #define RSVG_IS_HANDLE(obj)               (G_TYPE_CHECK_INSTANCE_TYPE ((obj), RSVG_TYPE_HANDLE))
//TODO #define RSVG_IS_HANDLE_CLASS(klass)       (G_TYPE_CHECK_CLASS_TYPE ((klass), RSVG_TYPE_HANDLE))
//TODO #define RSVG_HANDLE_GET_CLASS(obj)        (G_TYPE_INSTANCE_GET_CLASS ((obj), RSVG_TYPE_HANDLE, RsvgHandleClass))

function rsvg_handle_get_type(): GType; cdecl; external LIB_RSVG;

(**
 * RsvgError:
 * @RSVG_ERROR_FAILED: the request failed
 *
 * An enumeration representing possible errors
 *)
type
  RsvgError = (
    RSVG_ERROR_FAILED
  );

type
  RSVG_ERROR = function(): GQuark;
function rsvg_error_quark(): GQuark; cdecl; external LIB_RSVG;

(**
 * RsvgHandleClass:
 * @parent: parent class
 *
 * Class structure for #RsvgHandle
 *)
type
  PRsvgHandleClass = ^RsvgHandleClass;
  RsvgHandleClass = record
    parent: GObjectClass;
    (*< private >*)
    _abi_padding: array[0..14] of gpointer ;
  end;

(**
 * RsvgHandle:
 *
 * The #RsvgHandle is an object representing the parsed form of a SVG
 *)
  PRsvgHandlePrivate = ^RsvgHandlePrivate;
  RsvgHandlePrivate = record
  end;

  PRsvgHandle = ^RsvgHandle;
  RsvgHandle = record
    parent: GObject;
    (*< private >*)
    priv: PRsvgHandlePrivate;
    _abi_padding: array[0..14] of gpointer ;
  end;

(**
 * RsvgDimensionData:
 * @width: SVG's width, in pixels
 * @height: SVG's height, in pixels
 * @em: em
 * @ex: ex
 *)
  PRsvgDimensionData = ^RsvgDimensionData;
  RsvgDimensionData = record
    width: cint;
    height: cint;
    em: gdouble;
    ex: gdouble;
  end;

(**
 * RsvgPositionData:
 * @x: position on the x axis
 * @y: position on the y axis
 *
 * Position of an SVG fragment.
 *)
  PRsvgPositionData = ^RsvgPositionData;
  RsvgPositionData = record
    x: cint;
    y: cint;
  end;

procedure rsvg_cleanup(); cdecl; external LIB_RSVG;

procedure rsvg_set_default_dpi(dpi: cdouble); cdecl; external LIB_RSVG;
procedure rsvg_set_default_dpi_x_y(dpi_x: cdouble; dpi_y: cdouble); cdecl; external LIB_RSVG;

procedure rsvg_handle_set_dpi(handle: PRsvgHandle; dpi: cdouble); cdecl; external LIB_RSVG;
procedure rsvg_handle_set_dpi_x_y(handle: PRsvgHandle; dpi_x: cdouble; dpi_y: cdouble); cdecl; external LIB_RSVG;

function rsvg_handle_new(): PRsvgHandle; cdecl; external LIB_RSVG;
function rsvg_handle_write(handle: PRsvgHandle; const buf: Pguchar; count: gsize; error: PPGError): gboolean; cdecl; external LIB_RSVG;
function rsvg_handle_close(handle: PRsvgHandle; error: PPGError): gboolean; cdecl; external LIB_RSVG;
function rsvg_handle_get_pixbuf(handle: PRsvgHandle): PGdkPixbuf; cdecl; external LIB_RSVG;
function rsvg_handle_get_pixbuf_sub(handle: PRsvgHandle; const id: PAnsiChar): PGdkPixbuf; cdecl; external LIB_RSVG;

function rsvg_handle_get_base_uri(handle: PRsvgHandle): PAnsiChar; cdecl; external LIB_RSVG;
procedure rsvg_handle_set_base_uri(handle: PRsvgHandle; const base_uri: PAnsiChar); cdecl; external LIB_RSVG;

procedure rsvg_handle_get_dimensions(handle: PRsvgHandle; dimension_data: PRsvgDimensionData); cdecl; external LIB_RSVG;

function rsvg_handle_get_dimensions_sub(handle: PRsvgHandle; dimension_data: PRsvgDimensionData; const id: PAnsiChar): gboolean; cdecl; external LIB_RSVG;
function rsvg_handle_get_position_sub(handle: PRsvgHandle; position_data: PRsvgPositionData; const id: PAnsiChar): gboolean; cdecl; external LIB_RSVG;

function rsvg_handle_has_sub(handle: PRsvgHandle; const id: PAnsiChar): gboolean; cdecl; external LIB_RSVG;

(* GIO APIs *)

(**
 * RsvgHandleFlags:
 * @RSVG_HANDLE_FLAGS_NONE: none
 * @RSVG_HANDLE_FLAG_UNLIMITED: Allow any SVG XML without size limitations.
 *   For security reasons, this should only be used for trusted input!
 *   Since: 2.40.3
 * @RSVG_HANDLE_FLAG_KEEP_IMAGE_DATA: Keeps the image data when loading images,
 *  for use by cairo when painting to e.g. a PDF surface. This will make the
 *  resulting PDF file smaller and faster.
 *  Since: 2.40.3
 *)
type
  RsvgHandleFlags (*< flags >*) = (
    RSVG_HANDLE_FLAGS_NONE = 0,
    RSVG_HANDLE_FLAG_UNLIMITED = 1 shl 0,
    RSVG_HANDLE_FLAG_KEEP_IMAGE_DATA = 1 shl 1
  );

function rsvg_handle_new_with_flags(flags: RsvgHandleFlags): PRsvgHandle; cdecl; external LIB_RSVG;

procedure rsvg_handle_set_base_gfile(handle: PRsvgHandle; base_file: PGFile); cdecl; external LIB_RSVG;

function rsvg_handle_read_stream_sync(handle: PRsvgHandle; stream: PGInputStream; cancellable: PGCancellable; error: PPGError): gboolean; cdecl; external LIB_RSVG;

function rsvg_handle_new_from_gfile_sync(_file: PGFile; flags: RsvgHandleFlags; cancellable: PGCancellable; error: PPGError): PRsvgHandle; cdecl; external LIB_RSVG;

function rsvg_handle_new_from_stream_sync(input_stream: PGInputStream; base_file: PGFile; flags: RsvgHandleFlags; cancellable: PGCancellable; error: PPGError): PRsvgHandle; cdecl; external LIB_RSVG;

function rsvg_handle_new_from_data(const data: Pguint8; data_len: gsize; error: PPGError): PRsvgHandle; cdecl; external LIB_RSVG;
function rsvg_handle_new_from_file(const file_name: Pgchar; error: PPGError): PRsvgHandle; cdecl; external LIB_RSVG;

procedure rsvg_handle_internal_set_testing(handle: PRsvgHandle; testing: gboolean); cdecl; external LIB_RSVG;

(* BEGIN deprecated APIs. Do not use! *)

procedure rsvg_init(); cdecl; external LIB_RSVG; (* RSVG_DEPRECATED_FOR(g_type_init) *)
procedure rsvg_term(); cdecl; external LIB_RSVG; (* RSVG_DEPRECATED *)

procedure rsvg_handle_free(handle: PRsvgHandle); cdecl; external LIB_RSVG; (* RSVG_DEPRECATED_FOR(g_object_unref) *)

(**
 * RsvgSizeFunc:
 * @width: (out): the width of the SVG
 * @height: (out): the height of the SVG
 * @user_data: user data
 *
 * Function to let a user of the library specify the SVG's dimensions
 *
 * Deprecated: Set up a cairo matrix and use rsvg_handle_render_cairo() instead.
 * See the documentation for rsvg_handle_set_size_callback() for an example.
 *)
type
  RsvgSizeFunc = procedure(width: Pgint; height: Pgint; user_data: gpointer); (* RSVG_DEPRECATED *)
  GDestroyNotify = procedure(data: gpointer); cdecl;

procedure rsvg_handle_set_size_callback(handle: PRsvgHandle; size_func: RsvgSizeFunc; user_data: gpointer; user_data_destroy: GDestroyNotify); cdecl; external LIB_RSVG; (* RSVG_DEPRECATED *)

(* GdkPixbuf convenience API *)

function rsvg_pixbuf_from_file(const file_name: Pgchar; error: PPGError): PGdkPixbuf; cdecl; external LIB_RSVG; (* RSVG_DEPRECATED *)
function rsvg_pixbuf_from_file_at_zoom(const file_name: Pgchar; x_zoom: double; y_zoom: double; error: PPGError): PGdkPixbuf; cdecl; external LIB_RSVG; (* RSVG_DEPRECATED *)
function rsvg_pixbuf_from_file_at_size(const file_name: Pgchar; width: gint; height: gint; error: PPGError): PGdkPixbuf; cdecl; external LIB_RSVG; (* RSVG_DEPRECATED *)
function rsvg_pixbuf_from_file_at_max_size(const file_name: Pgchar; max_width: gint; max_height: gint; error: PPGError): PGdkPixbuf; cdecl; external LIB_RSVG; (* RSVG_DEPRECATED *)
function rsvg_pixbuf_from_file_at_zoom_with_max(const file_name: Pgchar; x_zoom: double; y_zoom: double; max_width: gint; max_height: gint; error: PPGError): PGdkPixbuf; cdecl; external LIB_RSVG; (* RSVG_DEPRECATED *)

function rsvg_handle_get_title(handle: PRsvgHandle): PAnsiChar; cdecl; external LIB_RSVG; (* RSVG_DEPRECATED *)
function rsvg_handle_get_desc(handle: PRsvgHandle): PAnsiChar; cdecl; external LIB_RSVG; (* RSVG_DEPRECATED *)
function rsvg_handle_get_metadata(handle: PRsvgHandle): PAnsiChar; cdecl; external LIB_RSVG; (* RSVG_DEPRECATED *)

(* END deprecated APIs. *)

{$include librsvg_enum_types.inc}
{$include librsvg_features.inc}
{$include rsvg_cairo.inc}


implementation

function librsvg_check_version(major,minor,micro: cint): gboolean; cdecl; inline;
begin
  Result := (_LIBRSVG_MAJOR_VERSION > major) or
            ((_LIBRSVG_MAJOR_VERSION = major) and (_LIBRSVG_MINOR_VERSION > minor)) or
            ((_LIBRSVG_MAJOR_VERSION = major) and (_LIBRSVG_MINOR_VERSION = minor) and (_LIBRSVG_MICRO_VERSION >= micro));
end;

function librsvg_major_version(): guint; cdecl; inline;
begin
  Result := _LIBRSVG_MAJOR_VERSION;
end;
  
function librsvg_minor_version(): guint; cdecl; inline;
begin
  Result := _LIBRSVG_MINOR_VERSION;
end;

function librsvg_micro_version(): guint; cdecl; inline;
begin
  Result := _LIBRSVG_MICRO_VERSION
end;

function librsvg_version(): pchar; cdecl; inline;
begin
  Result := _LIBRSVG_VERSION;
end;


end.

