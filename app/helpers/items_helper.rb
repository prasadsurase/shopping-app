module ItemsHelper

  def item_image(name)
    "#{name.downcase.gsub(' ', '-')}.jpg"
  end
end
