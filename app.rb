require 'sinatra'
require 'markdiff'
require 'redcarpet'
require './model/markdown.rb'

markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

get '/' do
  send_file './public/index.html'
end

get '/diff/:before/:after/html' do |before, after|
  html_before = markdown.render(Md.find(before).markdown)
  html_after = markdown.render(Md.find(after).markdown)
  Markdiff::Differ.new.render(html_before, html_after).to_html
end

get '/list/html' do
  @numofmd = Md.count
  if @numofmd > 1
    @after = Md.last.id
    @before = Md.last(2).first.id
  end
  @mdlist = Md.order(id: :desc)
  erb :mdlist
end

get '/list/:before/:after/html' do |before, after|
  @numofmd = Md.count
  if @numofmd > 1
    if before < after
      @after = Md.find(after).id
      @before = Md.find(before).id
    else
      @after = Md.find(before).id
      @before = Md.find(after).id
    end
  end
  @mdlist = Md.order(id: :desc)
  erb :mdlist
end

post '/markdown' do
  Md.create({
    :markdown => request[:markdown],
  })
end

get '/markdown/:id/date' do |id|
  Md.find(id).created_at.in_time_zone('Asia/Tokyo').strftime("%Y-%m-%d %H:%M:%S")
end

get '/markdown/:id/raw' do |id|
  Md.find(id).markdown
end

get '/markdown/:id/html' do |id|
  markdown.render(Md.find(id).markdown)
end

put '/markdown/:id' do |id|
  item = Md.find(id)
  item.markdown = request[:markdown]
  item.save
end

delete '/markdown/:id' do |id|
  item = Md.find(id)
  item.destroy
end
