# frozen_string_literal: true
require 'haml/escapable'

module Haml
  # This module allows Temple::Filter to dispatch :fescape on `#compile`.
  module FescapeDispathcer
    def on_fescape(flag, exp)
      [:fescape, flag, compile(exp)]
    end
  end
  ::Temple::Filter.include FescapeDispathcer

  # Unlike Haml::Escapable, this escapes value even if it's html_safe.
  class ForceEscapable < Escapable
    def initialize(opts = {})
      super
      @escape_code = options[:escape_code] || "::Haml::Util.escape_html((%s))"
      @escaper = eval("proc {|v| #{@escape_code % 'v'} }")
    end

    alias_method :on_fescape, :on_escape

    # ForceEscapable doesn't touch :escape expression.
    # This method is not used if it's inserted after Haml::Escapable.
    def on_escape(flag, exp)
      [:escape, flag, compile(exp)]
    end
  end
end
