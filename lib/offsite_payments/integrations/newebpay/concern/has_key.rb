# frozen_string_literal: true

module OffsitePayments
  module Integrations
    module Newebpay
      # The shared module to get cipher
      #
      # @since 0.1.0
      module HasKey
        # The Key for encrypto and hashing
        #
        # @return [Hash]
        #
        # @since 0.1.0
        def key
          ::Newebpay::Key
            .new(key: ::Newebpay::Config.hash_key, iv: ::Newebpay::Config.hash_iv)
        end
      end
    end
  end
end
