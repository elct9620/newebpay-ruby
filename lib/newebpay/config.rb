# frozen_string_literal: true

require 'forwardable'

module Newebpay
  # Config of Newebpay
  #
  # @since 0.1.0
  class Config
    class << self
      extend Forwardable

      # @since 0.1.0
      LOCK = Mutex.new

      # Current activate config
      #
      # @since 0.1.0
      def current
        return @current if @current

        LOCK.synchronize do
          return @current if @current

          @current ||= new
        end

        @current
      end

      # Temporary switch to another config
      #
      # @since 0.2.0
      def switch(config, &_block)
        LOCK.synchronize do
          temp = @current
          @current = config
          yield @current if defined?(yield)
          @current = temp
        end
      end

      delegate %i[hash_key hash_iv config] => :current
    end

    # @since 0.1.0
    attr_accessor :hash_key, :hash_iv

    # Initialize
    #
    # @since 0.2.0
    def initialize(attributes = {}, &block)
      attributes.each do |name, value|
        send("#{name}=", value) if respond_to?("#{name}=")
      end

      config(&block) if defined?(yield)
    end

    # Update current config
    #
    # @since 0.1.0
    def config(&block)
      instance_exec(self, &block)
    end
  end
end
