module PageModels
  require 'utilities'
  class BlinkboxbooksSection < SitePrism::Section
    include RSpec::Matchers
    include WebUtilities
  end
end