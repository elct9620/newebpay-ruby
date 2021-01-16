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

      require 'offsite_payments/integrations/newebpay/helper'
      require 'offsite_payments/integrations/newebpay/return'
    end
  end
end
