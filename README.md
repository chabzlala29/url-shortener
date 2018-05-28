# URL Shortener

##### Live application:

- Visit `https://byteurl-ly.herokuapp.com` for demo.


##### Thought process

- I've researched regarding URL shortener and checked how it works
  (reference: bitly.com)
  Basically creates a shortened url, when visited it will redirect to
the original url.
- I created the rough UI first with Bootstrap 4.
- Created 2 routes with controllers and appropriate views (create and new) with a form to accept original URL to be converted into short URL.
- Created a model Url with attributes `original_url` and `shorten_url`.
- Add a hooked method to generate short_url with `SecureRandom.base58`
  method. Basically avoid to generate the same shorten_url more than
once.
- I also decided to add `slugified_url` attribute to the table.
  Basically will try to generate the standard URL (Example:
www.somelink.com, https://somelink.com, SomeLink.com will all point to
http://somelink.com). The goal is to avoid duplicated entries.
- Created a new page show that shows some additional data from the
  Client user.
- I used `geocoder` gem to simplify the process of getting the IP, City,
  Country info from the User.
- I used `browser` gem to simpilfy the process of getting Device and
  browser info from the user using `HTTP_USER_AGENT`.
- Created a model named UrlInfo the belongs_to a specific Url. Basically
  contains all basic info from the Client (location, device, etc.).
- Used `kaminari` gem for pagination.
