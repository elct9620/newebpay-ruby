# frozen_string_literal: true

module OffsitePayments
  module Integrations
    module Newebpay
      # The shared module for return and notification object
      #
      # @since 0.1.0
      module HasTradeInfo
        # Trade Information from NewebPay
        #
        # @return [Hash]
        #
        # @since 0.1.0
        def trade_info
          @trade_info ||=
            JSON.parse(key.decrypt(params['TradeInfo']))
        rescue JSON::ParserError, TypeError
          {}
        end

        # The TradeSha calculated in client-side
        #
        # @return [String]
        #
        # @since 0.1.0
        def checksum
          @checksum ||= key.checksum(params['TradeInfo'])
        end

        # Does TradeInfo is valid
        #
        # @return [TrueClass|FalseClass]
        #
        # @since 0.1.0
        def valid?
          checksum == params['TradeSha']
        end
      end
    end
  end
end
