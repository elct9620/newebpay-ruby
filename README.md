NewebPay
===

The [Offsite Payments](https://github.com/activemerchant/offsite_payments) implement for NewebPay（藍新金流）

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'newebpay'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install newebpay

## Usage

### Create payment button

In your controller

```ruby
options = {
  amount: 40, # TWD
  description: 'My Product',
  return_url: newebpay_return_url,
  notify_url: newebpay_notify_url
}

@helper = OffsitePayments.integration('newebpay').helper(order_id, merchant_id, options)
```

In your view

```erb
<!-- payment.erb -->

<form action="<%= OffsitePayments.integration('newebpay').service_url %>" method="POST">
  <% @helper.form_fields.each do |key, value| %>
    <input type="hidden" name="<%= key %>" value="<%= value %>" />
    <% end %>
  <button type="submit">Process</button>
</form>
```

> Above example is tested under Sinatra but you can use form helper in Rails to improve it.

### Process Return Data

In your controller

```ruby
@return = OffsitePayments.integration('newebpay').return(request.body.read)
@return.trade_info # The decrypted TradeInfo from NewebPay
```

> Please notice the `request.body` may cause Rails `params` not work due to we didn't rewind it

### Process Notification Data

In you controller

```ruby
@notification = OffsitePayments.integration('newebpay').notification(request.body.read)
@notification.trade_info # The decrypted TradeInfo from NewebPay
```

## Roadmap

* [x] MPG Support
* [ ] Rails Support
  * [ ] Form Object
  * [ ] Form Helper

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elct9620/newebpay-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/newebpay/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the Newebpay project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/elct9620/newebpay-ruby/blob/master/CODE_OF_CONDUCT.md).
