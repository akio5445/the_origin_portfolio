require 'rouge/plugins/redcarpet'

class HTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

module MarkdownHelper
  def markdown(text)
    options = {
      # htmlを出力しない
      filter_html:   true,
      # <img>タグを生成しない
      no_images:     true,
      # <style>タグを生成しない
      no_styles:     true,
      # 見出しにアンカーを付ける
      with_toc_data: true,
      # 改行を<br>タグに変換
      hard_wrap:     true,
      # 題名を表すハッシュ(#)と文字の間にスペースが必要
      space_after_headers: true
    }

    extensions = {
      # <>で囲まれていなくてもリンクを認識する
      autolink:           true,
      # フェンスのあるコードブロックを認識する
      fenced_code_blocks: true,
      # HTMLブロックを空行で囲む必要はない
      lax_spacing:        true,
      # 単語中の強調を強調と認識しない
      no_intra_emphasis:  true,
      # ~(チルダ)2つで取り消し線を表現する
      strikethrough:      true,
      # の後ろが上付き文字になる(文章が少し上に表示される)
      superscript:        true,
      # テーブルを認識する
      tables:             true
    }

    unless @markdown
      # Redcarpet::Render::HTML => HTML に変更
      renderer = HTML.new(options)
      @markdown = Redcarpet::Markdown.new(renderer, extensions)
    end

    @markdown.render(text).html_safe
  end

  def toc(text)
    toc_option = {
      nesting_level: 1
    }

    toc_renderer = Redcarpet::Render::HTML_TOC.new
    toc = Redcarpet::Markdown.new(toc_renderer, toc_option)
    toc.render(text).html_safe
  end
end
