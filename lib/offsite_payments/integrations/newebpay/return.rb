# frozen_string_literal: true

module OffsitePayments
  module Integrations
    module Newebpay
      # The Return object from NewebPay
      #
      # @since 0.1.0
      class Return < OffsitePayments::Return
        include HasCipher
        include HasTradeInfo

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
      end
    end
  end
end
