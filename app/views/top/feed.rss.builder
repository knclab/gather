xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
xml.rss("version"    => '2.0',
        "xmlns:dc"   => "http://purl.org/dc/elements/1.1/",
        "xmlns:atom" => "http://www.w3.org/2005/Atom") do
  xml.channel do
    xml.title t('views.header.title')
    xml.description t('views.header.description')
    xml.language "ja-ja"
    xml.ttl "40"
    xml.pubDate(Time.now.strftime("%a, %d %b %Y %H:%M:%S %Z"))

    @results.each do |media|
      xml.item do
        xml.title t('views.header.title')
        xml.guid show_url(media[:id])
        xml.link show_url(media[:id])
        xml.description media[:caption][:text]
        xml.pubDate Time.at(media[:created_time].to_i).strftime("%a, %d %b %Y %H:%M:%S %Z")
        xml.author media[:user][:username]
        xml.enclosure media[:images][:standard_resolution][:url]
        xml.source media[:images][:standard_resolution][:url]
      end
    end
  end
end
