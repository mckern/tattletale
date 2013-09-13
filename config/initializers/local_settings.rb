YAML.load_file("#{::Rails.root}/config/tattletale.yml")[Rails.env].each_pair do |key,value|
  Tattletale::Application.config.send("#{key}=", value)
end
