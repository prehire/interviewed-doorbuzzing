class User < ActiveRecord::Base
  PLAN_NAMES = ['apartment', 'office', 'office_premium']
  COUNTRY_CODES = {
    "US":{  
      "isoCode":"US",
      "friendlyName":"United States",
      "countryCode":"+1",
      "capabilities":"local voice,local sms,local mms,tollfree voice,tollfree sms,search by location"
    },
    "AU":{  
      "isoCode":"AU",
      "friendlyName":"Australia",
      "countryCode":"+61",
      "capabilities":"local voice,mobile sms"
    },
    "AT":{  
      "isoCode":"AT",
      "friendlyName":"Austria",
      "countryCode":"+43",
      "capabilities":"local voice,mobile sms,local domestic only"
    },
    "BH":{  
      "isoCode":"BH",
      "friendlyName":"Bahrain",
      "countryCode":"+973",
      "capabilities":"local voice"
    },
    "BE":{  
      "isoCode":"BE",
      "friendlyName":"Belgium",
      "countryCode":"+32",
      "capabilities":"local voice,mobile sms"
    },
    "BR":{  
      "isoCode":"BR",
      "friendlyName":"Brazil",
      "countryCode":"+55",
      "capabilities":"local voice"
    },
    "BG":{  
      "isoCode":"BG",
      "friendlyName":"Bulgaria",
      "countryCode":"+359",
      "capabilities":"local voice"
    },
    "CA":{  
      "isoCode":"CA",
      "friendlyName":"Canada",
      "countryCode":"+1",
      "capabilities":"local voice,local sms,local mms,tollfree voice,tollfree sms,search by location,paypal payments"
    },
    "CY":{  
      "isoCode":"CY",
      "friendlyName":"Cyprus",
      "countryCode":"+357",
      "capabilities":"local voice"
    },
    "CZ":{  
      "isoCode":"CZ",
      "friendlyName":"Czech Republic",
      "countryCode":"+420",
      "capabilities":"local voice"
    },
    "DK":{  
      "isoCode":"DK",
      "friendlyName":"Denmark",
      "countryCode":"+45",
      "capabilities":"local voice"
    },
    "DO":{  
      "isoCode":"DO",
      "friendlyName":"Dominican Republic",
      "countryCode":"+1829",
      "capabilities":"local voice"
    },
    "SV":{  
      "isoCode":"SV",
      "friendlyName":"El Salvador",
      "countryCode":"+503",
      "capabilities":"local voice"
    },
    "EE":{  
      "isoCode":"EE",
      "friendlyName":"Estonia",
      "countryCode":"+372",
      "capabilities":"local voice,mobile sms"
    },
    "FI":{  
      "isoCode":"FI",
      "friendlyName":"Finland",
      "countryCode":"+358",
      "capabilities":"local voice,mobile sms"
    },
    "FR":{  
      "isoCode":"FR",
      "friendlyName":"France",
      "countryCode":"+33",
      "capabilities":"local voice,local domestic only,paypal payments"
    },
    "DE":{  
      "isoCode":"DE",
      "friendlyName":"Germany",
      "countryCode":"+49",
      "capabilities":"local voice,mobile voice,mobile sms,paypal payments"
    },
    "GR":{  
      "isoCode":"GR",
      "friendlyName":"Greece",
      "countryCode":"+30",
      "capabilities":"local voice"
    },
    "HK":{  
      "isoCode":"HK",
      "friendlyName":"Hong Kong",
      "countryCode":"+852",
      "capabilities":"local voice,mobile sms,mobile domestic only"
    },
    "IE":{  
      "isoCode":"IE",
      "friendlyName":"Ireland",
      "countryCode":"+353",
      "capabilities":"local voice,mobile sms"
    },
    "IL":{  
      "isoCode":"IL",
      "friendlyName":"Israel",
      "countryCode":"+972",
      "capabilities":"local voice"
    },
    "IT":{  
      "isoCode":"IT",
      "friendlyName":"Italy",
      "countryCode":"+39",
      "capabilities":"local voice"
    },
    "JP":{  
      "isoCode":"JP",
      "friendlyName":"Japan",
      "countryCode":"+81",
      "capabilities":"local voice"
    },
    "LV":{  
      "isoCode":"LV",
      "friendlyName":"Latvia",
      "countryCode":"+371",
      "capabilities":"local voice"
    },
    "LT":{  
      "isoCode":"LT",
      "friendlyName":"Lithuania",
      "countryCode":"+370",
      "capabilities":"local voice,mobile sms,mobile domestic only"
    },
    "LU":{  
      "isoCode":"LU",
      "friendlyName":"Luxembourg",
      "countryCode":"+352",
      "capabilities":"local voice"
    },
    "MT":{  
      "isoCode":"MT",
      "friendlyName":"Malta",
      "countryCode":"+356",
      "capabilities":"local voice"
    },
    "MX":{  
      "isoCode":"MX",
      "friendlyName":"Mexico",
      "countryCode":"+52",
      "capabilities":"local voice"
    },
    "NL":{  
      "isoCode":"NL",
      "friendlyName":"Netherlands",
      "countryCode":"+31",
      "capabilities":"local voice"
    },
    "NZ":{  
      "isoCode":"NZ",
      "friendlyName":"New Zealand",
      "countryCode":"+64",
      "capabilities":"local voice"
    },
    "NO":{  
      "isoCode":"NO",
      "friendlyName":"Norway",
      "countryCode":"+47",
      "capabilities":"mobile sms"
    },
    "PE":{  
      "isoCode":"PE",
      "friendlyName":"Peru",
      "countryCode":"+51",
      "capabilities":"local voice"
    },
    "PL":{  
      "isoCode":"PL",
      "friendlyName":"Poland",
      "countryCode":"+48",
      "capabilities":"local voice,mobile sms"
    },
    "PT":{  
      "isoCode":"PT",
      "friendlyName":"Portugal",
      "countryCode":"+351",
      "capabilities":"local voice"
    },
    "PR":{  
      "isoCode":"PR",
      "friendlyName":"Puerto Rico",
      "countryCode":"+1",
      "capabilities":"local voice,local sms"
    },
    "RO":{  
      "isoCode":"RO",
      "friendlyName":"Romania",
      "countryCode":"+40",
      "capabilities":"local voice"
    },
    "SK":{  
      "isoCode":"SK",
      "friendlyName":"Slovakia",
      "countryCode":"+421",
      "capabilities":"local voice"
    },
    "ZA":{  
      "isoCode":"ZA",
      "friendlyName":"South Africa",
      "countryCode":"+27",
      "capabilities":"local voice,local domestic only"
    },
    "ES":{  
      "isoCode":"ES",
      "friendlyName":"Spain",
      "countryCode":"+34",
      "capabilities":"local voice,local sms,local domestic only"
    },
    "SE":{  
      "isoCode":"SE",
      "friendlyName":"Sweden",
      "countryCode":"+46",
      "capabilities":"local voice,mobile sms"
    },
    "CH":{  
      "isoCode":"CH",
      "friendlyName":"Switzerland",
      "countryCode":"+41",
      "capabilities":"local voice,mobile sms"
    },
    "GB":{  
      "isoCode":"GB",
      "friendlyName":"United Kingdom",
      "countryCode":"+44",
      "capabilities":"local voice,local sms,mobile sms,tollfree voice,paypal payments"
    }
  }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  has_many :destinations
  has_many :schedules
  has_many :codes

  # Normalizes the attribute itself before validation
  phony_normalize :phone_inbound

  validates :plan_name, inclusion: {in: PLAN_NAMES }, allow_nil: true  
  validates :timezone, inclusion: ActiveSupport::TimeZone.zones_map.values.map{|zone| zone.name}, if: Proc.new { |e| e.plan_name.present? }
  validates :phone_inbound, presence: true, if: Proc.new { |e| e.plan_name.present? }
  validates :country_code, presence: true, if: Proc.new { |e| e.plan_name.present? }
  # validates :dtmf, presence: true, if: Proc.new { |e| e.plan_name.present? }

  validates_plausible_phone :phone_inbound, country_code: :country_code

end
