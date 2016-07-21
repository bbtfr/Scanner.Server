module ApplicationHelper

  # Kaminari monkey patch
  # Trivial modification to take into account the current locale while pluralizing the items name.
  def page_entries_info(collection, options = {})
    entry_name = options[:entry_name] || collection.entry_name
    entry_name = entry_name.pluralize(I18n.locale) unless collection.total_count == 1

    if collection.total_pages < 2
      t('helpers.page_entries_info.one_page.display_entries', :entry_name => entry_name, :count => collection.total_count)
    else
      first = collection.offset_value + 1
      last = (sum = collection.offset_value + collection.limit_value) > collection.total_count ? collection.total_count : sum
      t('helpers.page_entries_info.more_pages.display_entries', :entry_name => entry_name, :first => first, :last => last, :total => collection.total_count)
    end.html_safe
  end

  def bootstrap_class_for flash_type
    { success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    times = '&times;'.html_safe
    flash.map do |msg_type, message|
      content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
        concat content_tag(:button, times, class: 'close', data: { dismiss: 'alert' })
        concat message
      end
    end.join.html_safe
  end

end
