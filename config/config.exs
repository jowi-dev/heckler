import Config

#config :heckler, Heckler.APNS,
#  adapter: Pigeon.APNS,
#  cert: File.read!("cert.pem"),
#  key: File.read!("cert.pem"),
#  mode: :dev

# Or for token based authentication:

config :heckler, Heckler.APNS,
  adapter: Pigeon.APNS,
  key: File.read!("AuthKey.p8"),
  key_identifier: "5XRLTUCS24",
  mode: :dev,
  team_id: "UPX69FSX5H"
