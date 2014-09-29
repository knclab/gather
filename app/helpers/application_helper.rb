module ApplicationHelper

  def shallow_args(parent, child, name_space)
    return child.try(:new_record?) ? [name_space, parent, child].compact : [name_space, child].compact
  end

  def show_title
    if params[:action] == 'show'
      return "#{t('views.header.title')} - #{@media[:user][:username]}の画像 #{@media[:id]}"
    elsif params[:action] == 'user'
      return "#{t('views.header.title')} - #{@user[:username]}の画像"
    end
  end

  def show_description
    text = []
    if params[:action] == 'show'
      text << "カテゴリー：ファッション/コーディネート"
      #text << "タグ：#{@tag.name}"
      text << "投稿者：#{@media[:user][:username]}"
      text << "メディア：#{@media[:id]}"
      text << "いいね数：#{@media[:likes][:count]}"
      text << "コメント数：#{@media[:comments][:count]}"
    elsif params[:action] == 'user'
      text << "カテゴリー：ファッション/コーディネート"
      text << "投稿者：#{@user[:username]}"
      text << "メディア数：#{@user[:counts][:media]}"
      text << "フォロー数：#{@user[:counts][:followed_by]}"
      text << "フォロワー数：#{@user[:counts][:follows]}"
    end
    return text.join('、')
  end

end
