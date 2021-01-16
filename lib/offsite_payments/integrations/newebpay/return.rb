# frozen_string_literal: true

module OffsitePayments
  module Integrations
    module Newebpay
      # The Return object from NewebPay
      #
      # @since 0.1.0
      class Return < OffsitePayments::Return
        # Trade Information from NewebPay
        #
        # @return [Hash]
        #
        # @since 0.1.0
        def trade_info
          @trade_info ||=
            JSON.parse(::Newebpay::Cipher.decrypt(params['TradeInfo']))
        rescue JSON::ParserError, TypeError
          {}
        end

        # Does payment success
        #
        # @return [TrueClass|FalseClass]
        #
        # @since 0.1.0
        def success?
          valid? && params['Status'] == 'SUCCESS'
        end

        # Does payment cancelled
        #
        # @return [TrueClass|FalseClass]
        #
        # @since 0.1.0
        def cancelled?
          !success?
        end

        # The Message from Newebpay
        #
        # @return [String]
        #
        # @since 0.1.0
        def message
          return unless valid?

          trade_info['Message']
        end

        # The TradeSha calculated in client-side
        #
        # @return [String]
        #
        # @since 0.1.0
        def checksum
          @checksum ||=
            Digest::SHA256
            .hexdigest("HashKey=#{::Newebpay::Config.hash_key}&" \
                       "#{params['TradeInfo']}&HashIV=#{::Newebpay::Config.hash_iv}")
            .upcase
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
