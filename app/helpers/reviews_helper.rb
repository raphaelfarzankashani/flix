module ReviewsHelper

def format_average_stars(movie)
  if movie.average_stars.nil?
    content_tag(:strong, 'No reviews')
  else
   "*" * movie.average_stars.to_f.round 
  end
end

end
