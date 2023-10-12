# coding: utf-8
module ApplicationHelper
  def link_to_add_fields(name, f, association, path)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(path + association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end


  def get_last_update_pages(permalink)
    group = @school.page_group.find_all_by_content_type(permalink)
    last = group.map(&:static_page).flatten.select(&:body).max_by(&:updated_at)
    return '(раздел не заполнен)' unless last
    '(последнее обновление ' + Russian::strftime(last.updated_at.to_date , "%d %B %Y") + ')'
  end

  def get_last_update_page(page)
    if page
      if page.body
        '(последнее обновление ' + Russian::strftime(page.updated_at, "%d %B %Y") + ')'
      else
        '(раздел не заполнен)'
      end
    else
      'Модуль'
    end
  end

  def last_update_link(link)
    temp = link.get_last_update
    if temp.blank?
      '(раздел не заполнен)'
    else
      if temp.to_s != '__'
        '(последнее обновление ' + Russian::strftime(temp, "%d %B %Y") + ')'
      else
        return 'Раздел не пуст'
      end
    end
  end

  def list_district()
    @count_of_district = @count_of_district + 1
    @count_of_district
  end

  def get_error(error)
    if error.errors.any?
      @error = error
      render 'admin/layouts/error_messanger'
    end
  end

  def get_static_page_title()
    static_page_title(@group.first.content_type)
  end

  def static_page_title(page)
    case page
    when 'about'
      return 'О школе'
    when 'training'
      return 'Обучение'
    when 'health'
      return 'Здоровье и сервис'
    else
      return "Error"
    end
  end

  def get_static_page_title_from_edit()
    static_page_title(get_page_group_title)
  end                             

  def get_page_group_title()
    return @page.page_group.content_type if @page
    link = [params[:group], params[:id]].compact.join('/')
    PageGroup.joins(:page_navigation_link).where(:school_id => @school.id, 'page_navigation_links.link' => link).first.content_type
  end    

  def rener_ckeditor(model, who)
    if who == 'body'
      render 'admin/layouts/ckedit_fileds', :f => model, :body => who, :size => 400, :toolbar => 'FullToolbar'
    else
      render 'admin/layouts/ckedit_fileds', :f => model, :body => who, :size => 200, :toolbar => 'FullToolbar'
    end
  end

  def rener_small_ckeditor(model, who, size=100)
    render 'admin/layouts/ckedit_fileds', :f => model, :body => who, :size => size, :toolbar => 'SmallToolbar'
  end

  def get_section_size_to_s(section)
    if section.size != 0 
      '(Всего ' + @school.section.size.to_s + ' кружков и секций)'
    else
      '(раздел не заполнен)'
    end
  end

  def get_school_news_note(news)
    unless news.empty?
      last = news.find_last
      "(#{news.size} #{Russian.p(news.size, "запись", "записи", "записей")}, последняя #{Russian::strftime(last.updated_at.to_date , "%d %B %Y")})"
    else
      '(раздел не заполнен)'
    end
  end

  def get_methodic_groops_note(docs)
    docs.size_of_doc.to_s+' '+Russian.p(docs.size_of_doc, "методический материал", "методических материала", "методических материалов")
  end

  def get_methodic_teacher_count(methodic)
    "В методическом объединении " + methodic.teacher.size.to_s + " " + Russian.p(methodic.teacher.size, "учитель", "учителя", "учителей")
  end

  def contact_nil()
    return !(@school.address.nil? || @school.phones.nil? || @school.mailto.nil? || @school.other_contact.nil?)
  end

  def static_page_index_navigation()
    case params[:link]
      when 'about'
        render 'about_page'
    end
  end

  def check_default_static_image(title)
    case title
    when "Знакомство со школой"
      return 'a_fs'
    when "Нормативная информация"
      return 'a_ni'
    when "Будущим ученикам"
      return 't_fp'
    when "Особенности обучения"
      return 't_os'
    when "Дополнительно"
      return 't_ad'
    when "Наши разработки"
      return 't_od'
    when "Сервис"
      return 'h_se'
    when "Медицина"
      return 'h_me'
    end
  end


  def youtube_embed(youtube_url)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end
    raw(%Q{ <iframe title="YouTube video player" width="500" height="300" src="https://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>})
  end
  
  def anons_datetime(announcement)
    if Time.now.year != announcement.start_date.year
      '~ '+Russian::strftime(announcement.start_date.to_datetime, " %d %B %Y, %H:%M")+' ~'
    else
      '~ '+Russian::strftime(announcement.start_date.to_datetime, " %d %B, %H:%M")+' ~'
    end 
  end

  def methodic_date(methodic)
    if Time.now.year != methodic.year
      Russian::strftime(methodic.to_datetime, " %d %B %Y")
    else
      Russian::strftime(methodic.to_datetime, " %d %B")
    end 
  end

  def get_news_type(news)
    case news.class.to_s
    when 'AnnounceToParent'
      return 'Объявления родителям'
    when 'Creation'
      return 'Творчество учеников'
    when 'News'
      return 'Новости'
    end
  end

  def get_news_link(news)
    case news.class.to_s
    when 'AnnounceToParent'
      return link_to news.title, school_announce_to_parent_path(@school, news)
    when 'Creation'
      return link_to news.title, school_creation_path(@school, news)
    when 'News'
      return link_to news.title, school_news_path(@school, news)
    end
  end

  def get_date_in_hyman(source)
    if Time.now.year != source.news_date.year
      Russian::strftime(source.news_date.to_date, "%d %B %Y")
    else
      Russian::strftime(source.news_date.to_date, "%d %B")
    end
  end

  def check_about_part(group)
    case group.title
    when 'Знакомство со школой'
      return true
    when 'Нормативная информация'
      return @school.document.blank?
    end
  end

  def teachers_without_methodic()
    @doc = []
    @school.teacher.each do |teacher|
      if !teacher.methodic_document.blank? && teacher.teacher_methodic_link.blank?
        @doc = @doc + teacher.methodic_document
      end
    end
  end

  # new method, added after 2012
  def get_news_navigation()
    content_tag(:ul, :class => "b-multi-menu") do
      concat get_news_navigation_link('Новости', 'news') if @school.news.count > 0
      concat get_news_navigation_link('Творчество учеников', 'creation') if @school.creation.count > 0
      concat get_news_navigation_link('Анонсы событий', 'announcement') if @school.announcement.count > 0
      concat get_news_navigation_link('Объявления родителям', 'announce_to_parents') if @school.announce_to_parent.count > 0
      concat get_news_navigation_link('Ежедневное меню', 'food') if @school.food.count > 0
    end
  end

  # <li class="item item-selected">
  #   <a href="/school/14/news" class="link">
  #     <i class="ribbon-l">
  #    </i>
  #     <i class="ribbon-r">
  #     </i>
  #     <span class="text">Новости</span>
  #     </a>
  # </li>
  def get_news_navigation_link(title, controller_title)
    if "#{controller_name}" == controller_title
      content_tag :li, :class => "item item-selected" do
        link_to({:controller => controller_title, :action => :index},{:class => 'link'}) do
          # + is not a good idea
          raw('<i class="ribbon-l"></i><i class="ribbon-r"></i>')+
          content_tag(:span , :class => "text") do
            title
          end
        end
      end
    else
      content_tag :li, :class => "item item" do
        link_to({:controller => controller_title,:action => :index},{:class => 'link'}) do
          content_tag(:span , :class => "text") do
            title
          end
        end
      end
    end # end if
  end

  def render_three_photo(data)
      render "common/three_photo", :data => data if !data.photo.blank?
  end

  def get_youtube_video(data)
    content_tag(:div, :class => "b-video") do youtube_embed(data.youtube) end if !data.youtube.blank?
  end
 
  # number_news == 1 - current year
  # number_news == n - first news from year b
  def get_news_page_number()
      if params[:page].nil?
        return 0
      else 
        return params[:page].to_i
      end
  end

  def get_news_page_year()
      if params[:year].nil?
        return 0
      else 
        return params[:year].to_i
      end
  end

  # def get_first_news_from_year(year)
  #   if year!=0
  #     News.where('extract(year  from news_date) = ?', year).first.id
  #   end
  #     return 0
  # end

  def get_news()
      get_news_by_number_page(get_news_page_year(),get_news_page_number())
  end

  def get_news_by_number_page(number_news,page)
      if number_news ==0
        case @type_news
          when 'announctoparent'
            return @school.announce_to_parent[page*10..page*10+9]
          when 'announcement'
            return @school.announcement[page*10..page*10+9]
          when 'creation'
            return @school.creation[page*10..page*10+9]
          when 'news'
            return @school.news[page*10..page*10+9]
          when 'food'
            return @school.food.group_by{|food| food.date.beginning_of_month}.to_a[page*10..page*10+9]
        end
      end
      # news=[]
      case @type_news
        when 'announctoparent'
          news = @school.announce_to_parent.where('extract(year  from news_date) = ?', number_news)
        when 'announcement'
          news = @school.announcement.where('extract(year  from start_date) = ?', number_news)
        when 'creation'
          news = @school.creation.where('extract(year  from news_date) = ?', number_news)
        when 'news'
          news = @school.news.where('extract(year  from news_date) = ?', number_news)
        when 'food'
          news = @school.food.where('extract(year  from date) = ?', number_news).group_by{|food| food.date.beginning_of_month}.to_a
      end
      if !news.nil?
        news[page*10..page*10+9]
      end
  end

  def get_next_page()
    if params[:year].nil?
      return '?page=' +(get_news_page_number()+1).to_s
    else
      return '?year='+ params[:year] +'&page=' +(get_news_page_number()+1).to_s 
    end
  end

  def check_next_page()
    if params[:year].nil?
      case @type_news
        when 'announctoparent'
          return ((get_news_page_number()+1)*10) < @school.announce_to_parent.size
        when 'announcement'
          return ((get_news_page_number()+1)*10) < @school.announcement.size
        when 'creation'
          return ((get_news_page_number()+1)*10) < @school.creation.size
        when 'news'
          return ((get_news_page_number()+1)*10) < @school.news.size
        when 'food'
          return ((get_news_page_number()+1)*10) < @school.food.group_by{|food| food.date.beginning_of_month}.size
      end
    else
      case @type_news
        when 'announctoparent'
          return ((get_news_page_number()+1)*10) < @school.announce_to_parent.where('extract(year  from news_date) = ?',  params[:year].to_i).size
        when 'announcement'
          return ((get_news_page_number()+1)*10) < @school.announcement.where('extract(year  from start_date) = ?',  params[:year].to_i).size
        when 'creation'
          return ((get_news_page_number()+1)*10) < @school.creation.where('extract(year  from news_date) = ?',  params[:year].to_i).size
        when 'news'
          return ((get_news_page_number()+1)*10) < @school.news.where('extract(year  from news_date) = ?',  params[:year].to_i).size
        when 'food'
          return ((get_news_page_number()+1)*10) < @school.food.where('extract(year  from date) = ?',  params[:year].to_i).group_by{|food| food.date.beginning_of_month}.size
      end
      # return ((get_news_page_number()+1)*2) < @school.news.where('extract(year  from news_date) = ?',  params[:year].to_i).size
    end
  end

  def get_year_period()
    case @type_news
      when 'announctoparent'
        return @school.announce_to_parent.group_by{|announce_to_parent| announce_to_parent.news_date.beginning_of_year}.keys.map(&:year)
      when 'announcement'
        return @school.announcement.group_by{|announcement| announcement.start_date.beginning_of_year}.keys.map(&:year)
      when 'creation'
        return @school.creation.group_by{|creation| creation.news_date.beginning_of_year}.keys.map(&:year)
      when 'news'
        return @school.news.group_by{|news| news.news_date.beginning_of_year}.keys.map(&:year)
      when 'food'
        return @school.food.group_by{|food| food.date.beginning_of_year}.keys.map(&:year)
    end
    # year = Time.now.year
    # var = [year]
    # while year>2012
    #   year = year -1
    #   var += [year]
    # end
    # return var
  end

  def finevision_button
    content_tag :button, class: "finevisionbutton", type: "button", onclick: "finevision.toggle(this)" do
      content_tag(:i, "Обычная версия", class: ["glyphicon glyphicon-eye-open bold", !finevision? ? "collapse" : nil].compact.join(' ')) +
      content_tag(:i, "Версия для слабовидящих", class: ["glyphicon glyphicon-eye-open bold", finevision? ? "collapse" : nil].compact.join(' '))        
    end
  end

  def render_static_page title, **params, &block
    layout = params[:controller] =~ /^admin\// ? 'static_page' : params[:group] || 'default'
    @title = title || @title || ''
    render layout: layout, locals: { link: params[:link], title: @title}, &block
  end

end
