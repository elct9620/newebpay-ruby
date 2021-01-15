# frozen_string_literal: true

require 'forwardable'

module Newebpay
  # Config of Newebpay
  #
  # @since 0.1.0
  class Config
    class << self
      extend Forwardable

      # Current activate config
      #
      # @since 0.1.0
      def current
        @current ||= new
      end

      delegate %i[hash_key hash_iv config] => :current
    end

    # @since 0.1.0
    attr_accessor :hash_key, :hash_iv

    # Update current config
    #
    # @since 0.1.0
    def config(&block)
      instance_exec(&block)
    end
  end
end
