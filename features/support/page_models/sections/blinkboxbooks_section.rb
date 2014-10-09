module PageModels
  class BlinkboxbooksSection < SitePrism::Section
    include RSpec::Matchers
    include WebUtilities
    include WaitSteps
  end
end