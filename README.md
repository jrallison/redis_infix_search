# Infix search with redis

A simple, and real-time infix search with redis.

    conn.index(1, "john@customer.io")
    conn.index(2, "jrallison@gmail.com")
    conn.index(3, "colin@customer.io")
    conn.index(3, "someone@custom.com")

    conn.search("custom") == [
      { id: 3, value: "colin@customer.io" },
      { id: 1, value: "john@customer.io" },
      { id: 4, value: "someone@custom.com" }
    ]

Results are ordered in the following order:

1. Exact matches
2. Prefix matches
3. Lexicographical order

**Note:** currently **very** memory intensive. experimental. :)

## Installation

`TODO`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
