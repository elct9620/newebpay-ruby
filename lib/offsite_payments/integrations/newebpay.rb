# frozen_string_literal: true

require 'offsite_payments'
module OffsitePayments
  module Integrations
    # NewebPay Integrations
    #
    # @since 0.1.0
    module Newebpay
      VERSION = '1.5'

      mattr_accessor :test_url
      self.test_url = 'https://ccore.newebpay.com/MPG/mpg_gateway'

      mattr_accessor :live_url
      self.live_url = 'https://core.newebpay.com/MPG/mpg_gateway'

      # Current service URL
      #
      # @return [String]
      #
      # @since 0.1.0
      def self.service_url
        case OffsitePayments.mode
        when :production then live_url
        when :test then test_url
        else
          raise StandardError, "Integration mode set to an invalid value: #{OffsitePayments.mode}"
        end
      end

      require 'offsite_payments/integrations/newebpay/concern/has_trade_info'
      require 'offsite_payments/integrations/newebpay/helper'
      require 'offsite_payments/integrations/newebpay/return'
      require 'offsite_payments/integrations/newebpay/notification'

      # Alias to create helper
      #
      # @param [String] order ID
      # @param [String] merchant ID
      # @param [Hash] options
      #
      # @since 0.1.0
      def self.helper(order, merchant, options = {})
        OffsitePayments::Integrations::Newebpay::Helper.new(order, merchant, options)
      end

      # Alias to create return object
      #
      # @param [String] query string
      # @param [Hash] options
      #
      # @since 0.1.0
      def self.return(query_string, options = {})
        OffsitePayments::Integrations::Newebpay::Return.new(query_string, options)
      end

      # Alias to create notification object
      #
      # @param [String] query string
      # @param [Hash] options
      #
      # @since 0.1.0
      def self.notification(query_string, options = {})
        OffsitePayments::Integrations::Newebpay::Notification.new(query_string, options)
      end
    end
  end
end
