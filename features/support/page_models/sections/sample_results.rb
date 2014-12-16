module PageModels
  class SampleResults < PageModels::BlinkboxbooksSection
    sections :samples, Sample, 'li.book_entry'
  end
end