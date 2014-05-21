module PageModels
  class HomePageCategory < PageModels::BlinkboxbooksSection
    elements :books, 'li', :visible => false
    elements :visible_books, 'li', :visible => true
  end
end