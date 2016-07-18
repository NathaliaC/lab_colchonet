module RoomsHelper
  def error_tag(model, attribute)
    if model.errors.has_key? attribute
      content_tag :div, model.errors[attribute].first,
        :class => 'error_message'
    end
  end

  def belongs_to_user(room)
    raise room.inspect
    user_signed_in? && room.user == current_user
  end
end
