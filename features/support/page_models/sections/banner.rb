module PageModels
  class Banner < PageModels::BlinkboxbooksSection
    elements :slides, '#slides ul li', :visible => false
    elements :images, '#slides ul img'
    elements :slide_numbers, '#active label'
  end
end