module PageModels
  class BlinkboxbooksPage < SitePrism::Page
    section :footer, Footer, "#footer"
  end

  register_model_caller_method(BlinkboxbooksPage)
end