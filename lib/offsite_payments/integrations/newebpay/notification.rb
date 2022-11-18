# frozen_string_literal: true

module OffsitePayments
  module Integrations
    module Newebpay
      # The Notification object from NewebPay
      #
      # @since 0.1.0
      class Notification < OffsitePayments::Notification
        include HasCipher
        include HasTradeInfo

        # @return [String]
        #
        # @since 0.1.0
        def status
          trade_info['Status']
        end

        # @return [Number]
        #
        # @since 0.1.0
        def gross
          trade_info.dig('Result', 'Amt')&.to_i
        end

        # The Newebpay use TWD as currency
        #
        # @return [String]
        #
        # @since 0.1.0
        def currency
          :TWD
        end
      end
    end
  end
end
