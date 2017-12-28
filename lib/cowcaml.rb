# frozen_string_literal: true

require 'ffi'

module Cowcaml
  module Base
    extend FFI::Library
    ffi_lib File.expand_path('../libblank.so', __FILE__)
    attach_function :blank, [:string], :bool
    attach_function :startup, [:string], :void
  end
  Base.startup ''
end
