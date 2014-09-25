module ApplicationHelper

  def shallow_args(parent, child, name_space)
    return child.try(:new_record?) ? [name_space, parent, child].compact : [name_space, child].compact
  end

  def show_title
    return "#{t('views.header.title')} - #{@media[:media_id]}の画像"
  end

  def show_description
    text = []
    text << "カテゴリー：#{@tag.category.name}"
    text << "タグ：#{@tag.name}"
    text << "投稿者：#{@media[:user][:username]}"
    text << "メディア：#{@media[:media_id]}"
    text << "いいね数：#{@media[:likes][:count]}"
    text << "コメント数：#{@media[:comments][:count]}"
    return text.join('、')
  end

end
