# freegeoliteip

TODO: Write a description here

## Installation

```bash
git clone https://github.com/arubinofaux/freegeoliteip.git
cd freegeoliteip
shards install
```

## Usage
Prep local enviroment file
```bash
cp .env-example .env
```

Start the services
```bash
docker-compose up --build
```

visit `http://localhost:8080`

## API

Return the geolocation of the visiting computer, the source IP address of the connection.

```bash
curl --request GET --url http://localhost:8080
```

Return the geolocation of the specified IP address.
```bash
curl --request GET --url http://localhost:8080/104.16.181.15
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/arubinofaux/freegeoliteip/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [arubinofaux](https://github.com/arubinofaux) - creator and maintainer
