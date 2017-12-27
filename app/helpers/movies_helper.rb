module MoviesHelper
  def format_total_gross(movie)
    if movie.flop?
      content_tag(:strong, 'Flop!')
    else
      number_to_currency(movie.total_gross)
    end
  end

  def image_for(movie)
    if movie.image_file_name.blank?
      image_tag('placeholder.png')
    else
      image_tag(movie.image_file_name)
    end
  end

  def nav_link_to(pagename,path)
    if current_page?(path)
      link_to pagename, path, class: ["active"]
    else
      link_to pagename, path, class: ["button"]
    end
  end

end

  

